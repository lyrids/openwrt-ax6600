#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0-only
"""Source-bound offload lifetime regressions; no network or DUT access."""
from pathlib import Path
import json
import os
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
NSS = ROOT / "package/kernel/nss-wifi-drv/src"
PPE = ROOT / "target/linux/qualcommax/files/drivers/net/ethernet/qualcomm/qca_ppe_flow_offload.c"

def function(source, name):
    match = re.search(r"^(?:static )?(?:inline )?(?:struct sk_buff \*|int|void|bool)\s*" +
                      re.escape(name) + r"\([^;{}]*\)\s*\{", source, re.M)
    assert match, name
    begin = source.index("{", match.start())
    end, depth = begin + 1, 1
    while depth:
        depth += (source[end] == "{") - (source[end] == "}")
        end += 1
    return source[match.start():end]

COMMON = r"""
#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
typedef uint64_t u64;
typedef uint32_t u32;
typedef uint16_t u16;
typedef uint8_t u8;
typedef uint64_t dma_addr_t;
#define ENOSPC 28
#define ENOENT 2
#define EIO 5
#define U32_MAX UINT32_MAX
#define ARRAY_SIZE(a) (sizeof(a)/sizeof((a)[0]))
#define lower_32_bits(x) ((u32)(x))
#define upper_32_bits(x) ((u32)((x)>>32))
#define READ_ONCE(x) (x)
#define WRITE_ONCE(x,v) ((x)=(v))
#define lockdep_assert_held(p) ((void)0)
static pthread_mutex_t *take_lock(pthread_mutex_t *p) {pthread_mutex_lock(p);return p;}
static void drop_lock(pthread_mutex_t **p) {pthread_mutex_unlock(*p);}
#define AUTO_LOCK(p) pthread_mutex_t *held __attribute__((cleanup(drop_lock)))=take_lock(p)
"""

def registry():
    src = (NSS / "nss_ring.c").read_text()
    funcs = "\n".join(function(src, n) for n in ["nss_lent_take", "nss_lent_claim"])
    funcs = funcs.replace("guard(spinlock_bh)(&core->lent_lock);",
                          "AUTO_LOCK(&core->lent_lock);")
    return COMMON + r"""
struct sk_buff {u32 marker;};
struct nss_lent_buffer {struct sk_buff *skb;dma_addr_t dma;u32 generation;};
struct nss_core {struct nss_lent_buffer *lent;u32 *lent_free;u32 lent_free_n,lent_size;pthread_mutex_t lent_lock;};
struct n2h_descriptor {u64 opaque;u32 buffer;};
""" + funcs + r"""
struct thread_arg {struct nss_core *core;struct n2h_descriptor desc;struct sk_buff *result;};
static void *claim_thread(void *arg) {struct thread_arg *a=arg;a->result=nss_lent_claim(a->core,&a->desc);return NULL;}
int main(void) {
struct nss_lent_buffer records[2]={0};u32 slots[2]={0,1};
struct nss_core c={records,slots,2,2,PTHREAD_MUTEX_INITIALIZER};
u64 first,second;int slot;
struct sk_buff *a=malloc(sizeof(*a));a->marker=101;
slot=nss_lent_take(&c,a,42,&first);assert(slot>=0);
struct n2h_descriptor d={first,42},bad=d;
bad.opaque=0xffffffffffffffffULL;assert(!nss_lent_claim(&c,&bad));
bad=d;bad.buffer=43;assert(!nss_lent_claim(&c,&bad));
assert(nss_lent_claim(&c,&d)==a);free(a);
assert(!nss_lent_claim(&c,&d)); /* ASan: duplicate cannot touch freed skb. */
a=malloc(sizeof(*a));slot=nss_lent_take(&c,a,42,&second);assert(slot>=0&&first!=second);
assert(!nss_lent_claim(&c,&d)); /* Same slot/DMA, obsolete generation. */
d.opaque=second;
struct thread_arg args[2]={{&c,d,NULL},{&c,d,NULL}};
pthread_t threads[2];
for(int i=0;i<2;i++)assert(!pthread_create(&threads[i],NULL,claim_thread,&args[i]));
for(int i=0;i<2;i++)pthread_join(threads[i],NULL);
assert((args[0].result==a)+(args[1].result==a)==1);free(a);
assert(c.lent_free_n==2);
c.lent[c.lent_free[c.lent_free_n-1]].generation=U32_MAX;
a=malloc(sizeof(*a));assert(nss_lent_take(&c,a,42,&second)==-ENOSPC);free(a);
assert(c.lent_free_n==1); /* Exhausted slot is not recycled into an old token. */
puts("registry: duplicate, corrupt, stale, concurrent claim and generation exhaustion passed");
return 0;
}
"""

def soc_stop():
    src = (NSS / "nss_wifili.c").read_text()
    return COMMON + r"""
#define NSS_WIFILI_STOP_MSG 1
#define NSS_WIFILI_PDEV_DEINIT_MSG 2
#define NSS_WIFILI_SOC_RESET_MSG 3
#define dev_info(...) ((void)0)
#define dev_warn(...) ((void)0)
struct nss_core {void *dev;bool wifili_started;};
struct nss_wifili_soc {int radio_if[1];struct {u32 radio_id;} pdev[1];bool started;};
struct nss_wifili_pdev_deinit_msg {u32 ifnum;};
static struct {void *dev;struct nss_wifili_soc *soc;} nss_wifili_vdev_tbl[1];
static struct {void *mem;struct nss_wifili_soc *soc;} nss_wifili_peer_tbl[1];
static int fail_type,freed,quiesced,faulted;
static void nss_wifili_vdev_release(struct nss_core*c,int i) {(void)c;(void)i;}
static void nss_wifili_peer_release(struct nss_core*c,int i) {(void)c;(void)i;}
static int nss_wifili_soc_msg(struct nss_core*c,struct nss_wifili_soc*s,int t,const void*d,size_t n) {return t==fail_type?-5:0;}
static int nss_wifili_soc_ifnum(struct nss_wifili_soc*s) {return 1;}
static void nss_wifili_radio_free(struct nss_core*c,struct nss_wifili_soc*s,int i) {}
static bool nss_wifili_any_started(void) {return false;}
static void nss_wifili_txdesc_free(struct nss_core*c,struct nss_wifili_soc*s) {freed++;}
static void nss_core_quiesce(struct nss_core*c) {quiesced++;}
static void nss_core_fault(struct nss_core*c) {faulted++;}
""" + function(src, "nss_wifili_soc_stop") + r"""
int main(void) {
for(int f=0;f<=3;f++) {
 struct nss_core c={0};struct nss_wifili_soc s={.radio_if={1},.started=true};
 fail_type=f;freed=quiesced=faulted=0;nss_wifili_soc_stop(&c,&s);
 assert(!s.started);
 assert(freed==(f==0));assert(quiesced==(f!=0));assert(faulted==(f!=0));
}
puts("SoC stop: ACK releases; STOP/DEINIT/RESET failures retain and quiesce");
return 0;
}
"""

def ppe_delete():
    src = PPE.read_text()
    return COMMON + r"""
struct nf_conn {int ct_general;};
struct qca_ppe_priv {int flow_lock,vlan_lock;};
struct ppe_flow_entry {bool uncertain;u32 index,host_index;int xdev;unsigned long ct;};
static int age_result,delete_result,released,deleted,cleared;
static int ppe_flow_entry_age(struct qca_ppe_priv*p,struct ppe_flow_entry*e) {return age_result;}
static u32 ppe_flow_counter_delta(struct qca_ppe_priv*p,struct ppe_flow_entry*e,u64*b) {*b=0;return 0;}
static void ppe_flow_account(struct qca_ppe_priv*p,struct ppe_flow_entry*e,u32 n,u64 b) {}
static int ppe_flow_entry_delete(struct qca_ppe_priv*p,u32 i) {deleted++;return delete_result;}
static void ppe_flow_slot_clear(struct qca_ppe_priv*p,struct ppe_flow_entry*e,u32 i) {cleared++;}
static void nf_conntrack_put(int*p) {released++;}
static void ppe_host_ref_put(struct qca_ppe_priv*p,u32 i) {released++;}
static void ppe_flow_free_egress(struct qca_ppe_priv*p,struct ppe_flow_entry*e) {released++;}
static void ppe_flow_free_ingress(struct qca_ppe_priv*p,struct ppe_flow_entry*e) {released++;}
""" + function(src, "ppe_flow_entry_destroy") + r"""
int main(void) {
struct qca_ppe_priv p={0};struct nf_conn ct={1};
struct ppe_flow_entry e={.ct=(unsigned long)&ct,.xdev=1};
for(int test=0;test<5;test++) {
 age_result=test==0?-110:(test==3?-ENOENT:1);
 delete_result=test==1?-110:0;e.uncertain=test==4;
 released=deleted=cleared=0;
 int rc=ppe_flow_entry_destroy(&p,&e);
 if(test==0||test==1||test==4) {assert(rc<0);assert(!released&&!cleared);}
 else {assert(!rc&&released==4&&cleared==1);}
}
puts("CPPE deletion: unknown GET/DEL retains resources; confirmed absence releases");
return 0;
}
"""

def packet_match():
    src = PPE.read_text()
    return COMMON + r"""
#include <arpa/inet.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/ipv6.h>
#define FLOW_DISSECTOR_KEY_IPV4_ADDRS 1
#define FLOW_DISSECTOR_KEY_IPV6_ADDRS 2
struct net_device;
""" + re.search(r"struct ppe_flow_data \{.*?\n\};", src, re.S).group() + r"""
struct ppe_flow_cpu {struct ppe_flow_data key;u32 mtu;};
struct sk_buff {unsigned char *data;unsigned int len;};
static unsigned int skb_network_offset(const struct sk_buff*s) {return ETH_HLEN;}
static struct ethhdr *eth_hdr(const struct sk_buff*s) {return (void*)s->data;}
static bool ether_addr_equal(const u8*a,const u8*b) {return !memcmp(a,b,6);}
static bool ipv6_addr_equal(const struct in6_addr*a,const struct in6_addr*b) {return !memcmp(a,b,sizeof(*a));}
static const void *skb_header_pointer(const struct sk_buff*s,unsigned int off,unsigned int len,void*buf) {return off<=s->len&&len<=s->len-off?s->data+off:NULL;}
""" + function(src, "ppe_flow_cpu_match") + r"""
int main(void) {
unsigned char data[1600]={0};struct sk_buff skb={data,ETH_HLEN+1400};
struct ppe_flow_cpu cpu={.mtu=1400};
struct iphdr *ip=(void*)(data+ETH_HLEN);__be16 *ports=(void*)(ip+1);
cpu.key.addr_type=FLOW_DISSECTOR_KEY_IPV4_ADDRS;cpu.key.l4proto=17;
cpu.key.v4_src_new=htonl(0x0a000001);cpu.key.v4_dst_new=htonl(0x0a000002);
cpu.key.sport_new=htons(1000);cpu.key.dport_new=htons(2000);
ip->version=4;ip->ihl=5;ip->protocol=17;ip->tot_len=htons(1400);
ip->saddr=cpu.key.v4_src_new;ip->daddr=cpu.key.v4_dst_new;
ports[0]=cpu.key.sport_new;ports[1]=cpu.key.dport_new;
assert(ppe_flow_cpu_match(&cpu,&skb));
ip->tot_len=htons(1401);skb.len++;assert(!ppe_flow_cpu_match(&cpu,&skb));
ip->tot_len=htons(1400);ports[0]=htons(999);assert(!ppe_flow_cpu_match(&cpu,&skb));
ports[0]=cpu.key.sport_new;skb.len=ETH_HLEN+19;assert(!ppe_flow_cpu_match(&cpu,&skb));
memset(data,0,sizeof(data));skb.len=ETH_HLEN+1280;cpu.mtu=1280;
cpu.key.addr_type=FLOW_DISSECTOR_KEY_IPV6_ADDRS;
struct ipv6hdr *ip6=(void*)(data+ETH_HLEN);ip6->version=6;ip6->nexthdr=17;ip6->payload_len=htons(1240);
ports=(void*)(ip6+1);ports[0]=cpu.key.sport_new;ports[1]=cpu.key.dport_new;
assert(ppe_flow_cpu_match(&cpu,&skb));
ip6->payload_len=htons(1241);skb.len++;assert(!ppe_flow_cpu_match(&cpu,&skb));
puts("CPU record: IPv4/IPv6 boundaries, stale tuple and truncated header passed");
return 0;
}
"""

def main():
    results = []
    with tempfile.TemporaryDirectory(prefix="offload-lifetime-") as temp:
        for name, source in [("nss-registry", registry()), ("soc-stop", soc_stop()),
                             ("cppe-delete", ppe_delete()), ("cpu-packet", packet_match())]:
            path = Path(temp) / (name + ".c")
            exe = Path(temp) / name
            path.write_text(source)
            cmd = ["gcc", "-std=gnu11", "-O1", "-g", "-fno-omit-frame-pointer",
                   "-fsanitize=address,undefined", "-no-pie", "-pthread",
                   str(path), "-o", str(exe)]
            subprocess.run(cmd, check=True)
            run = subprocess.run([str(exe)], check=True, text=True, capture_output=True,
                                 env={**os.environ, "ASAN_OPTIONS": "detect_leaks=1:halt_on_error=1"})
            results.append({"name": name, "result": "pass", "output": run.stdout.strip()})
    # Fail-closed CPU admission is intentional until row publication is qualified.
    src = PPE.read_text()
    start = src.index("static int ppe_flow_offload_replace(")
    section = src[start:src.index("\nstatic int ppe_flow_offload_destroy(", start)]
    assert section.index("if (entry->xdev) {") < section.index("ppe_flow_encode(")
    assert "goto err_egress;" in section[section.index("if (entry->xdev) {"):section.index("ppe_flow_encode(")]
    print(json.dumps({"checks": results, "cpu_egress_software_fallback": True,
                      "scope": "extracted production functions with userspace kernel-service stubs; no DUT/firmware execution"}, indent=2))

if __name__ == "__main__":
    main()

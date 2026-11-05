#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
typedef uint32_t u32;
typedef uint64_t u64;
#define READ_ONCE(x) (x)
#define min_t(t,a,b) ((t)(a)<(t)(b)?(t)(a):(t)(b))
#define scoped_guard(x) for (int once = 1; once; once = 0)
#define guard(x) (void)
#define container_of(ptr,type,member) ((type *)((char *)(ptr)-offsetof(type,member)))
#define __free(x) __attribute__((cleanup(free_pointer)))
#define GFP_KERNEL 0
#define FLOW_OFFLOAD_DIR_MAX 2
#define FLOW_OFFLOAD_XMIT_DIRECT 1
#define FLOW_OFFLOAD_XMIT_NEIGH 2
#define FLOW_DISSECTOR_KEY_IPV6_ADDRS 6
#define IS_ERR(p) false
#define NOTIFY_DONE 0
#define dev_err_ratelimited(...) ((void)0)
enum {NETDEV_PRECHANGEMTU=1,NETDEV_CHANGEMTU,NETDEV_CHANGEUPPER,NETDEV_CHANGEADDR,NETDEV_DOWN,NETDEV_UNREGISTER};
enum {NSS_INTERFACE_IPV4=4,NSS_INTERFACE_IPV6=6,NSS_IPV4_TX_DESTROY_RULE_MSG=10,NSS_IPV6_TX_DESTROY_RULE_MSG=20,NSS_IPV4_DR_NO_CONNECTION_ENTRY_ERROR=44,NSS_IPV6_DR_NO_CONNECTION_ENTRY_ERROR=66};
struct net {int id;};static struct net init_net, other_net={1};
struct net_device {int ifindex;u32 mtu;struct net *net;struct net_device *upper;char name[16];};
static struct net_device devices[8];
static struct net *dev_net(const struct net_device *d){return d->net;}
static bool net_eq(struct net *a,struct net *b){return a==b;}
static struct net_device *dev_get_by_index_rcu(struct net *n,int i){for(int j=0;j<8;j++)if(devices[j].net==n&&devices[j].ifindex==i&&i)return &devices[j];return NULL;}
static bool netdev_has_upper_dev_all_rcu(struct net_device *d,struct net_device *u){while(d->upper){d=d->upper;if(d==u)return true;}return false;}
static struct net_device *netdev_notifier_info_to_dev(void *p){return p;}
struct flow_offload_tuple {int iifidx,xmit_type,ifidx,dir;struct{int ifidx;}out;u32 mtu,mtu_ifindex,mtu_device;};
struct flow_offload_tuple_rhash{struct flow_offload_tuple tuple;};
struct flow_offload{struct flow_offload_tuple_rhash tuplehash[2];bool torn_down;};
struct ppe_flow_data{struct net_device *odev;u32 mtu;int l3if;int addr_type;};
struct ppe_flow_entry{unsigned long cookie;int l3if;};struct qca_ppe_priv{int unused;};
struct list_head{struct list_head *next,*prev;};
#define LIST_HEAD(n) struct list_head n={&(n),&(n)}
static void list_add_tail(struct list_head *n,struct list_head *h){n->prev=h->prev;n->next=h;h->prev->next=n;h->prev=n;}
static void list_del(struct list_head *n){n->prev->next=n->next;n->next->prev=n->prev;}
#define list_for_each_entry_safe(p,n,h,m) for(p=container_of((h)->next,__typeof__(*p),m),n=container_of(p->m.next,__typeof__(*p),m);&p->m!=(h);p=n,n=container_of(n->m.next,__typeof__(*n),m))
static LIST_HEAD(nss_flow_retired);static u32 nss_flow_retired_count;
struct nss_flow_entry{int node;struct list_head retired;void *ppe_block,*pppoe;unsigned long flow;struct{int ifindex;}dir[2];bool bridged,installed,v6;int t4,t6;};
struct nss_core{bool running;void *dev;};static struct nss_core core={.running=true},*nss_flow_core=&core;
static bool nss_flow_reconfig,rtnl_locked;static u32 nss_flow_mtu_invalidated,nss_flow_mtu_delete_failed,nss_flow_mtu_transition_rejected;static int nss_flow_lock;
static bool rtnl_is_locked(void){return rtnl_locked;}
struct cm{int interface,type,error;};
struct nss_ipv4_msg{struct cm cm;struct{struct{int tuple;}rule_destroy;}msg;};
struct nss_ipv6_msg{struct cm cm;struct{struct{int tuple;}rule_destroy;}msg;};
static int send_result,send_error,send_count;static bool fail_alloc;
static void *kzalloc(size_t n,int flags){if(fail_alloc)return NULL;return calloc(1,n);}
static void free_pointer(void *p){free(*(void **)p);}
static int nss_msg_send_quiet(struct nss_core *c,void *p,size_t n){struct cm *cm=p;cm->error=send_error;send_count++;return send_result;}
struct notifier_block{int unused;};
static int notifier_from_errno(int e){return e;}
static void flow_offload_teardown(struct flow_offload *f){f->torn_down=true;}
static struct nss_flow_entry *entries[4];static int nss_flow_table;
struct rhashtable_iter{int pos;};
static void rhashtable_walk_enter(int *t,struct rhashtable_iter *i){i->pos=0;}
static void rhashtable_walk_start(struct rhashtable_iter *i){}
static struct nss_flow_entry *rhashtable_walk_next(struct rhashtable_iter *i){while(i->pos<4){struct nss_flow_entry *e=entries[i->pos++];if(e)return e;}return NULL;}
static void rhashtable_walk_stop(struct rhashtable_iter *i){}
static void rhashtable_walk_exit(struct rhashtable_iter *i){}


#define PPPOE_SES_HLEN 8
#define ETH_HLEN 14
#define VLAN_HLEN 4
#define PPE_L3_IF_MTU 16383
#define FIELD_MAX(x) (x)

static int nss_flow_ht_params,freed_count,pppoe_put_count;
#define kfree_rcu(e,member) ((void)(e),freed_count++)
static void nss_flow_pppoe_put(struct nss_core *c,void *p){pppoe_put_count++;}
static int rhashtable_remove_fast(int *t,int *node,int params){struct nss_flow_entry *e=container_of(node,struct nss_flow_entry,node);for(int i=0;i<4;i++)if(entries[i]==e)entries[i]=NULL;return 0;}

static bool ppe_logical_mtu_offload;

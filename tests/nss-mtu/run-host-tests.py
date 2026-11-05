#!/usr/bin/env python3
"""Compile the production MTU functions against deterministic netdev/firmware mocks."""
from pathlib import Path
import argparse, subprocess, json, re
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
root=Path(__file__).resolve().parents[2]; a.output.mkdir(parents=True,exist_ok=True)
def function(path,name):
 s=(root/path).read_text();m=re.search(r'^static (?:bool|int|u32|void) '+name+r'\(',s,re.M);assert m,name
 x=s.index('{',m.start());level=1;y=x+1
 while level:
  level+=(s[y]=='{')-(s[y]=='}');y+=1
 return s[m.start():y]+'\n'
ppe='target/linux/qualcommax/files/drivers/net/ethernet/qualcomm/qca_ppe_flow_offload.c'
nss='package/kernel/nss-wifi-drv/src/nss_flow.c'
s=(Path(__file__).parent/'mocks.c').read_text()
for file,name in [(ppe,'ppe_flow_mtu_supported'),(ppe,'ppe_flow_l3_mtu'),(ppe,'ppe_flow_resolve_mtu'),(ppe,'ppe_flow_depends_on'),(nss,'nss_flow_admission_blocked'),(nss,'nss_flow_depends_on'),(nss,'nss_flow_withdraw_checked'),(nss,'nss_flow_forget'),(nss,'nss_flow_retry_retired'),(nss,'nss_flow_netdev_event')]:
 s+=function(file,name)
s+=(Path(__file__).parent/'cases.c').read_text()
(a.output/'host-tests.c').write_text(s)
command=['cc','-std=gnu11','-g','-O1','-Wall','-Wextra','-Werror','-Wno-unused-parameter','-Wno-unused-function','-fsanitize=address,undefined',str(a.output/'host-tests.c'),'-o',str(a.output/'host-tests')]
subprocess.run(command,check=True)
r=subprocess.run([str(a.output/'host-tests')],capture_output=True,text=True)
(a.output/'result.json').write_text(json.dumps({'command':command,'exit_code':r.returncode,'stdout':r.stdout,'stderr':r.stderr},indent=2)+'\n')
print(r.stdout,end='');print(r.stderr,end='');raise SystemExit(r.returncode)

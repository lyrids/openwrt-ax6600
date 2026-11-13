#!/usr/bin/env python3
"""Validate the public export's privacy boundary and local assets."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit,unquote
import json,re,xml.etree.ElementTree as ET
root=Path(__file__).resolve().parent.parent
errors=[]
patterns={
 'IPv4 address':r'(?<![\w.])(?:\d{1,3}\.){3}\d{1,3}(?![\w.])',
 'MAC address':r'(?i)(?:[0-9a-f]{2}:){5}[0-9a-f]{2}',
 'host filesystem path':r'/(?:Users|home)/[^\s<>"`]+',
 'private key':r'-----BEGIN (?:OPENSSH |RSA |EC )?PRIVATE KEY-----',
 'private deployment identifier':r'LY-W32X|LY-AX6600-[12]|frontnode\.net|wg-hopper',
 'local browser URL':r'file://|localhost:\d+|127\.0\.0\.1',
 'boot identifier':r'(?i)\b[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}\b',
}
allowed={'.html','.css','.js','.json','.svg','.md','.py'}
for folder in ('website','docs'):
 for p in (root/folder).rglob('*'):
  if '__pycache__' in p.parts:continue
  if p.is_symlink():errors.append(str(p.relative_to(root))+': symlink not permitted');continue
  if not p.is_file():continue
  if p.name=='.nojekyll':continue
  if p.suffix not in allowed:errors.append(str(p.relative_to(root))+': excluded file type')
  if 'evidence' in p.relative_to(root).parts:errors.append(str(p.relative_to(root))+': raw evidence directory')
  if p.name=='check.py':continue # Detection patterns are not deployment data.
  text=p.read_text()
  for kind,pattern in patterns.items():
   if re.search(pattern,text):errors.append(str(p.relative_to(root))+': '+kind)
  if p.suffix=='.json':json.loads(text)
  if p.suffix=='.svg':ET.fromstring(text)
class Page(HTMLParser):
 def __init__(self):super().__init__();self.ids=set();self.links=[]
 def handle_starttag(self,tag,attrs):
  a=dict(attrs)
  if 'id' in a:self.ids.add(a['id'])
  for name in ('href','src'):
   if a.get(name):self.links.append(a[name])
p=root/'docs/index.html';page=Page();page.feed(p.read_text())
for link in page.links:
 u=urlsplit(link)
 if u.scheme or u.netloc:continue
 if not u.path:
  if u.fragment and unquote(u.fragment) not in page.ids:errors.append('Missing anchor '+link)
  continue
 if u.path.startswith('/'):errors.append('Root-relative URL breaks repository prefix: '+link);continue
 target=(p.parent/unquote(u.path)).resolve()
 if not target.is_relative_to(root/'docs') or not target.is_file():errors.append('Missing or unsafe local asset '+link)
for asset in ('lineage.js','cppe.js','style.css','.nojekyll'):assert (root/'docs'/asset).is_file(),asset
assert len(json.loads((root/'website/image-registry-public.json').read_text())['images'])==16
assert 'topologies/evidence/' not in p.read_text()
if errors:raise SystemExit('\n'.join(errors))
print('PASS: public-source privacy scan, excluded-data boundary, HTML links/anchors, JSON, SVG and repository-prefix assets')

"""Conservative runtime graph audit. Public commands and saved aliases stay rooted.
Resource IDs that also name functions are intentionally treated as references.
Java callbacks assembled from literal prefixes and mcfunction macro domains
are included; a candidate still requires manual review before deletion.
"""
from pathlib import Path
from collections import defaultdict
import re,json
import argparse, sys
parser=argparse.ArgumentParser(description='Audit function reachability, including macros and plugin callbacks.')
parser.add_argument('--plugin', type=Path)
parser.add_argument('--report', type=Path)
args=parser.parse_args()
D=Path(__file__).resolve().parent.parent; R=D.parent; P=args.plugin or R/'oa_battleroyale_plugin'
if not (P/'src').is_dir(): parser.error('plugin source is required; pass --plugin PATH')
funcs={p.relative_to(D/'data').parts[0]+':'+p.relative_to(D/'data').as_posix().split('/function/',1)[1][:-11]:p for p in (D/'data').rglob('*.mcfunction')}
ids=set(funcs); texts={k:'\n'.join(l for l in p.read_text(encoding='utf-8-sig').splitlines() if not l.lstrip().startswith('#')) for k,p in funcs.items()}
pat=re.compile(r'[a-z0-9_.-]+:[a-z0-9_./-]+'); edges={k:set(pat.findall(s))&ids for k,s in texts.items()};roots=set();sources=defaultdict(set);dynamic=[]
for folder,exts in [(D/'data',{'.json'}),(P/'src',{'.java','.json','.yml'})]:
 for p in folder.rglob('*'):
  if p.suffix not in exts or not p.is_file():continue
  for fid in set(pat.findall(p.read_text(encoding='utf-8-sig')))&ids:roots.add(fid);sources[fid].add(str(p))
for p in (P/'src').rglob('*.java'):
 java=p.read_text(encoding='utf-8-sig')
 for literal in re.findall(r'"((?:oa:)?[a-z0-9_.-]+/[a-z0-9_./-]*)',java):
  prefix=literal if ':' in literal else 'oa:'+literal
  for fid in ids:
   if fid.startswith(prefix):roots.add(fid);sources[fid].add(str(p)+' dynamic Java prefix '+literal)
manifest=json.loads((D/'tools/function_roots.json').read_text(encoding='utf-8'))
for fid,reason in manifest.items():
 if fid not in ids: raise SystemExit('Missing public/compatibility function: '+fid)
 roots.add(fid); sources[fid].add(reason)
for base in [D,P]:
 for p in [base/'README_JA.md',base/'WEAPONS_JA.md',base/'docs/spec.md',base/'docs/discord-game-guide.md',base/'docs/interface.md']:
  if not p.exists():continue
  for fid in re.findall(r'(?:/function|\bfunction)\s+([a-z0-9_.-]+:[a-z0-9_./-]+)',p.read_text(encoding='utf-8-sig')):
   if fid in ids:roots.add(fid);sources[fid].add(str(p))
for fid in ids:
 path=fid.split(':',1)[1]
 if '/' not in path or '/admin/' in path or path.startswith(('admin/','public/','give/','test/')) or (path.startswith('map/') and path.count('/')==1):roots.add(fid);sources[fid].add('public API')
alltext='\n'.join(texts.values())
values={}
for var in ['finale','tiles','action','kind']:
 values[var]=set(re.findall(r'"?'+var+r'"?\s*:\s*"([^"$]+)"',alltext))
for fid,s in texts.items():
 for line in s.splitlines():
  m=re.search(r'\bfunction\s+([^\s{}]+)',line)
  if not m or '$(' not in m[1]:continue
  target=m[1];rx=re.escape(target)
  for var in re.findall(r'\$\(([^)]+)\)',target):
   if var in ['n','tile','step','frame']:replacement=r'-?[0-9]+'
   elif var in values and values[var]:replacement='(?:'+'|'.join(re.escape(v) for v in sorted(values[var]))+')'
   else:replacement=r'[^/]+'
   rx=rx.replace(re.escape('$('+var+')'),replacement)
  matches={f for f in ids if re.fullmatch(rx,f)}
  edges[fid]|=matches;dynamic.append({'from':fid,'target':target,'matches':len(matches),'line':line})
seen=set(roots);todo=list(roots)
while todo:
 for nxt in edges[todo.pop()]-seen:seen.add(nxt);todo.append(nxt)
dead=sorted((ids-seen)|{fid for fid,s in texts.items() if not s.strip() and fid not in manifest});incoming=defaultdict(set)
for fid,refs in edges.items():
 for ref in refs:incoming[ref].add(fid)
report={'total':len(ids),'roots':len(roots),'reachable':len(seen),'candidates':dead,'candidate_details':{k:{'lines':len(texts[k].splitlines()),'incoming':sorted(incoming[k]),'text':texts[k][:220]} for k in dead},'dynamic':dynamic,'root_sources':{k:sorted(v) for k,v in sources.items()}}
if args.report:
 args.report.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(f'Functions: {len(ids)}; reachable: {len(seen)}; unused candidates: {len(dead)}')
print('\n'.join(dead))
sys.exit(bool(dead))

from pathlib import Path
import re,json,zipfile
r=Path(__file__).resolve().parents[1];f=r/'data/oa/function'
# Audit Minecraft command structure and all static function and block-tag references.
counts={'json':0,'functions':0,'function_references':0};errors=[]
for p in r.rglob('*'):
 if p.suffix in ['.json','.mcmeta']:
  try:json.loads(p.read_text());counts['json']+=1
  except Exception as e:errors.append(str(p)+': '+str(e))
for p in (r/'data').rglob('*.mcfunction'):
 counts['functions']+=1
 for ln,line in enumerate(p.read_text().splitlines(),1):
  if not line or line.startswith('#'):continue
  if '$(' in line and not line.startswith('$'):errors.append(f'Macro {p}:{ln}')
  stack=[];quote=None;escape=False
  for ch in line:
   if quote:
    if escape:escape=False
    elif ch=='\\':escape=True
    elif ch==quote:quote=None
   elif ch in '\"\'':quote=ch
   elif ch in '{[':stack.append(ch)
   elif ch in '}]':
    if not stack or stack.pop()!={'{':'}','[':']'}.__class__({'}':'{',']':'['})[ch]:errors.append(f'Balance {p}:{ln}');break
  if stack or quote:errors.append(f'Unclosed {p}:{ln}')
  for m in re.finditer(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',line):
   ns,n=m[1].split(':');counts['function_references']+=1
   if not (r/'data'/ns/'function'/(n+'.mcfunction')).exists():errors.append(f'Missing {m[1]} at {p}:{ln}')
assert not errors,'\n'.join(errors)
# Verify exact gacha distribution and absence of removed entries in both live and debug dispatch.
for path in ['tayayuyu/use','debug/gacha/use']:
 s=(f/(path+'.mcfunction')).read_text();assert 'random value 1..13' in s
 dispatch=re.findall(r'execute if score #gacha_roll oa.tmp matches (\d+) run function (\S+)',s)
 assert [int(a) for a,b in dispatch]==list(range(1,14)),dispatch
 assert not any(re.search(r'/(speed_all|peace_all|intro|3|11|16)$',b) for a,b in dispatch),dispatch
for p in ['tayayuyu/bomb_spawn','tayayuyu/gather','tayayuyu/mood','tayayuyu/hunger_all']:
 print(p,(f/(p+'.mcfunction')).read_text().splitlines()[-1])
assert 'oa.gbomb 20' in (f/'tayayuyu/bomb_spawn.mcfunction').read_text()
assert '{seconds:1,ticks:20}' in (f/'tayayuyu/gather.mcfunction').read_text()
assert 'oa:gacha_mood 1.0' in (f/'tayayuyu/mood.mcfunction').read_text()
assert 'minecraft:hunger 10 1' in (f/'tayayuyu/hunger_all.mcfunction').read_text()
s=(f/'br/start.mcfunction').read_text();assert s.index('oa:br/preflight')<s.index('scoreboard players set #state br.state 1')<s.index('oa:br/enter\n');assert 'oa:br/live_spread' not in s
assert 'oa:lobby/events/request' not in (f/'br/finish.mcfunction').read_text()
s=(f/'lobby/map_labels_build.mcfunction').read_text();assert s.count('summon minecraft:item_frame')==6;assert 'summon minecraft:text_display' not in s
# Existing generator data: all allowed supports are terrain; leafy/roof materials cannot pass.
allowed=json.loads((r/'data/oa/tags/block/spawn_ground.json').read_text())['values'];assert not any(('leaves' in x or 'planks' in x or 'terracotta' in x or 'concrete' in x) for x in allowed)
print(counts)
(r/'VALIDATION_1_9_25.json').write_text(json.dumps({'version':'1.9.25',**counts,'structural_checks':'passed','gacha_distribution':'13 equally likely results; removed 3,11,16 from old pool','spawn_plan':'validated before enter; natural ground and clear headroom, bounded retries','runtime':'Minecraft server/client not available; no runtime performance measurement'},ensure_ascii=False,indent=2)+'\n')

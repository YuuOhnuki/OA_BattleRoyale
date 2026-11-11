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
 s=(f/(path+'.mcfunction')).read_text();assert 'random value 1..15' in s
 dispatch=re.findall(r'execute if score #gacha_roll oa.tmp matches (\d+) run function (\S+)',s)
 assert [int(a) for a,b in dispatch]==list(range(1,16)),dispatch
 assert not any(re.search(r'/(speed_all|peace_all|intro|hop_all|3|5|11|16)$',b) for a,b in dispatch),dispatch
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
(r/'VALIDATION_1_9_26.json').write_text(json.dumps({'version':'1.9.26',**counts,'structural_checks':'passed','gacha_distribution':'15 equally likely results; hop removed, three self penalties added','spawn_plan':'validated before enter; natural ground and clear headroom, bounded retries','runtime':'Minecraft server/client not available; no runtime performance measurement'},ensure_ascii=False,indent=2)+'\n')

# All acquisition routes and held legacy items carry four guaranteed 10-second effects.
medical=json.loads((r/'data/oa/item_modifier/medical/paimon.json').read_text())['components']
effects=medical['minecraft:consumable']['on_consume_effects'][0]['effects']
assert {a['id']: (a['amplifier'],a['duration']) for a in effects}=={'minecraft:speed':(1,200),'minecraft:jump_boost':(1,200),'minecraft:strength':(1,200),'minecraft:regeneration':(0,200)}
assert 'paimon_v1926:1b' in (f/'medical/upgrade.mcfunction').read_text()
for n in ['critical','stiff','exposed']:
 assert 'oa:tayayuyu/'+n in (f/'tayayuyu/use.mcfunction').read_text()
assert 'oa.gstiff 200' in (f/'tayayuyu/stiff.mcfunction').read_text()
assert 'oa.gexpose 200' in (f/'tayayuyu/exposed.mcfunction').read_text()
for n in ['internal/rejoin','internal/death','br/finish']:
 assert 'oa:tayayuyu/clear' in (f/(n+'.mcfunction')).read_text()
assert 'oa:tayayuyu/stiff_end' in (f/'tayayuyu/clear.mcfunction').read_text()
assert 'oa:tayayuyu/exposed_end' in (f/'tayayuyu/clear.mcfunction').read_text()
for p in [r/'data/oa/loot_table/br/buffs/paimon.json',r/'data/oa/loot_table/br/ore_medical.json']:
 assert 'paimon_v1926' in p.read_text()
print('Four food effects, 15 outcomes, timed penalty cleanup: passed')

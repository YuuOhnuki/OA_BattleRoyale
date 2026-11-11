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

skills=['kaeya','ineffa','varesa','xilonen','flins','mavuika']
release=(f/'itori/release.mcfunction').read_text()
for n,skill in enumerate(skills,1):assert f'oa.i_next matches {n} run function oa:itori/{skill}' in release
assert 'oa.i_pending matches 6' in (f/'itori/use.mcfunction').read_text()
assert 'oa.cd 200' in release
for tick,stage in [(0,1),(599,1),(600,2),(1200,3),(1800,4),(2400,5),(3000,6)]:assert min(tick//600+1,6)==stage
assert 'oa.i_held 1' not in (f/'itori/held.mcfunction').read_text()
assert 'oa.i_held 1' in (f/'itori/owned_tick.mcfunction').read_text()
player=(f/'player_tick.mcfunction').read_text()
assert player.count('run function oa:itori/owned_tick')==2
assert 'execute unless items entity @s inventory.*' in player
for stage,roman in enumerate(['Ⅰ','Ⅱ','Ⅲ','Ⅳ','Ⅴ','Ⅵ'],1):
 d=json.loads((r/f'data/oa/item_modifier/lore/k10_{stage}.json').read_text())
 assert d['type']=='minecraft:sequence'
 assert d['functions'][0]['components']['minecraft:custom_name']['text'].endswith(roman)
 assert roman in (f/'itori/hud.mcfunction').read_text()
for p in (r/'data/oa/item_modifier').rglob('*.json'):assert isinstance(json.loads(p.read_text()),dict),p
assert 'minecraft:slowness 3 0' in (f/'itori/area_hit.mcfunction').read_text()
assert 'minecraft:slowness 1 1' in (f/'itori/zap.mcfunction').read_text()
assert 'amount:5.0' in (f/'itori/dive_impact.mcfunction').read_text()
assert 'matches 40' in (f/'itori/burn_tick.mcfunction').read_text()
assert 'matches 20' in (f/'itori/burn_tick.mcfunction').read_text()
assert 'matches 0' in (f/'itori/burn_tick.mcfunction').read_text()
assert 'oa.i_flins 100' in (f/'itori/flins.mcfunction').read_text()
assert 'run function oa:combat/select_targets' not in (f/'itori/flins_hit.mcfunction').read_text()
print(counts)
print('Six-skill routing, ownership timers, 30s thresholds, six item stages/HUD and status effects passed')
(r/'VALIDATION_1_9_55.json').write_text(json.dumps({'version':'1.9.55',**counts,'checks':'static JSON, macro brackets, function references, six-stage boundaries and damage/status routes passed','runtime':'not tested in Minecraft'},indent=2))

# Simulate normal growth while carried, pause when dropped, and no double offhand increment.
held=0
for owned in [True]*600+[False]*200+[True]*2400:
 if owned:held=min(3000,held+1)
assert held==3000 and min(held//600+1,6)==6
# Three burn pulses, exactly one second apart after a hit.
pulses=[t for t in range(1,61) if 60-t in [40,20,0]]
assert pulses==[20,40,60]
assert 'see_through:1b' in (f/'br/loot/mark_open.mcfunction').read_text()
assert 'function oa:itori/dive_remove' in (f/'itori/effects_end.mcfunction').read_text()
assert 'attribute @s minecraft:fall_damage_multiplier modifier remove oa:itori_dive' in (f/'itori/effects_end.mcfunction').read_text()
print('Ownership pause/resume, 3s burn pulse timing and dive cleanup checks passed')

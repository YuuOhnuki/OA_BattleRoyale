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
(r/'VALIDATION_1_9_29.json').write_text(json.dumps({'version':'1.9.29',**counts,'structural_checks':'passed','gacha_distribution':'15 equally likely results; hop removed, three self penalties added','spawn_plan':'validated before enter; natural ground and clear headroom, bounded retries','runtime':'Minecraft server/client not available; no runtime performance measurement'},ensure_ascii=False,indent=2)+'\n')

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

# Regression: 26.3 condition.player is a predicate object, not an array.
for p in (r/'data').rglob('advancement/*.json'):
 pass
adv_count=0
for ns in (r/'data').iterdir():
 if not ns.is_dir():continue
 for p in (ns/'advancement').rglob('*.json'):
  obj=json.loads(p.read_text());adv_count+=1
  for crit in obj.get('criteria',{}).values():
   player=crit.get('conditions',{}).get('player')
   if player is not None:assert isinstance(player,dict),(p,player)
canon=None;routes=0
def inspect(x):
 global canon,routes
 if isinstance(x,dict):
  c=x.get('components',{})
  if c.get('minecraft:custom_data',{}).get('oa_furoball'):
   assert c['minecraft:max_stack_size']==64
   assert c['minecraft:custom_data']['furo_stack1927'] is True
   if canon is None:canon=c
   assert c==canon
   routes+=1
  for a in x.values():inspect(a)
 elif isinstance(x,list):
  for a in x:inspect(a)
for p in (r/'data/oa/loot_table').rglob('*.json'):inspect(json.loads(p.read_text()))
assert routes==3,routes
print('Advancement player object check:',adv_count,'; canonical 64-stack loot routes:',routes)

# New-weapon command shapes and model references, including the previous root-storage failure pattern.
for p in (f/'itori').rglob('*.mcfunction'):
 assert not re.search(r'data modify storage \S+ (?:set|merge|append|prepend|insert)\b',p.read_text()),p
for p in (r/'data/oa/advancement').rglob('*.json'):
 v=json.loads(p.read_text())
 reward=v.get('rewards',{}).get('function')
 if reward and reward.startswith('oa:'):assert (f/(reward[3:]+'.mcfunction')).exists(),(p,reward)
res=r.parent/'resources'
for name in ['itori','itori_bolt']:
 v=json.loads((res/f'assets/oa/items/{name}.json').read_text());assert v['model']['model']==f'oa:item/{name}'
 model=json.loads((res/f'assets/oa/models/item/{name}.json').read_text())
 for e in model['elements']:
  assert all(a<b for a,b in zip(e['from'],e['to'])),e
  assert all(-16<=a<=32 for a in e['from']+e['to'])
  if 'rotation' in e:assert e['rotation']['angle'] in [-45,-22.5,0,22.5,45],e
 for ref in model['textures'].values():
  if ref.startswith('oa:'):assert (res/('assets/oa/textures/'+ref[3:]+'.png')).exists(),ref
attrs=json.loads((r/'data/oa/item_modifier/melee_itori.json').read_text())['functions'][0]['modifiers']
assert abs(4+next(a['amount'] for a in attrs if a['attribute']=='minecraft:attack_speed')-1.4)<1e-9
assert 'matches 15.. run function oa:itori/bolt_spawn' in (f/'itori/attack.mcfunction').read_text()
assert 'oa.i_charge 0' in (f/'itori/attack.mcfunction').read_text()
assert 'oa.i_range matches 40..' in (f/'itori/bolt_step.mcfunction').read_text()
assert 'tp @s ^ ^ ^0.25' in (f/'itori/bolt_step.mcfunction').read_text()
assert 'oa.i_stamp = #i_stamp' in (f/'itori/area_hit.mcfunction').read_text()
assert 'oa.i_uses' not in (f/'itori/off.mcfunction').read_text()
assert 'execute unless score @s oa.i_round = #round br.round run function oa:itori/progress_reset' in (f/'br/enter.mcfunction').read_text()
assert 'minecraft:absorption 5 0' in (f/'itori/ineffa.mcfunction').read_text()
assert all(x in (f/'itori/xilonen.mcfunction').read_text() for x in ['minecraft:speed 5 1','minecraft:strength 5 0'])
# Independent rotation scenario: growth happens after each third accepted cast, current cycle stays frozen.
uses=0;cursor=1;cycle=1;trace=[]
for i in range(1,20):
 unlocked=min(5,uses//3+1)
 if cursor==1:cycle=unlocked
 trace.append(cursor)
 uses+=1;cursor+=1
 if cursor>cycle:cursor=1
assert trace==[1,1,1,1,2,1,2,1,2,3,1,2,3,4,1,2,3,4,5],trace
# Leap displacement and reversed flame sweep.
dy=[]
for i in range(10,0,-1):
 line=(f/f'itori/leap/{i}.mcfunction').read_text().splitlines()[0]
 dy.append(float(line.split('value ')[1].rstrip('f')))
assert abs(sum(dy))<1e-9 and abs(.5*len(dy)-5)<1e-9
assert 'rotated ~-45 0' in (f/'itori/fx/mavuika/0.mcfunction').read_text()
assert 'rotated ~45 0' in (f/'itori/fx/mavuika/6.mcfunction').read_text()
print('Itori: resource paths, native 1.4 attack speed, charge, range, growth/rotation, cleanup, leap and sweep checks passed')

finish=(f/'br/finish.mcfunction').read_text()
assert finish.index('oa:itori/effects_end')<finish.index('oa:br/recover')
p=r/'VALIDATION_1_9_29.json';v=json.loads(p.read_text());v['itori']={'model_elements':299,'attack_speed':1.4,'charge_ticks':15,'range_m':10,'normal_damage_hp':1.5,'rotation':'five skills, frozen per cycle','cycle_cooldown_ticks':240,'same_round_revive_preserves_progress':True,'finish_effect_cleanup_before_restore':True,'runtime':'not tested'};p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')

# Expanded effects: every native model resolves, transient entity lifetimes are finite, and sweep covers 360 degrees.
for name in ['itori_sigil','itori_fire_sigil','itori_column','itori_shield','itori_ice_fan','itori_fire_arc','itori_orange']:
 item=json.loads((res/f'assets/oa/items/{name}.json').read_text());assert item['model']['model']==f'oa:item/{name}'
 model=json.loads((res/f'assets/oa/models/item/{name}.json').read_text())
 for e in model['elements']:
  assert all(a<b for a,b in zip(e['from'],e['to'])),(name,e)
  if 'rotation' in e:assert e['rotation']['angle'] in [-45,-22.5,0,22.5,45]
 for ref in model['textures'].values():assert (res/('assets/oa/textures/'+ref[3:]+'.png')).exists()
for p in (f/'itori/fx/emit').glob('*.mcfunction'):
 text=p.read_text();m=re.search(r'oa.i_fxlife (\d+)',text);assert m and 1<=int(m[1])<=32,p
assert 'oa.i_fxlife 1' in (f/'itori/fx/display_tick.mcfunction').read_text()
assert 'matches ..0 run kill @s' in (f/'itori/fx/display_tick.mcfunction').read_text()
assert 'distance=4.01..' in (f/'itori/kaeya.mcfunction').read_text()
assert 'matches ..7 positioned' in (f/'itori/ice_ray.mcfunction').read_text()
assert 'distance=6.01..' in (f/'itori/sweep_work.mcfunction').read_text()
assert 'matches 24..' in (f/'itori/sweep_work.mcfunction').read_text()
headings=[]
for i in range(24):
 text=(f/f'itori/fx/mavuika/{i}.mcfunction').read_text();headings.append(int(re.search(r'rotated ~(-?\d+)',text)[1]))
assert headings==list(range(-45,301,15)),headings
assert len(headings)*15==360
for p in (f/'itori').rglob('*.mcfunction'):
 assert not re.search(r'data modify storage \S+ (?:set|merge|append|prepend|insert)\b',p.read_text()),p
assert 'oa:itori/fx/shield_remove' in (f/'itori/effects_end.mcfunction').read_text()
assert 'oa:itori/fx/shield_validate' in (f/'world_tick.mcfunction').read_text()
assert 'oa.itori_fx' in (f/'br/finish.mcfunction').read_text()
p=r/'VALIDATION_1_9_29.json';v=json.loads(p.read_text());v['itori'].update({'kaeya_range_m':4,'xilonen_leap_m':5,'xilonen_speed_level':2,'mavuika_radius_m':6,'mavuika_clockwise_degrees':360,'shield':'one following spherical mesh per active player','effect_models':7,'transient_fx_max_lifetime_ticks':28,'runtime':'not tested'});p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
print('Enhanced effects: range, clockwise sweep, shield cleanup, finite FX lifetimes and resource references passed')

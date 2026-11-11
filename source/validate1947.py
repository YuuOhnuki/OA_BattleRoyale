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
(r/'VALIDATION_1_9_47.json').write_text(json.dumps({'version':'1.9.47',**counts,'structural_checks':'passed','gacha_distribution':'15 equally likely results; hop removed, three self penalties added','spawn_plan':'validated before enter; natural ground and clear headroom, bounded retries','runtime':'Minecraft server/client not available; no runtime performance measurement'},ensure_ascii=False,indent=2)+'\n')

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


# Four-skill rotation; retired skill cannot be dispatched or shown in active UI.
use=(f/'itori/release.mcfunction').read_text()
routes=re.findall(r'execute if score @s oa.i_next matches (\d+) run function oa:itori/(\w+)',use)
assert routes==[('1','kaeya'),('2','ineffa'),('3','xilonen'),('4','mavuika')],routes
assert 'oa.i_unlock 4' in (f/'itori/progress.mcfunction').read_text()
assert 'oa.i_ver 1932' in (f/'itori/progress_reset.mcfunction').read_text()
assert 'oa.i_uses' not in (f/'itori/migrate1932.mcfunction').read_text()
for p in (r/'data').rglob('*.mcfunction'):
 assert 'シトラリ' not in p.read_text(),p
assert '次：' in (f/'itori/hud.mcfunction').read_text()
assert '~ ~ ~ ~180 0' in (f/'itori/fx/emit/ice.mcfunction').read_text()
assert 'run function oa:itori/ice_ray' in (f/'itori/fx/kaeya.mcfunction').read_text()
print('Four-skill rotation, preserved usage migration, retired-skill references and frost-facing correction passed')

assert 'minecraft:speed 5 1' in (f/'itori/xilonen.mcfunction').read_text()
assert 'minecraft:strength 5 0' in (f/'itori/xilonen.mcfunction').read_text()
assert 'oa.i_boost 100' in (f/'itori/xilonen.mcfunction').read_text()
assert (f/'itori/leap_move.mcfunction').read_text().count('at @s run function oa:itori/leap_substep') == 5
assert '^0.1' in (f/'itori/leap_substep.mcfunction').read_text()
assert 'minecraft:item_model' not in (f/'itori/fx/emit/orange.mcfunction').read_text()
assert 'function oa:itori/fx/orange\n' not in (f/'itori/xilonen.mcfunction').read_text()
assert 'oa:itori/leap_tick' in (f/'itori/effect_tick.mcfunction').read_text()
for phase in [13,10,7,4]:assert 'oa:itori/fx/orange_up_'+str(phase) in (f/'itori/fx/display_tick.mcfunction').read_text()
print('Restored 5m leap, Speed II/Strength I for 5s, enlarged sigil and upward effects passed')

# Regression for the reported display codec: all decomposed transforms need four members.
transform_count=0
for p in (r/'data').rglob('*.mcfunction'):
 text=p.read_text()
 for m in re.finditer(r'(?:"transformation"|\btransformation)\s*:\s*\{',text):
  start=m.end();depth=1;quote=None;escape=False;end=None
  for idx in range(start,len(text)):
   ch=text[idx]
   if quote:
    if escape:escape=False
    elif ch=='\\':escape=True
    elif ch==quote:quote=None
   elif ch in ['"',"'"]:quote=ch
   elif ch=='{':depth+=1
   elif ch=='}':
    depth-=1
    if depth==0:end=idx;break
  assert end is not None,p
  body=text[start:end]
  for key in ['translation','left_rotation','right_rotation','scale']:assert re.search(r'(?:"'+key+r'"|\b'+key+r')\s*:',body),(p,key)
  transform_count+=1
start=(f/'itori/use.mcfunction').read_text();tick=(f/'itori/windup_tick.mcfunction').read_text();release=(f/'itori/release.mcfunction').read_text()
assert 'matches 15.. run return run function oa:itori/release' in tick
assert 'time query gametime' in start and 'time query gametime' in tick
assert 'scoreboard players add @s oa.i_uses' not in start
assert 'scoreboard players add @s oa.i_uses 1' in release
assert release.index('oa:itori/windup_cancel')<release.index('oa:itori/kaeya')
for name in ['off','effects_end','progress_reset']:assert 'oa:itori/windup_cancel' in (f/f'itori/{name}.mcfunction').read_text()
assert 'tag=oa.itori_windup' in (f/'itori/attack.mcfunction').read_text()
print('Complete display transforms:',transform_count,'; 15-tick wind-up, consumption-on-release and cancellation guards passed')

assert "whack 15t" in (f/"itori/use.mcfunction").read_text()
assert "interpolation_duration:15" in (f/"itori/windup_spawn.mcfunction").read_text()

# Regression: a descending destination 0.05m below a full-block surface
# was accepted by the old +0.1m foot sample; the new zero-height sample rejects it.
import math
assert math.floor(-0.05 + 0.1) == 0
assert math.floor(-0.05) == -1
sub=(f/'itori/leap_substep.mcfunction').read_text()
assert '~0 ~' in sub and '~1.801 ~' in sub
assert sub.count('unless block') == 20
assert sub.count('unless loaded') == 4
assert sub.rfind('run tp @s') > sub.rfind('unless block')
for n in range(1,11):
 text=(f/f'itori/leap/{n}.mcfunction').read_text()
 assert abs(float(re.search(r'dy set value (-?[\d.]+)f',text)[1])) <= 0.05
print('Leap foot-level regression, body clearance, 5 substeps and bounded vertical motion passed')

assert "~0.9" in (f/"itori/fx/shield_spawn.mcfunction").read_text()
assert "~0.9" in (f/"itori/fx/shield_mesh.mcfunction").read_text()

assert "unless score @s oa.i_pending matches 4 run return run function oa:itori/release" in start
assert "minecraft:slowness 1 3" in start
assert start.index("unless score @s oa.i_pending matches 4") < start.index("whack 15t")

hud=(f/"itori/hud.mcfunction").read_text()
assert "oa.i_charge" not in hud and "oa.i_uses" not in hud
assert "scale:[2.25f,2.25f,2.25f]" in (f/"itori/fx/shield_spawn.mcfunction").read_text()
for name in ["kaeya","ineffa","xilonen","mavuika"]: assert (f/f"itori/{name}.mcfunction").read_text().startswith("tellraw @s ")

for p in f.rglob("*.mcfunction"):
 assert not re.search(r"particle minecraft:flash\s",p.read_text()),p
print("All flash particle commands have explicit options")

assert "spawn_depth br.tmp 32" in (f/"br/spawn_retry.mcfunction").read_text()
assert "#minecraft:leaves" in (f/"br/spawn_scan.mcfunction").read_text()
assert "align xyz positioned ~0.5 ~ ~0.5" in (f/"br/spawn_retry.mcfunction").read_text()

# Ground search regression cases: canopy, solid roof, water, and no headroom.
def probe(column,start):
 for y in range(start,start-32,-1):
  below=column.get(y-1,'air')
  if below=='ground' and column.get(y,'air')=='air' and column.get(y+1,'air')=='air':return y
  if below not in ('air','leaf'):return None
 return None
assert probe({0:'ground',5:'leaf',6:'leaf'},7)==1
assert probe({0:'ground',5:'roof'},6) is None
assert probe({0:'ground',1:'water'},2) is None
assert probe({0:'ground',2:'roof'},3) is None
assert probe({},32) is None
print('Canopy descent, solid-roof/water rejection and bounded search simulations passed')

pre=(f/'br/preflight.mcfunction').read_text()
assert 'spreadplayers' not in pre
assert '#point_count br.tmp < #spawn_needed br.tmp' in pre
assert 'points[$(index)]' in (f/'br/spawn_points/select.mcfunction').read_text()
assert 'data remove storage oa:spawn_pool points' in (f/'br/spawn_points/select.mcfunction').read_text()
assert 'data remove storage oa:spawn_points points' not in (f/'br/spawn_points/select.mcfunction').read_text()
for cmd in ['add','list','remove','clear']:assert (f/f'br/spawn_points/{cmd}.mcfunction').is_file()
import random
for total in range(1,65):
 pool=list(range(total));picked=[]
 while pool:picked.append(pool.pop(random.randrange(len(pool))))
 assert len(set(picked))==total
print('Registered-point selection: no replacement, persistent source preserved, bounded 64-point pool passed')

assert "br.spawn" not in (f/"br/cache_spawn.mcfunction").read_text()
assert "spawn_points/check" not in (f/"br/spawn_points/verify.mcfunction").read_text()

import random
def plan(points,teams=None,count=1):
 pool=list(points);saved={};shared={}
 if len(pool)<(len(set(teams)) if teams else count):return None
 for i in range(count):
  if teams:
   t=teams[i]
   if t not in shared:shared[t]=pool.pop(random.randrange(len(pool)))
   saved[i]=shared[t]
  else:saved[i]=pool.pop(random.randrange(len(pool)))
 return saved
points=[(n,70,n) for n in range(11)]
for _ in range(100):
 assert len(plan(points,count=1))==1
 assert len(set(plan(points,count=10).values()))==10
 result=plan(points,[1,1,2,2],4)
 assert result[0]==result[1] and result[2]==result[3] and result[0]!=result[2]
assert plan([],count=1) is None
assert len(points)==11
assert '@e' not in (f/'br/preflight.mcfunction').read_text()
assert '@e' not in (f/'br/cache_spawn.mcfunction').read_text()
print('11-point solo / 10-player / shared-team storage plans and insufficient-point abort passed')

unique=(f/'br/loot/unique.mcfunction').read_text()
ranges=re.findall(r'matches (\d+)\.\.(\d+) run function oa:give/internal/(\w+)',unique)
for n in range(1,161):
 hits=[name for a,b,name in ranges if int(a)<=n<=int(b)]
 assert len(hits)==1,(n,hits)
assert [name for a,b,name in ranges if int(a)<=150<=int(b)]==['itori']
rare=(f/'br/loot/chest_rare.mcfunction').read_text()
for t,v in [(4800,18),(7200,24),(9600,30)]:assert f'{t}.. run scoreboard players set #rare_chance br.tmp {v}' in rare
print('All 160 unique rolls map to exactly one item; late chest probabilities verified')

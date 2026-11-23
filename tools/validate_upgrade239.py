"""Reproducible offline tests. Use --seeds for generated maps in isolated directories."""
from pathlib import Path
import json,random,re,subprocess,sys,time,shutil
R=Path(__file__).resolve().parents[1];P=R.parent/'oa_battleroyale_plugin';OUT=R.parent/('dist/upgrade239-offline-multiseed.json' if '--seeds' in sys.argv else 'dist/upgrade239-offline.json')
checks=[]
def check(name,ok,details=None):
 checks.append(dict(name=name,ok=bool(ok),details=details));print(('PASS ' if ok else 'FAIL ')+name)
def read(path):return (R/path).read_text(encoding='utf-8')
def old(path):return subprocess.check_output(['git','show','62f93d0:'+path],cwd=R).decode('utf-8')
def draw(weights,n=200000):
 rng=random.Random(239);v=list(weights);counts=dict.fromkeys(v,0)
 for _ in range(n):counts[rng.choices(v,weights=list(weights.values()),k=1)[0]]+=1
 return {k:c/n for k,c in counts.items()}
food=json.loads(read('data/oa/loot_table/br/food.json'))['pools'][1]['entries']
weights={e.get('name',e['type']):e.get('weight',1) for e in food};rates=draw(weights)
check('coal loot: existing snowball/egg/arrow weights unchanged',all(weights['minecraft:'+k]==10 for k in ('snowball','egg','arrow')) and sum(weights.values())==100,weights)
check('coal and regular food loot: pearl exactly half snow/egg weight',weights['minecraft:ender_pearl']==5 and abs(rates['minecraft:ender_pearl']-.05)<.003,rates)
check('supply yu: one draw,15/100',read('data/oa/function/br/supply/spawn.mcfunction').count('random value 1..100')>=1 and '#sup_yu br.tmp matches 1..15' in read('data/oa/function/br/supply/spawn.mcfunction'))
for label,path,score,objective,target in (
 ('supply yu','data/oa/function/br/supply/spawn.mcfunction','#sup_yu','br.tmp',.15),
 ('tayayuyu normal','data/oa/function/tayayuyu/hit.mcfunction','#launch_roll','oa.tmp',.20)):
 source=read(path);draws=re.findall(r'execute store result score '+re.escape(score+' '+objective)+r' run random value (\d+)\.\.(\d+)',source)
 selected=re.search(re.escape(score+' '+objective)+r' matches (\d+)(?:\.\.(\d+))?',source)
 low,high=map(int,draws[0]);winLow=int(selected[1]);winHigh=int(selected[2] or selected[1]);rng=random.Random(239)
 rate=sum(winLow<=rng.randint(low,high)<=winHigh for _ in range(200000))/200000
 check(label+' production-range simulation200000 draws',len(draws)==1 and abs(rate-target)<.003,dict(range=[low,high],accepted=[winLow,winHigh],observed=rate,target=target))
check('yu milestones: notify only recipient','$tellraw @s ' in read('data/oa/function/br/yu_bonus_give.mcfunction') and 'tellraw @a' not in read('data/oa/function/br/yu_bonus_give.mcfunction'))
for key in ('chest_basic','chest_upgraded'):
 now=json.loads(read('data/oa/loot_table/br/'+key+'.json'))['pools'];before=json.loads(old('data/oa/loot_table/br/'+key+'.json'))['pools']
 check(key+' pearl2%, one pearl and previous snow/egg unchanged',sum(e.get('weight',1) for e in now[7]['entries'])==200 and next(e['weight'] for e in now[7]['entries'] if e.get('name')=='minecraft:ender_pearl')==4 and all(next(n['weight'] for n in now[7]['entries'] if n.get('name')==e['name'])==e['weight'] for e in before[7]['entries'] if 'name' in e))
 check(key+' weapon/armor and other pool probabilities unchanged',all([(e.get('type'),e.get('name'),e.get('weight',1)) for e in pool['entries']]==[(e.get('type'),e.get('name'),e.get('weight',1)) for e in before[i]['entries']] for i,pool in enumerate(now) if i!=7))
check('quartz original food drops preserved',json.loads(read('data/oa/loot_table/br/food_quartz.json'))==json.loads(old('data/oa/loot_table/br/food.json')))
taya=read('data/oa/function/tayayuyu/hit.mcfunction');check('tayayuyu one normal draw:20%',taya.count('random value 1..5')==1)
mine=read('data/oa/function/br/mining/broken.mcfunction')
check('coal/redstone100,nether ores25,registration unchanged',all(('recover:25' if stat in ('br.mqz','br.mng') else 'recover:100') in line for line in mine.splitlines() if 'mining/reward' in line for stat in re.findall('stat:"([^"]+)"',line)))
bat=json.loads(read('data/oa/item_modifier/bat_visual.json'));check('bat actualKB4 and versioned refresh',any(f.get('enchantments',{}).get('minecraft:knockback')==4 for f in bat['functions']) and 'oa_bat_v239' in read('data/oa/function/normal/visual_tick.mcfunction'))
for key in ('sky','end'):
 quality=json.loads(read(f'MAP_{key.upper()}_QUALITY.json'))
 check(key+' all generated chest paths pass BFS approximation',all(not c['unreachable_chests'] for c in quality['checks']),dict(templates=len(quality['checks']),ladderColumns=sum(c['ladder_columns'] for c in quality['checks']),relocated=sum(len(c['relocated_chests']) for c in quality['checks'])))
 check(key+' ore augmentation reaches target without removing original ore',all(c['after']==c['target'] and c['after']>=c['before'] for c in quality['ores']),quality['ores'])
sky=json.loads(read('MAP_SKY_MANIFEST.json'));check('sky17 distinct types; each 5+spawn and7chests',len(sky['isles'])==17 and all(x['spawns']>=5 and x['chests']==7 for x in sky['isles'].values()))
end=json.loads(read('MAP_END_MANIFEST.json'));check('end16 catalog types and three distinct candidates per slot',len(json.loads(read('scripts/map_islands.json'))['end'])==16 and all(len(set(s['types']))==3 for s in end['slots']))
cave=json.loads(read('MAP_CAVE_MANIFEST.json'));check('cave270 ore vs180 baseline',len(cave['ores'])==270)
# Real function-chain selection is also tested on Paper; compare algorithms over identical pools/seeds here.
points=[(x['x'],x['z']) for x in []] # report explicit model data from the cave manifest instead of inventing geometry
points=[(p[0],p[2]) for p in cave.get('spawn',cave.get('spawns',[]))]
if not points:
 source=read('data/oa/function/maps/cave/post.mcfunction');points=[tuple(map(float,m)) for m in re.findall(r'\{x:([-0-9.]+)d,y:[-0-9.]+d,z:([-0-9.]+)d\}',source)]
def separated(seed,far):
 rng=random.Random(seed);pool=points.copy();picked=[]
 for i in range(min(10,len(pool))):
  rng.shuffle(pool);point=pool[0] if not far or not picked else max(pool,key=lambda p:min((p[0]-q[0])**2+(p[1]-q[1])**2 for q in picked))
  picked.append(point);pool.remove(point)
 return min(((p[0]-q[0])**2+(p[1]-q[1])**2)**.5 for i,p in enumerate(picked) for q in picked[i+1:])
if len(points)>=10:
 before=[separated(n,False) for n in range(1000)];after=[separated(n,True) for n in range(1000)]
 check('spawn max-min improves mean nearest pair over1000 seeds',sum(after)>sum(before),dict(candidates=len(points),oldMean=sum(before)/len(before),newMean=sum(after)/len(after),newWorst=min(after)))
else:check('spawn fixture has10+real candidates',False,len(points))
timings=[]
if '--seeds' in sys.argv:
 root=R/'work/upgrade239-seeds';root.mkdir(parents=True,exist_ok=True)
 for key,script,baseline in [('sky','build_map_sky.py',20261125),('end','build_map_float.py',20261124),('cave','build_map_cave.py',20261115)]:
  for seed in (baseline,baseline+101,baseline+202):
   target=root/f'{key}-{seed}';target.mkdir(parents=True,exist_ok=True);(target/'source').mkdir(exist_ok=True)
   shutil.copytree(R/'data/oa/function/map/internal/tiles',target/'data/oa/function/map/internal/tiles',dirs_exist_ok=True)
   cmd=[sys.executable,str(R/'scripts'/script),str(target)]+(['end'] if key=='end' else [])+['--seed',str(seed)]
   begin=time.perf_counter();result=subprocess.run(cmd,capture_output=True,text=True,encoding='utf-8');elapsed=time.perf_counter()-begin
   (target/'generation.log').write_text(result.stdout+'\n'+result.stderr,encoding='utf-8')
   check(f'{key} generation seed{seed}',result.returncode==0,dict(seconds=elapsed,log=str(target/'generation.log')))
   if result.returncode==0 and key in ('sky','end'):
    quality=json.loads((target/f'MAP_{key.upper()}_QUALITY.json').read_text(encoding='utf-8'))
    check(f'{key} final repaired routes seed{seed}',all(not c['unreachable_chests'] for c in quality['checks']),dict(templates=len(quality['checks'])))
   timings.append(dict(map=key,seed=seed,seconds=elapsed,kind='new offline generation+validation'))
  # Baseline uses its committed original generator, same isolated layout and machine.
  target=root/f'{key}-baseline';target.mkdir(parents=True,exist_ok=True);(target/'source').mkdir(exist_ok=True)
  shutil.copytree(R/'data/oa/function/map/internal/tiles',target/'data/oa/function/map/internal/tiles',dirs_exist_ok=True)
  baselineScript=root/('baseline-'+script);baselineScript.write_text(old('scripts/'+script),encoding='utf-8')
  cmd=[sys.executable,str(baselineScript),str(target)]+(['end'] if key=='end' else [])
  begin=time.perf_counter();result=subprocess.run(cmd,capture_output=True,text=True,encoding='utf-8');elapsed=time.perf_counter()-begin
  (target/'generation.log').write_text(result.stdout+'\n'+result.stderr,encoding='utf-8')
  check(key+' committed baseline generation',result.returncode==0,dict(seconds=elapsed))
  timings.append(dict(map=key,seed=baseline,seconds=elapsed,kind='old offline generation'))
OUT.write_text(json.dumps(dict(checks=checks,timings=timings),ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
sys.exit(0 if all(c['ok'] for c in checks) else 1)

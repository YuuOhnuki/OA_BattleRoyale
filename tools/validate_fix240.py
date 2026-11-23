"""Offline generation and bounded-deletion regressions, outputs outside release tree."""
from pathlib import Path
import json,re,subprocess,sys,time,shutil
R=Path(__file__).resolve().parents[1];checks=[]
def check(n,ok,d=''):
 checks.append(dict(name=n,ok=bool(ok),detail=d));print(('PASS ' if ok else 'FAIL ')+n,flush=True)
legacy=json.loads((R/'source/map_delete_legacy.json').read_text(encoding='utf-8'))
for n in range(100):
 lines=(R/f'data/oa/function/map/internal/delete/clear_arena/{n}.mcfunction').read_text(encoding='utf-8').splitlines()
 boxes=[list(map(int,re.findall(r'~?(-?\d+)',l.split('minecraft:')[0]))) for l in lines if l.startswith('fill ')]
 check('delete tile'+str(n)+' bounded complete height',len(boxes)==6 and boxes[0][1]==0 and boxes[-1][4]==160 and all((b[3]-b[0]+1)*(b[4]-b[1]+1)*(b[5]-b[2]+1)<=32768 for b in boxes))
 apply=(R/f'data/oa/function/map/internal/delete/apply/{n}.mcfunction').read_text(encoding='utf-8')
 check('legacy overworld geometry retained'+str(n),all('execute unless score #arena_delete oa.map2 matches 1 run '+l in apply for l in legacy[str(n)]))
for seed in (20261124,20261225,20261326):
 target=R/f'work/fix240-end-{seed}';target.mkdir(parents=True,exist_ok=True);(target/'source').mkdir(exist_ok=True)
 for key in ('preload','wait','release'):
  src=R/f'data/oa/function/map/internal/tiles/{key}'
  shutil.copytree(src,target/f'data/oa/function/map/internal/tiles/{key}',dirs_exist_ok=True)
 t=time.perf_counter();p=subprocess.run([sys.executable,str(R/'scripts/build_map_float.py'),str(target),'end','--seed',str(seed)],capture_output=True,encoding='utf-8')
 (target/'generation.log').write_text(p.stdout+'\n'+p.stderr,encoding='utf-8')
 check('End all ore/block and route assertions seed'+str(seed),p.returncode==0,dict(seconds=round(time.perf_counter()-t,2),log=str(target/'generation.log')))
out=dict(checks=checks,passed=sum(c['ok'] for c in checks),failed=sum(not c['ok'] for c in checks))
(R.parent/'dist/upgrade240-offline.json').write_text(json.dumps(out,ensure_ascii=False,indent=2),encoding='utf-8')
raise SystemExit(bool(out['failed']))

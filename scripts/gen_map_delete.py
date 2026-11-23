"""Generate bounded BR arena deletion; preserve the old overworld-only geometry."""
from pathlib import Path
import json,re
R=Path(__file__).resolve().parents[1];D=R/'data/oa/function/map/internal/delete'
legacy=R/'source/map_delete_legacy.json'
if not legacy.exists():
 legacy.write_text(json.dumps({str(n):[l for l in (D/f'apply/{n}.mcfunction').read_text().splitlines() if not l.startswith('function ')] for n in range(100)},indent=1),encoding='utf-8')
old=json.loads(legacy.read_text(encoding='utf-8'))
(D/'clear_arena').mkdir(exist_ok=True)
for n in range(100):
 pre=D/f'preload/{n}.mcfunction';text=pre.read_text(encoding='utf-8')
 text='\n'.join(l for l in text.splitlines() if l!='scoreboard players set #delete_wait oa.map2 0')
 pre.write_text('scoreboard players set #delete_wait oa.map2 0\n'+text+'\n',encoding='utf-8')
 x,z,xx,zz=map(int,re.search(r'forceload add ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+)',text).groups())
 lines=['# BR専用5次元の生成範囲Y=0..160。各fillは32768ブロック以下。']
 for y in range(0,161,32):lines.append(f'fill ~{x} {y} ~{z} ~{xx} {min(160,y+31)} ~{zz} minecraft:air')
 for tag in ('br.chest','br.ore','br.matchloot','br.supply_wait','br.supply_crate','oa.gim','oa.mdeco','oa.isle'):
  lines.append(f'execute positioned ~{x} 0 ~{z} run kill @e[tag={tag},dx={xx-x},dy=160,dz={zz-z}]')
 (D/f'clear_arena/{n}.mcfunction').write_text('\n'.join(lines)+'\n',encoding='utf-8')
 lines=['# 生成：scripts/gen_map_delete.py','scoreboard players set #stage oa.map2 3',
  f'execute if score #arena_delete oa.map2 matches 1 run function oa:map/internal/delete/clear_arena/{n}']
 lines += ['execute unless score #arena_delete oa.map2 matches 1 run '+l for l in old[str(n)]]
 lines += [f'function oa:map/internal/tiles/release/{n}','function oa:map/internal/delete/advance']
 (D/f'apply/{n}.mcfunction').write_text('\n'.join(lines)+'\n',encoding='utf-8')
 wait=D/f'wait/{n}.mcfunction';text=wait.read_text(encoding='utf-8')
 text='\n'.join(l for l in text.splitlines() if '#delete_wait' not in l)
 guard='execute if score #ready oa.map2 matches 0 run return run schedule'
 text=text.replace(guard,'execute if score #ready oa.map2 matches 0 if score #delete_wait oa.map2 matches 300.. run return run function oa:map/internal/delete/failed\n'+guard)
 wait.write_text('scoreboard players add #delete_wait oa.map2 1\n'+text+'\n',encoding='utf-8')
print('Generated100 deletion tiles with complete BR height, progress and bounded waiting.')

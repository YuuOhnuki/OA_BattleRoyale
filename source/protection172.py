from pathlib import Path
import json
p=Path('revision/pack');f=p/'data/oa/function';b=f/'tayayuyu'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# Native durations count down naturally; do not extend them by reapplying each tick.
x=b/'tick.mcfunction';s=x.read_text().replace('function oa:tayayuyu/refresh_effects\n','');s=s.replace('scoreboard players remove @s[scores={oa.gpeace=1..}] oa.gpeace 1','scoreboard players remove @s[tag=oa.gacha_peace,scores={oa.gres_left=1..}] oa.gres_left 1\nscoreboard players remove @s[scores={oa.gpeace=1..}] oa.gpeace 1');w(x,s)
for name in ['refresh_effects','refresh_mood','refresh_glow','effect_mood','effect_glow']:(b/f'{name}.mcfunction').unlink()
for file in [f/'internal/active_changed.mcfunction',f/'internal/cleanup.mcfunction']:
 s=file.read_text().replace('run effect clear @s minecraft:glowing','unless entity @s[tag=oa.gacha_glow] run effect clear @s minecraft:glowing').replace('run effect clear @s minecraft:blindness','unless entity @s[tag=oa.gacha_mood] run effect clear @s minecraft:blindness');w(file,s)
# Snapshot existing lower resistance; peaceful protection does not erase its remaining time.
x=b/'peace.mcfunction';w(x,'execute unless entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_save\n'+x.read_text())
w(b/'peace_save.mcfunction','''scoreboard players set @s oa.gres_amp -1
scoreboard players set @s oa.gres_left 0
execute if data entity @s active_effects[{id:"minecraft:resistance"}] store result score @s oa.gres_amp run data get entity @s active_effects[{id:"minecraft:resistance"}].amplifier
execute if score @s oa.gres_amp matches 0..3 store result score @s oa.gres_left run data get entity @s active_effects[{id:"minecraft:resistance"}].duration
''')
x=b/'peace_end.mcfunction';s=x.read_text();s='''scoreboard players set #g_restore_res oa.tmp 0
execute unless entity @s[tag=oa.self_decoy] if data entity @s active_effects[{id:"minecraft:resistance",amplifier:4}] run scoreboard players set #g_restore_res oa.tmp 1
execute if score #g_restore_res oa.tmp matches 1 run effect clear @s minecraft:resistance
execute if score #g_restore_res oa.tmp matches 1 if score @s oa.gres_amp matches 0..3 if score @s oa.gres_left matches 1.. run function oa:tayayuyu/peace_restore
'''+s;w(x,s)
w(b/'peace_restore.mcfunction','''scoreboard players operation #g_effect_time oa.tmp = @s oa.gres_left
scoreboard players add #g_effect_time oa.tmp 19
scoreboard players set #g_twenty oa.tmp 20
scoreboard players operation #g_effect_time oa.tmp /= #g_twenty oa.tmp
execute store result storage oa:g_effect seconds int 1 run scoreboard players get #g_effect_time oa.tmp
execute store result storage oa:g_effect amp int 1 run scoreboard players get @s oa.gres_amp
function oa:tayayuyu/peace_restore_apply with storage oa:g_effect
''')
w(b/'peace_restore_apply.mcfunction','$effect give @s minecraft:resistance $(seconds) $(amp) true\n')
# A decoy ending must restore any still-active peaceful protection.
x=f/'nero/decoy_release.mcfunction';s=x.read_text();s='scoreboard players set #decoy_peace_restore oa.tmp 0\nexecute if entity @s[tag=oa.gacha_peace,tag=oa.self_decoy] run scoreboard players set #decoy_peace_restore oa.tmp 1\nexecute if entity @s[tag=oa.gacha_peace,tag=oa.decoy_grace] run scoreboard players set #decoy_peace_restore oa.tmp 1\n'+s+'\nexecute if score #decoy_peace_restore oa.tmp matches 1 if score @s oa.gpeace matches 1.. run function oa:tayayuyu/refresh_peace\n';w(x,s)
# Consuming doria during peace retains its ten seconds of resistance after peace ends.
w(p/'data/oa/advancement/medical/doria_peace.json',json.dumps({'criteria':{'used':{'trigger':'minecraft:consume_item','conditions':{'item':{'predicates':{'minecraft:custom_data':{'oa_buff':'doria'}}}}}},'rewards':{'function':'oa:medical/doria_peace'}},ensure_ascii=False,indent=2))
w(f/'medical/doria_peace.mcfunction','''advancement revoke @s only oa:medical/doria_peace
execute unless entity @s[tag=oa.gacha_peace] run return 0
execute if score @s oa.gres_amp matches 1.. run return 0
scoreboard players set @s oa.gres_amp 0
execute unless score @s oa.gres_left matches 200.. run scoreboard players set @s oa.gres_left 200
''')
for obj in ['oa.gres_amp','oa.gres_left']:add(f/'load.mcfunction',f'scoreboard objectives add {obj} dummy')
# Do not truncate an already longer gacha glow when reveal is rolled after self-introduction.
x=b/'reveal.mcfunction';w(x,x.read_text().replace('scoreboard players set @s oa.gglow 200','execute unless score @s oa.gglow matches 200.. run scoreboard players set @s oa.gglow 200'))
# Add new temporary effects to death/end cleanup without changing native permanent base values.
add(b/'clear.mcfunction','scoreboard players set @s oa.gres_amp -1\nscoreboard players set @s oa.gres_left 0')
# Preserve the finished helper source.
import shutil
shutil.copy('/tmp/protection172.py',p/'source/protection172.py')
print('Protection duration and cross-equipment cleanup fixed')

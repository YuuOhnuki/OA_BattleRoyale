scoreboard players remove @s[scores={oa.owait=1..}] oa.owait 1
scoreboard players remove @s[scores={oa.otime=1..}] oa.otime 1
execute if entity @s[tag=oa.overwork_active,scores={oa.otime=0}] run function oa:overwork/crash
execute if entity @s[tag=oa.overwork_crash,scores={oa.otime=0}] run function oa:overwork/end
execute if entity @s[tag=oa.overwork_pending,scores={oa.owait=0}] run function oa:overwork/begin
execute if entity @s[tag=oa.overwork_active] if score #clock oa.beat matches 1 run particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.7 0.4 0.12 10 normal @a[distance=..32]
execute if entity @s[tag=oa.overwork_active] if score #clock oa.beat matches 1 run particle minecraft:firework ~ ~1.8 ~ 0.2 0.3 0.2 0.02 3 normal @a[distance=..32]

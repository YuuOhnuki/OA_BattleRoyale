# Half-steps prevent tunneling through full blocks: two 0.375-block collision probes per tick.
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.15 run function oa:nero/mark_step
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.15 run function oa:nero/mark_step
scoreboard players remove @s[scores={oa.steps=1..}] oa.steps 1
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/checkpoint with storage oa:args
execute if score @s oa.mfx matches 1.. if score #clock oa.beat matches 5.. at @s run particle minecraft:reverse_portal ~ ~0.8 ~ 0.12 0.3 0.12 0.02 3 normal @a[distance=..32]
scoreboard players remove @s[scores={oa.mfx=1..}] oa.mfx 1

execute unless entity @a[tag=oa.caster,tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return run function oa:combat/decoy_intercept
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
scoreboard players set @s oa.root 50
attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
attribute @s minecraft:movement_speed modifier add oa:staple_root -1 add_multiplied_total
attribute @s minecraft:jump_strength modifier add oa:staple_root -1 add_multiplied_total
tag @s add oa.stapled
execute as @a[tag=oa.caster,limit=1] run function oa:ach/give {id:"hotchikisu_root",name:"拘束コンボ"}
function oa:nero/save
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:hotchikisu/root_save with storage oa:args
function oa:hotchikisu/root_fx
playsound minecraft:block.anvil.hit player @a[distance=..24] ~ ~ ~ 0.96 1.8

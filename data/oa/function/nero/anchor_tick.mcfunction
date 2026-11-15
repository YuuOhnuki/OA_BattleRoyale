# Armor stand executor. Inactive/logout/expired owners are removed once loaded.
scoreboard players operation #owner oa.id = @s oa.id
scoreboard players set #valid oa.tmp 0
execute if entity @s[tag=oa.nero_mark] as @a[tag=oa.player,scores={oa.mark=1..}] if score @s oa.id = #owner oa.id run scoreboard players set #valid oa.tmp 1
execute if entity @s[tag=oa.decoy_origin] as @a[tag=oa.player,tag=oa.self_decoy] if score @s oa.id = #owner oa.id run scoreboard players set #valid oa.tmp 1
execute unless score @s oa.epoch = #epoch oa.epoch run return run kill @s
execute if score #valid oa.tmp matches 0 run return run kill @s
# 1.9.186: 印の粒を本人にだけ見せるため、本人に oa.mark_owner
execute if entity @s[tag=oa.nero_mark] as @a[tag=oa.player,scores={oa.mark=1..}] if score @s oa.id = #owner oa.id run tag @s add oa.mark_owner
execute if entity @s[tag=oa.nero_mark] run function oa:nero/mark_tick
tag @a[tag=oa.mark_owner] remove oa.mark_owner

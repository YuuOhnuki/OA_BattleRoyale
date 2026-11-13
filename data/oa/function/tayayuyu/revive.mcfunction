execute unless score @s br.saved matches 1 run return 0
function oa:br/enter
execute if score #time br.time matches 1200.. run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #time br.time matches 1200.. run tag @s remove br.spawn_protection
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run team join oa_brgrace @s
# 1.9.148: 猶予後のソロ戦はチームに入れ直す（入らないと名前が見えたままになる）
execute if score #time br.time matches 1200.. if score #mode br.mode matches 0 run team join oa_brsolo @s
execute if score #time br.time matches ..1199 if score #mode br.mode matches 0 run tag @s add br.native_grace
# 1.9.149: 復活時の武器はチェスト補充（tick 7200）の前後で分ける。前半は石の剣、終盤は石の槍
execute if score #time br.time matches ..7199 run give @s minecraft:stone_sword
execute if score #time br.time matches 7200.. run give @s minecraft:stone_spear
function oa:internal/tp with storage oa:br center
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
function oa:give/internal/killing with storage oa:args
function oa:tayayuyu/equip_mask with storage oa:args
particle minecraft:totem_of_undying ~ ~1 ~ 0.6 1 0.6 0.15 60 normal @a[distance=..40]
playsound minecraft:item.totem.use player @a[distance=..40] ~ ~ ~ 1.4 1

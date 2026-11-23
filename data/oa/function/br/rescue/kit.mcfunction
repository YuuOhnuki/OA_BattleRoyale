# 1.9.242：初心者救済の復活の持ち物（br/enter のあと。資源採掘用ツルハシは br/enter が渡す）
# チェーンの防具一式。エンドでは胸のエリトラ（防御力+6）はそのままにして、チェーンのチェストプレートは持ち物へ
item replace entity @s armor.head with minecraft:chainmail_helmet
execute unless score #map oa.mapid matches 4 run item replace entity @s armor.chest with minecraft:chainmail_chestplate
execute if score #map oa.mapid matches 4 run give @s minecraft:chainmail_chestplate
item replace entity @s armor.legs with minecraft:chainmail_leggings
item replace entity @s armor.feet with minecraft:chainmail_boots
give @s minecraft:bread[minecraft:max_stack_size=64] 5
loot give @s loot oa:debug/bandage
loot give @s loot oa:debug/bandage
loot give @s loot oa:debug/bandage
loot give @s loot oa:debug/bandage
loot give @s loot oa:debug/bandage
# 固有武器を1つ（ゆうあ・ゆー以外の9種から等確率）。足元に出してすぐ拾えるようにする
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
execute store result score #kind br.tmp run random value 1..9
execute if score #kind br.tmp matches 1 run function oa:give/internal/pichipichi with storage oa:args
execute if score #kind br.tmp matches 2 run function oa:give/internal/lazi with storage oa:args
execute if score #kind br.tmp matches 3 run function oa:give/internal/nero with storage oa:args
execute if score #kind br.tmp matches 4 run function oa:give/internal/killing with storage oa:args
execute if score #kind br.tmp matches 5 run function oa:give/internal/yuttari with storage oa:args
execute if score #kind br.tmp matches 6 run function oa:give/internal/hotchikisu with storage oa:args
execute if score #kind br.tmp matches 7 run function oa:give/internal/komame with storage oa:args
execute if score #kind br.tmp matches 8 run function oa:give/internal/tayayuyu with storage oa:args
execute if score #kind br.tmp matches 9 run function oa:give/internal/itori with storage oa:args
execute as @e[type=minecraft:item,distance=..2,nbt={Age:0s}] run data modify entity @s PickupDelay set value 0s

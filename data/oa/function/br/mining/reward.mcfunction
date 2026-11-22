$scoreboard players remove @s $(stat) 1
function oa:itori/count_ore
# 1.9.221：お題「鉱石を5個掘る」用の試合ごとの数
scoreboard players add @s br.st_ore 1
# 1.9.174: 採掘の報酬・追加ドロップ・鉱石そのもののドロップは、掘った人のインベントリへ直接入れる（いっぱいなら足元に落ちる）
$loot give @s loot oa:br/$(table)
particle minecraft:happy_villager ~ ~0.5 ~ 0.3 0.3 0.3 0 8 normal @a[distance=..16]
playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.7 1.4
execute store result score #yu_mine br.tmp run random value 1..50
$execute if score #yu_mine br.tmp matches $(overwork_roll) run function oa:give/internal/overwork

execute store result score #mine_recover br.tmp run random value 1..100
$execute if score #mine_recover br.tmp matches 1..25 run function oa:medical/mine_$(table)
# 鉱石の位置に落ちたアイテム（鉱石のドロップ・オーバーワーク）を本人へ移して、すぐ拾えるようにする
execute as @e[type=minecraft:item,distance=..1.6] run data modify entity @s PickupDelay set value 0s
tp @e[type=minecraft:item,distance=..1.6] @s

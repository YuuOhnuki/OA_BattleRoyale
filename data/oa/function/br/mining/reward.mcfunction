$scoreboard players remove @s $(stat) 1
function oa:itori/count_ore
$loot spawn ~ ~1 ~ loot oa:br/$(table)
particle minecraft:happy_villager ~ ~0.5 ~ 0.3 0.3 0.3 0 8 normal @a[distance=..16]
playsound minecraft:entity.experience_orb.pickup player @s ~ ~ ~ 0.7 1.4
execute store result score #yu_mine br.tmp run random value 1..50
$execute if score #yu_mine br.tmp matches $(overwork_roll) run function oa:give/internal/overwork

execute store result score #mine_recover br.tmp run random value 1..100
$execute if score #mine_recover br.tmp matches 1..25 run function oa:medical/mine_$(table)

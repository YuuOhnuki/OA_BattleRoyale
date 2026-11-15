execute unless entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_save
$execute unless score @s oa.gpeace matches $(ticks).. run scoreboard players set @s oa.gpeace $(ticks)
$effect give @s minecraft:resistance $(seconds) 4 true
tag @s add oa.gacha_affected
tag @s add oa.gacha_peace
tag @s add br.pvp_grace
execute if score #mode br.mode matches 0 run tag @s add br.native_grace
# 1.9.185: チームは変えない（br.pvp_grace のダメージはプラグインが止める）
particle minecraft:enchant ~ ~1 ~ 0.5 0.7 0.5 0.2 12 normal @a[distance=..24]

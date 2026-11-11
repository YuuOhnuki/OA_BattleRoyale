scoreboard players set @s oa.breath 100
tag @s add oa.tired
function oa:ach/give {id:"lazi_tired",name:"大音量の代償"}
effect give @s minecraft:slowness 5 2 true
playsound minecraft:entity.player.breath player @a[distance=..20] ~ ~ ~ 0.666667 0.7
playsound minecraft:entity.player.hurt player @s ~ ~ ~ 0.233333 0.8
particle minecraft:cloud ~ ~1.5 ~ 0.2 0.15 0.2 0.02 12 normal @a[distance=..24]

function oa:hotchikisu/lazi_breath

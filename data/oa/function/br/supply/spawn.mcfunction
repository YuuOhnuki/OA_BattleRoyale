tag @s remove br.supply_new
tag @s add br.supply_fx
scoreboard players set @s br.sup 0
loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
loot spawn ~ ~0.5 ~ loot oa:br/heal
execute as @e[type=minecraft:item,distance=..3,nbt={Age:0s}] run data merge entity @s {Glowing:1b}
execute store result score #sx br.tmp run data get entity @s Pos[0]
execute store result score #sz br.tmp run data get entity @s Pos[2]
tellraw @a[tag=br.playing] [{text:"✈ 空中補給が投下！ ",color:"gold",bold:true},{text:"X:",color:"yellow"},{score:{name:"#sx",objective:"br.tmp"},color:"white"},{text:" Z:",color:"yellow"},{score:{name:"#sz",objective:"br.tmp"},color:"white"},{text:"（光る柱を目印に）",color:"gray"}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.firework_rocket.launch player @s ~ ~ ~ 1.5 0.8

tag @s remove br.supply_wait
tag @s add br.supply_fx
scoreboard players set @s br.sup 0
execute if score @s br.suptype matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/chest_site
execute if score @s br.suptype matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/chest_site
execute if score @s br.suptype matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score @s br.suptype matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score @s br.suptype matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score @s br.suptype matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score @s br.suptype matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/food
execute if score @s br.suptype matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
execute if score @s br.suptype matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_site
execute if score @s br.suptype matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_basic
execute as @e[type=minecraft:item,distance=..3,nbt={Age:0s}] run data merge entity @s {Glowing:1b}
execute store result score #sx br.tmp run data get entity @s Pos[0]
execute store result score #sz br.tmp run data get entity @s Pos[2]
tellraw @a[tag=br.playing] [{text:"✈ 空中補給が着地！ ",color:"gold",bold:true},{text:"X:",color:"yellow"},{score:{name:"#sx",objective:"br.tmp"},color:"white"},{text:" Z:",color:"yellow"},{score:{name:"#sz",objective:"br.tmp"},color:"white"},{text:"（光る柱とアイテムの光が目印）",color:"gray"}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat

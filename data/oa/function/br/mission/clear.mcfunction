scoreboard players set @s br.mdone 1
scoreboard players add @s oa.mclear 1
# 1.9.186: ごほうびは応急キット1つ（以前は包帯か応急キット）
loot give @s loot oa:br/medkit
tellraw @a[tag=br.playing] [{text:"★ ",color:"gold"},{selector:"@s"},{text:" が今回のお題を達成！",color:"yellow"}]
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 1
function oa:ach/give {id:"mission1",name:"お題達成"}
execute if score @s oa.mclear matches 5.. run function oa:ach/give {id:"mission5",name:"お題マスター"}

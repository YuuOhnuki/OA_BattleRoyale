tag @s remove br.supply_wait
# 着地した瞬間から通常の武器・CT表示へ戻す
scoreboard players set #sup_on br.tmp 0
scoreboard players set #sup_phase br.tmp 0
tag @s add br.supply_fx
scoreboard players set @s br.sup 0
scoreboard players operation #sup_grade br.tmp = @s br.suptype
function oa:br/supply/contents
execute store result score #sx br.tmp run data get entity @s Pos[0]
execute store result score #sz br.tmp run data get entity @s Pos[2]
tellraw @a[tag=br.playing] [{text:"✈ 補給が着地！ ",color:"gold",bold:true},{text:"光る柱が目印",color:"gray"}]
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat

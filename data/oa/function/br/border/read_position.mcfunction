execute store result score #tx br.x run data get entity @s Pos[0] 1000
execute store result score #tz br.z run data get entity @s Pos[2] 1000
execute in oa:br store result score #bw br.tmp run worldborder get
scoreboard players operation #bh br.tmp = #bw br.tmp
scoreboard players operation #bh br.tmp *= #500 br.tmp
# One-block inward margin covers rounded get-size, player width, and command center float precision.
scoreboard players remove #bh br.tmp 1000
scoreboard players operation #left br.x = #cx br.x
scoreboard players operation #right br.x = #cx br.x
scoreboard players operation #front br.z = #cz br.z
scoreboard players operation #back br.z = #cz br.z
scoreboard players operation #left br.x -= #bh br.tmp
scoreboard players operation #right br.x += #bh br.tmp
scoreboard players operation #front br.z -= #bh br.tmp
scoreboard players operation #back br.z += #bh br.tmp
execute if score #tx br.x >= #left br.x if score #tx br.x <= #right br.x if score #tz br.z >= #front br.z if score #tz br.z <= #back br.z run scoreboard players set #inside br.flag 1
kill @s

particle minecraft:snowflake ~ ~1 ~ 0.5 0.6 0.5 0.02 12 normal @s
title @s actionbar {text:"❄ 寒波！ 屋根の下へ入るか、革の胸当てを着よう",color:"aqua"}
effect give @s minecraft:slowness 2 0 true
execute if score #dis_m br.tmp matches 0 run damage @s 1 minecraft:freeze

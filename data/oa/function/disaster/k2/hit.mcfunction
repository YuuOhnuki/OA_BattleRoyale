particle minecraft:snowflake ~ ~1 ~ 0.5 0.6 0.5 0.02 12 normal @s
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"❄ 寒波！ 屋根の下へ入るか、革の胸当てを着よう",color:"aqua"}
effect give @s minecraft:slowness 2 1 true
damage @s 2 minecraft:freeze

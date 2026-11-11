execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
function oa:curse/radar/prepare
tellraw @s {text:"[キリング] 全プレイヤー位置（現在時点・本人のみ表示）",color:"light_purple"}
execute as @a[tag=!oa.radar_viewer] at @s run function oa:curse/radar/chat_target
tag @s remove oa.radar_viewer

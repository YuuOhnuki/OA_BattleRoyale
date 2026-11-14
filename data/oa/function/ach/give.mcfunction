$execute if entity @s[advancements={oa:ach/$(id)=true}] run return 0
execute unless entity @s[type=minecraft:player] run return 0
# 練習場では実績を解除しない
execute if entity @s[tag=oa.practice] run return 0
execute if dimension oa:practice run return 0
$advancement grant @s only oa:ach/$(id)
# 1.9.157: 実績名にカーソルを合わせると説明が出る（名前と説明は ach/info が oa:ach_info に置く）
$function oa:ach/announce with storage oa:ach_info $(id)
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 1 1

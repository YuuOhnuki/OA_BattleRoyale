execute unless entity @s[tag=br.admin] run return 0
function oa:admin/control/actor
scoreboard players operation #control_target oa.tmp = @s oa.control
scoreboard players set #control_ten oa.tmp 10
scoreboard players operation #control_action oa.tmp = #control_target oa.tmp
scoreboard players operation #control_action oa.tmp %= #control_ten oa.tmp
scoreboard players add #control_action oa.tmp 1
scoreboard players operation #control_target oa.tmp /= #control_ten oa.tmp
execute unless score #control_action oa.tmp matches 1..5 run return 0
scoreboard players set #control_found oa.tmp 0
execute as @a if score @s oa.id = #control_target oa.tmp at @s run function oa:admin/control/queue
execute if score #control_found oa.tmp matches 0 run tellraw @s {text:"対象が退出しています。一覧を開き直してください。",color:"yellow"}

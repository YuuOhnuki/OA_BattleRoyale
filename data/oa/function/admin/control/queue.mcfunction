scoreboard players set #control_found oa.tmp 1
execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players add @s oa.left 0
scoreboard players operation @s oa.pending = #control_action oa.tmp
scoreboard players operation @s oa.qby = #control_actor oa.tmp
scoreboard players operation @s oa.qleft = @s oa.left
execute if entity @s[nbt={Health:0.0f}] run tellraw @s {text:"管理操作を予約しました。リスポーン後に自動実行します。",color:"gold"}
execute if entity @s[nbt={Health:0.0f}] as @a[tag=br.admin] if score @s oa.id = #control_actor oa.tmp run tellraw @s {text:"操作を予約しました。対象のリスポーン後に自動実行します。",color:"gold"}
function oa:admin/control/process

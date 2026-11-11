execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
scoreboard players set #ach_found oa.tmp 0
$execute as @a[name="$(player)"] run function oa:admin/ach/reset_one
execute if score #ach_found oa.tmp matches 0 run tellraw @s {text:"対象のオンラインプレイヤーが見つかりません。",color:"yellow"}
execute if score #ach_found oa.tmp matches 1 run tellraw @s {text:"実績をリセットしました。",color:"green"}

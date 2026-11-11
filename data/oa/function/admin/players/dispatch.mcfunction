execute unless entity @s[tag=br.admin] run return 0
scoreboard players operation #roster_id oa.tmp = @s oa.roster
scoreboard players set #two oa.tmp 2
scoreboard players operation #roster_op oa.tmp = #roster_id oa.tmp
scoreboard players operation #roster_op oa.tmp %= #two oa.tmp
scoreboard players operation #roster_id oa.tmp /= #two oa.tmp
tag @a remove oa.roster_actor
tag @s add oa.roster_actor
scoreboard players set #roster_found oa.tmp 0
execute as @a if score @s oa.id = #roster_id oa.tmp at @s run function oa:admin/players/apply
execute if score #roster_found oa.tmp matches 0 run tellraw @s {text:"対象が退出しています。参加者一覧を開き直してください。",color:"yellow"}
tag @s remove oa.roster_actor

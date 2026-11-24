# 1.9.247：この置き場（本人＝マーカー）の標的がいなければ出す
scoreboard players operation #kp oa.tmp = @s oa.kb_pair
scoreboard players set #kf oa.tmp 0
execute as @e[type=minecraft:zombie,tag=oa.kb_target] if score @s oa.kb_pair = #kp oa.tmp run scoreboard players set #kf oa.tmp 1
execute if score #kf oa.tmp matches 0 summon minecraft:zombie run function oa:practice/kb/init

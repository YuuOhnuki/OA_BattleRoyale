effect give @s minecraft:nausea 5 0 true
effect give @s minecraft:slowness 2 0 true
particle minecraft:poof ~ ~0.1 ~ 0.5 0.1 0.5 0.02 6 normal @a[distance=..30]
playsound minecraft:block.deepslate.break player @s ~ ~ ~ 2 0.5
# 直近1秒に、歩く・走る・しゃがみ移動・ジャンプのどれかをしたか（統計。ノックバックやテレポートは含まない）
scoreboard players set #q_moved br.tmp 0
execute if score @s br.qwalk matches 1.. run scoreboard players set #q_moved br.tmp 1
execute if score @s br.qspr matches 1.. run scoreboard players set #q_moved br.tmp 1
execute if score @s br.qsneak matches 1.. run scoreboard players set #q_moved br.tmp 1
execute if score @s br.qjump matches 1.. run scoreboard players set #q_moved br.tmp 1
scoreboard players set @s br.qwalk 0
scoreboard players set @s br.qspr 0
scoreboard players set @s br.qsneak 0
scoreboard players set @s br.qjump 0
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"⚠ 地震！ 動くと毎秒3ダメージ｜止まって耐えよう",color:"gold"}
execute if score #q_moved br.tmp matches 1 run damage @s 3 minecraft:fall

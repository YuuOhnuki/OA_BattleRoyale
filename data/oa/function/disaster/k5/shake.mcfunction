effect give @s minecraft:nausea 5 0 true
effect give @s minecraft:slowness 2 0 true
particle minecraft:poof ~ ~0.1 ~ 0.5 0.1 0.5 0.02 6 normal @a[distance=..30]
playsound minecraft:block.deepslate.break player @s ~ ~ ~ 2 0.5
# 直近1秒に、歩く・走る・しゃがみ移動・ジャンプのどれかをしたか（統計。ノックバックやテレポートは含まない）
scoreboard players set #q_moved br.tmp 0
# 1.9.152: 通信の遅れや止まりきるまでのわずかな移動では当たらないよう、歩く・走る・しゃがみの合計が60cm以上、またはジャンプ1回以上で「動いた」とする
scoreboard players set #q_sum br.tmp 0
scoreboard players operation #q_sum br.tmp += @s br.qwalk
scoreboard players operation #q_sum br.tmp += @s br.qspr
scoreboard players operation #q_sum br.tmp += @s br.qsneak
execute if score #q_sum br.tmp matches 60.. run scoreboard players set #q_moved br.tmp 1
execute if score @s br.qjump matches 1.. run scoreboard players set #q_moved br.tmp 1
scoreboard players set @s br.qwalk 0
scoreboard players set @s br.qspr 0
scoreboard players set @s br.qsneak 0
scoreboard players set @s br.qjump 0
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"⚠ 地震！ 動くと毎秒3ダメージ｜止まって耐えよう",color:"gold"}
# 開始から最初の2秒は猶予（反応と通信の遅れのため）。#dis_left は開始時10で、1秒ごとに減る
execute if score #q_moved br.tmp matches 1 if score #dis_left br.tmp matches ..7 run damage @s 3 minecraft:fall

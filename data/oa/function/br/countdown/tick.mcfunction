# 1.9.213: カウントダウンの1tick（br/tick から。この間、試合時間・縮小・補給・災害などは進まない）
scoreboard players remove #countdown br.tmp 1
execute if score #countdown br.tmp matches 99 run function oa:br/countdown/show {n:5,color:"green",pitch:0.7}
execute if score #countdown br.tmp matches 79 run function oa:br/countdown/show {n:4,color:"green",pitch:0.8}
execute if score #countdown br.tmp matches 59 run function oa:br/countdown/show {n:3,color:"yellow",pitch:0.9}
execute if score #countdown br.tmp matches 39 run function oa:br/countdown/show {n:2,color:"gold",pitch:1.0}
execute if score #countdown br.tmp matches 19 run function oa:br/countdown/show {n:1,color:"red",pitch:1.1}
execute if score #countdown br.tmp matches ..0 run function oa:br/countdown/go

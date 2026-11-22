# 1.9.222：2キル目のごほうびの抽選（1試合1回。br.yukill は br/result/reset で0に戻す）
scoreboard players set @s br.yukill 1
execute store result score #kill_yu br.tmp run random value 1..4
execute unless score #kill_yu br.tmp matches 1 run return 0
function oa:give/internal/overwork
tellraw @s [{text:"✦ 2キルのごほうび！ ",color:"gold",bold:true},{"text":"ゆー：オーバーワーク","color":"#55C985","italic":false,"bold":true},{text:" が足元に出ました",color:"yellow"}]
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 1.4
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.8 0.5 0.3 30 normal @a[distance=..32]

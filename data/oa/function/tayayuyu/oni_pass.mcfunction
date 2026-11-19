# 1.9.192: 鬼に殴られた（進捗 oa:tayayuyu/oni_pass、殴られた人として）。爆弾を移す
advancement revoke @s only oa:tayayuyu/oni_pass
execute unless score #g_oni oa.tmp matches 1.. run return 0
execute if entity @s[tag=oa.g_oni] run return 0
execute unless entity @s[tag=br.alive,gamemode=!spectator] run return 0
execute if entity @a[tag=oa.g_oni,scores={oa.goni_cd=1..}] run return 0
tag @a remove oa.g_oni_prev
tag @a[tag=oa.g_oni] add oa.g_oni_prev
execute as @a[tag=oa.g_oni_prev] run function oa:tayayuyu/oni_drop
execute at @s run function oa:tayayuyu/oni_take
scoreboard players operation #oni_sec oa.tmp = #g_oni oa.tmp
scoreboard players add #oni_sec oa.tmp 19
scoreboard players set #c20 oa.tmp 20
scoreboard players operation #oni_sec oa.tmp /= #c20 oa.tmp
tellraw @a[tag=br.playing] [{text:"💣 ",color:"red"},{selector:"@a[tag=oa.g_oni_prev]",color:"white"},{text:" → ",color:"red",bold:true},{selector:"@s",color:"yellow"},{text:" に爆弾が移った！ 残り",color:"red"},{score:{name:"#oni_sec",objective:"oa.tmp"},color:"gold"},{text:"秒",color:"red"}]
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.8 0.5
execute at @a[tag=oa.g_oni_prev] run particle minecraft:poof ~ ~1 ~ 0.4 0.6 0.4 0.05 20 normal @a[distance=..32]
tag @a remove oa.g_oni_prev

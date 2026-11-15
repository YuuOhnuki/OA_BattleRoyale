# 1.9.186: 半径 = 5 + 5×（経過秒÷5）、最大30。中心からの水平の距離で判定（洞窟・ネザーの高さの差に関係なく）
scoreboard players set #five br.tmp 5
scoreboard players set #fog_el br.tmp 40
scoreboard players operation #fog_el br.tmp -= #dis_left br.tmp
scoreboard players operation #fog_r br.tmp = #fog_el br.tmp
scoreboard players operation #fog_r br.tmp /= #five br.tmp
scoreboard players add #fog_r br.tmp 1
scoreboard players operation #fog_r br.tmp *= #five br.tmp
execute if score #fog_r br.tmp matches 31.. run scoreboard players set #fog_r br.tmp 30
scoreboard players operation #fog_r2 br.tmp = #fog_r br.tmp
scoreboard players operation #fog_r2 br.tmp *= #fog_r br.tmp
# 見た目：中心のまわりに半径に合わせて霧の粒（広がるときは知らせる）
execute store result storage oa:disaster fog.d double 0.5 run scoreboard players get #fog_r br.tmp
scoreboard players operation #fog_n br.tmp = #fog_r br.tmp
scoreboard players operation #fog_n br.tmp *= #five br.tmp
scoreboard players operation #fog_n br.tmp *= #five br.tmp
execute store result storage oa:disaster fog.n int 1 run scoreboard players get #fog_n br.tmp
execute as @a[tag=br.alive,limit=1] at @s as @e[type=minecraft:marker,tag=br.dis_zone,distance=..2000] at @s run function oa:disaster/k4/zone with storage oa:disaster fog
scoreboard players operation #fog_m br.tmp = #fog_el br.tmp
scoreboard players operation #fog_m br.tmp %= #five br.tmp
execute if score #fog_m br.tmp matches 0 if score #fog_el br.tmp matches 5..25 run tellraw @a[tag=br.playing] [{text:"☠ 毒霧が広がった：中心から半径 ",color:"dark_green"},{score:{name:"#fog_r",objective:"br.tmp"},color:"green"},{text:" ブロック",color:"dark_green"}]
# 判定：生存者ごとに、中心からの水平の距離の2乗と半径の2乗を比べる
execute store result score #fog_cx br.tmp run data get storage oa:br center.x
execute store result score #fog_cz br.tmp run data get storage oa:br center.z
execute as @a[tag=br.alive,gamemode=!spectator] at @s run function oa:disaster/k4/check

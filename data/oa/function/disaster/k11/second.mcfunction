# 全てのブタから毎秒小さな爆発（ブロック・アイテムは壊さない。粒と音だけの爆発）
execute as @e[type=minecraft:pig,tag=oa.dis_pig] at @s run function oa:disaster/k11/boom
execute as @a[tag=br.alive,gamemode=!spectator] if entity @e[type=minecraft:pig,tag=oa.dis_pig,distance=..8] run function oa:disaster/k11/msg

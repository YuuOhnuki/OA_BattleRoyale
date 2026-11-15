# 1.9.189: エリアの外にいる時間（br.outt、tick）を5 tick ごとに数える（生存者として。br/tick から）。中にいれば0。
# br/zone/player は、外に出て2秒（40 tick）経つまでダメージを与えない（押し出されてもすぐ戻れば助かる）
execute unless dimension oa:br unless dimension oa:br_nether unless dimension oa:br_cave run return run scoreboard players add @s br.outt 5
execute store result score #ox br.x run data get entity @s Pos[0] 1000
execute store result score #oz br.z run data get entity @s Pos[2] 1000
scoreboard players set #oout br.flag 0
execute if score #ox br.x < #minx br.x run scoreboard players set #oout br.flag 1
execute if score #ox br.x > #maxx br.x run scoreboard players set #oout br.flag 1
execute if score #oz br.z < #minz br.z run scoreboard players set #oout br.flag 1
execute if score #oz br.z > #maxz br.z run scoreboard players set #oout br.flag 1
execute if score #oout br.flag matches 1 run scoreboard players add @s br.outt 5
execute if score #oout br.flag matches 0 run scoreboard players set @s br.outt 0

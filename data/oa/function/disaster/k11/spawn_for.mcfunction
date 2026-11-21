# 1隊12匹をまとめて確保。全体・ブタの上限で半端な隊列を作らない。
execute store result score #mob_all br.tmp if entity @e[tag=oa.dis_mob]
execute store result score #mob_capv br.tmp run data get storage oa:disaster cfg.mob_cap
scoreboard players add #mob_all br.tmp 12
execute if score #mob_all br.tmp > #mob_capv br.tmp run return 0
execute store result score #mob_all br.tmp if entity @e[tag=oa.dis_pig]
execute store result score #mob_capv br.tmp run data get storage oa:disaster cfg.pig_cap
scoreboard players add #mob_all br.tmp 12
execute if score #mob_all br.tmp > #mob_capv br.tmp run return 0
execute store result storage oa:disaster parade.owner int 1 run scoreboard players get @s oa.id
function oa:disaster/k11/formation with storage oa:disaster parade

execute store result score #room br.tmp run data get storage oa:disaster cfg.dot_cap
scoreboard players operation #room br.tmp -= @s br.ddmg
execute if score #dd br.tmp > #room br.tmp run scoreboard players operation #dd br.tmp = #room br.tmp

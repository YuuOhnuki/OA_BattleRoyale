execute if score @s oa.hop matches 1.. run scoreboard players add @s br.hstreak 1
execute unless score @s oa.hop matches 1.. run scoreboard players set @s br.hstreak 0
execute unless score @s oa.hop matches 1.. run scoreboard players set @s br.hopby 0
execute if score @s br.hstreak matches 400 if score @s br.hopby matches 1.. run function oa:ach/pichi_credit

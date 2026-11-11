advancement revoke @s only oa:overwork/used
# Native totem effects run after the advancement; apply additions next tick.
scoreboard players set @s oa.owait 2
tag @s add oa.overwork_pending
tag @s add oa.overwork_native

execute if entity @s[tag=oa.db_infinite,gamemode=!creative] run function oa:give/overwork

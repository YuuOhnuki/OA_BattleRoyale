execute unless score @s oa.i_pending matches 1..6 run return run function oa:itori/windup_cancel
scoreboard players operation @s oa.i_next = @s oa.i_pending
function oa:itori/windup_cancel
execute unless score @s oa.kind matches 10 run return 0
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run return 0
execute if entity @s[tag=oa.gacha_exposed] run return 0
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive,gamemode=!spectator] run return 0
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute if score @s oa.i_lock matches 1.. run return 0
swing @s mainhand stab 4t
playsound minecraft:entity.evoker.cast_spell player @a[distance=..28] ~ ~ ~ 1.0 0.8
scoreboard players set #i_cast_ok oa.tmp 1
execute if score @s oa.i_next matches 1 run function oa:itori/kaeya
execute if score @s oa.i_next matches 2 run function oa:itori/ineffa
execute if score @s oa.i_next matches 3 run function oa:itori/varesa
execute if score @s oa.i_next matches 4 run function oa:itori/xilonen
execute if score @s oa.i_next matches 5 run function oa:itori/flins
execute if score @s oa.i_next matches 6 run function oa:itori/mavuika
execute unless score #i_cast_ok oa.tmp matches 1 run return 0
scoreboard players add @s oa.i_next 1
scoreboard players set @s oa.i_lock 8
execute if score @s oa.i_next > @s oa.i_cycle run scoreboard players set @s oa.cd 200
execute if score @s oa.i_next > @s oa.i_cycle run scoreboard players set @s oa.i_next 1
function oa:itori/progress

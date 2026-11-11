execute unless entity @s[tag=br.admin] run return 0
execute unless score #state br.state matches 0 run return run tellraw @s {text:"デバッグは試合待機中のみ開始できます。",color:"red"}
execute if entity @s[tag=oa.debug] run return run function oa:debug/book
execute unless entity @s[tag=oa.player] run tag @s add oa.db_newplayer
function oa:test/join
tag @s add oa.debug
scoreboard players operation @s oa.db_seen = @s oa.left
scoreboard players set @s oa.db_cd 0
scoreboard players set @s oa.db_unique 0
scoreboard players set @s oa.db_match 0
scoreboard players set @s oa.db_grace 0
scoreboard players set @s oa.db_team 0
scoreboard players set @s oa.db_consume 0
scoreboard players set @s oa.db_wear 0
scoreboard players set @s oa.db_bind 0
scoreboard players set @s oa.db_mobs 1
scoreboard players set @s oa.db_heal 0
function oa:debug/apply
function oa:debug/book
tellraw @s {text:"デバッグ開始：本人のみ制限解除。設定は専用ブックへ。",color:"aqua"}

scoreboard players set @s oa.db_snow 0
scoreboard players set @s oa.db_egg 0

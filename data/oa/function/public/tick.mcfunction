execute as @a[scores={br.lobby=1..}] at @s run function oa:lobby/tp
execute as @a[scores={br.join=1..}] at @s run function oa:br/join
execute as @a[scores={br.leave=1..}] at @s run function oa:br/leave
execute as @a[scores={oa.menu=1..}] run function oa:public/menu
execute if score #state br.state matches 0 as @a[scores={oa.test=1..}] at @s run function oa:test/join
scoreboard players set @a br.join 0
scoreboard players set @a br.leave 0
scoreboard players set @a oa.menu 0
scoreboard players set @a oa.test 0
scoreboard players enable @a br.join
scoreboard players enable @a br.leave
scoreboard players enable @a oa.menu
scoreboard players enable @a oa.test
scoreboard players set @a br.lobby 0
scoreboard players enable @a br.lobby

execute as @a[scores={oa.return=1..}] at @s run function oa:lobby/return
execute as @a[scores={oa.admin=1..}] at @s run function oa:admin/dispatch
scoreboard players set @a oa.return 0
scoreboard players set @a oa.admin 0
scoreboard players enable @a oa.return
scoreboard players enable @a oa.admin

execute as @a[scores={oa.roster=1..}] at @s run function oa:admin/players/dispatch
scoreboard players set @a oa.roster 0
scoreboard players enable @a[tag=br.admin] oa.roster

execute as @a[scores={oa.lobby=1..}] at @s run function oa:lobby/guide/dispatch
scoreboard players set @a oa.lobby 0
scoreboard players enable @a oa.lobby

execute as @a[scores={oa.control=1..}] at @s run function oa:admin/control/dispatch
scoreboard players set @a oa.control 0
scoreboard players enable @a[tag=br.admin] oa.control
execute as @a[scores={oa.pending=1..5}] at @s run function oa:admin/control/process

execute as @a[scores={oa.debug_cmd=1..}] at @s run function oa:debug/dispatch
scoreboard players set @a oa.debug_cmd 0
scoreboard players enable @a[tag=br.admin] oa.debug_cmd

execute as @a[scores={oa.gallery=10}] run function oa:lobby/gallery/gacha_results
scoreboard players set @a oa.gallery 0
scoreboard players enable @a oa.gallery

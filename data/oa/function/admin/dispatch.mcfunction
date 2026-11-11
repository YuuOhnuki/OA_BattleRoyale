execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"管理者未登録です。OPが初回だけ /function oa:admin を実行してください。",color:"red"}
execute if score @s oa.admin matches 20..28 run function oa:test/join
execute if score @s oa.admin matches 36..37 run function oa:test/join
execute if score @s oa.admin matches 1 run function oa:admin/menu
execute if score @s oa.admin matches 2 run function oa:admin/status
execute if score @s oa.admin matches 3 run function oa:map/create
execute if score @s oa.admin matches 4 run function oa:lobby/create
execute if score @s oa.admin matches 5 run function oa:br/start_solo
execute if score @s oa.admin matches 6 run function oa:br/start_team
execute if score @s oa.admin matches 7 run function oa:br/finish
execute if score @s oa.admin matches 9 run function oa:give/bat
execute if score @s oa.admin matches 10 run function oa:give/stick
execute if score @s oa.admin matches 11 run function oa:map/pause
execute if score @s oa.admin matches 12 run function oa:map/resume
execute if score @s oa.admin matches 13 if score #state br.state matches 0 run function oa:map/rebuild
execute if score @s oa.admin matches 14 run function oa:lobby/upgrade
execute if score @s oa.admin matches 16 run function oa:admin/book
execute if score @s oa.admin matches 17 run function oa:give/buffs

execute if score @s oa.admin matches 20 run function oa:give/yuua

execute if score @s oa.admin matches 21 run function oa:give/pichipichi

execute if score @s oa.admin matches 22 run function oa:give/lazi

execute if score @s oa.admin matches 23 run function oa:give/nero

execute if score @s oa.admin matches 24 run function oa:give/killing

execute if score @s oa.admin matches 25 run function oa:give/yuttari

execute if score @s oa.admin matches 26 run function oa:give/hotchikisu

execute if score @s oa.admin matches 27 run function oa:give/komame

execute if score @s oa.admin matches 28 run function oa:give/overwork

execute if score @s oa.admin matches 29 run function oa:br/center

execute if score @s oa.admin matches 30 run function oa:admin/generated_center

execute if score @s oa.admin matches 31 run function oa:map/teleport

execute if score @s oa.admin matches 32 run function oa:lobby/return

execute if score @s oa.admin matches 33 run function oa:admin/defaults

execute if score @s oa.admin matches 34 run function oa:admin/projectile_check

execute if score @s oa.admin matches 35 run function oa:admin/players/menu

execute if score @s oa.admin matches 36 run function oa:give/tayayuyu

execute if score @s oa.admin matches 37 run function oa:give/furoball

execute if score @s oa.admin matches 38 run function oa:admin/control/self_menu
execute if score @s oa.admin matches 39 run function oa:admin/control/self_revive

execute if score @s oa.admin matches 40 run function oa:debug/start
execute if score @s oa.admin matches 41 run function oa:debug/book

execute if score @s oa.admin matches 42 run loot give @s loot oa:debug/bandage
execute if score @s oa.admin matches 43 run loot give @s loot oa:debug/kit
execute if score @s oa.admin matches 44 run give @s minecraft:snowball 16
execute if score @s oa.admin matches 45 run give @s minecraft:egg 16

execute if score @s oa.admin matches 46 run function oa:lobby/gallery/update

execute if score @s oa.admin matches 47 run function oa:admin/delete_lobby
execute if score @s oa.admin matches 48 run function oa:map/delete
execute if score @s oa.admin matches 49 run function oa:br/border/auto

execute if score @s oa.admin matches 51 run function oa:admin/update_skins

execute if score @s oa.admin matches 53 run function oa:test/join
execute if score @s oa.admin matches 53 run function oa:give/itori

execute if score @s oa.admin matches 54 at @s run function oa:br/spawn_points/add

execute if score @s oa.admin matches 55 at @s run function oa:br/spawn_points/list

execute if score @s oa.admin matches 56 at @s run function oa:br/spawn_points/remove

execute if score @s oa.admin matches 57 at @s run function oa:br/spawn_points/clear

execute if score @s oa.admin matches 58 run function oa:practice/create

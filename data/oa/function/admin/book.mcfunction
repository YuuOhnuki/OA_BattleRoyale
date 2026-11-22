execute unless entity @s[tag=br.admin] run return 0
clear @s *[minecraft:custom_data~{oa_admin_book:1b}]
scoreboard players set #admin_free oa.tmp 0
execute unless items entity @s hotbar.0 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.1 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.2 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.3 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.4 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.5 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.6 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.7 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s hotbar.8 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.0 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.1 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.2 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.3 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.4 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.5 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.6 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.7 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.8 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.9 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.10 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.11 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.12 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.13 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.14 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.15 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.16 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.17 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.18 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.19 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.20 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.21 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.22 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.23 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.24 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.25 * run scoreboard players set #admin_free oa.tmp 1
execute unless items entity @s inventory.26 * run scoreboard players set #admin_free oa.tmp 1
execute if score #admin_free oa.tmp matches 0 run return run tellraw @s {text:"本を受け取るため持ち物に空きを作ってください",color:"yellow"}
data modify storage oa:admin_book mode set value "バトルロワイヤル"
execute if score #game oa.game matches 1 run data modify storage oa:admin_book mode set value "チームデスマッチ"
data modify storage oa:admin_book map set value "地上"
execute if score #map oa.mapid matches 1 run data modify storage oa:admin_book map set value "ネザー"
execute if score #map oa.mapid matches 2 run data modify storage oa:admin_book map set value "地下（古代都市）"
execute if score #map oa.mapid matches 3 run data modify storage oa:admin_book map set value "天空都市"
execute if score #map oa.mapid matches 4 run data modify storage oa:admin_book map set value "異界"
execute if score #game oa.game matches 1 run data modify storage oa:admin_book map set value "立体工廠"
data modify storage oa:admin_book state set value "待機中（取得時点）"
execute if score #state br.state matches 1.. run data modify storage oa:admin_book state set value "試合進行中（取得時点）"
function oa:admin/book_content with storage oa:admin_book
tellraw @s {text:"管理ブックを更新しました。最新の状態は /oamenu で確認できます",color:"gold"}

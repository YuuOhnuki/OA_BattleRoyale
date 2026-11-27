# 1.9.253: inventory/hold_head で預かった元の頭の物を、空いているホットバー・インベントリへ入れる。空きがなければ足もとへ落とす（従来と同じ）
execute unless entity @e[type=minecraft:item,tag=oa.hat_hold,limit=1] run return 0
execute unless items entity @s hotbar.0 * run return run function oa:inventory/release_to {slot:"hotbar.0"}
execute unless items entity @s hotbar.1 * run return run function oa:inventory/release_to {slot:"hotbar.1"}
execute unless items entity @s hotbar.2 * run return run function oa:inventory/release_to {slot:"hotbar.2"}
execute unless items entity @s hotbar.3 * run return run function oa:inventory/release_to {slot:"hotbar.3"}
execute unless items entity @s hotbar.4 * run return run function oa:inventory/release_to {slot:"hotbar.4"}
execute unless items entity @s hotbar.5 * run return run function oa:inventory/release_to {slot:"hotbar.5"}
execute unless items entity @s hotbar.6 * run return run function oa:inventory/release_to {slot:"hotbar.6"}
execute unless items entity @s hotbar.7 * run return run function oa:inventory/release_to {slot:"hotbar.7"}
execute unless items entity @s hotbar.8 * run return run function oa:inventory/release_to {slot:"hotbar.8"}
execute unless items entity @s inventory.0 * run return run function oa:inventory/release_to {slot:"inventory.0"}
execute unless items entity @s inventory.1 * run return run function oa:inventory/release_to {slot:"inventory.1"}
execute unless items entity @s inventory.2 * run return run function oa:inventory/release_to {slot:"inventory.2"}
execute unless items entity @s inventory.3 * run return run function oa:inventory/release_to {slot:"inventory.3"}
execute unless items entity @s inventory.4 * run return run function oa:inventory/release_to {slot:"inventory.4"}
execute unless items entity @s inventory.5 * run return run function oa:inventory/release_to {slot:"inventory.5"}
execute unless items entity @s inventory.6 * run return run function oa:inventory/release_to {slot:"inventory.6"}
execute unless items entity @s inventory.7 * run return run function oa:inventory/release_to {slot:"inventory.7"}
execute unless items entity @s inventory.8 * run return run function oa:inventory/release_to {slot:"inventory.8"}
execute unless items entity @s inventory.9 * run return run function oa:inventory/release_to {slot:"inventory.9"}
execute unless items entity @s inventory.10 * run return run function oa:inventory/release_to {slot:"inventory.10"}
execute unless items entity @s inventory.11 * run return run function oa:inventory/release_to {slot:"inventory.11"}
execute unless items entity @s inventory.12 * run return run function oa:inventory/release_to {slot:"inventory.12"}
execute unless items entity @s inventory.13 * run return run function oa:inventory/release_to {slot:"inventory.13"}
execute unless items entity @s inventory.14 * run return run function oa:inventory/release_to {slot:"inventory.14"}
execute unless items entity @s inventory.15 * run return run function oa:inventory/release_to {slot:"inventory.15"}
execute unless items entity @s inventory.16 * run return run function oa:inventory/release_to {slot:"inventory.16"}
execute unless items entity @s inventory.17 * run return run function oa:inventory/release_to {slot:"inventory.17"}
execute unless items entity @s inventory.18 * run return run function oa:inventory/release_to {slot:"inventory.18"}
execute unless items entity @s inventory.19 * run return run function oa:inventory/release_to {slot:"inventory.19"}
execute unless items entity @s inventory.20 * run return run function oa:inventory/release_to {slot:"inventory.20"}
execute unless items entity @s inventory.21 * run return run function oa:inventory/release_to {slot:"inventory.21"}
execute unless items entity @s inventory.22 * run return run function oa:inventory/release_to {slot:"inventory.22"}
execute unless items entity @s inventory.23 * run return run function oa:inventory/release_to {slot:"inventory.23"}
execute unless items entity @s inventory.24 * run return run function oa:inventory/release_to {slot:"inventory.24"}
execute unless items entity @s inventory.25 * run return run function oa:inventory/release_to {slot:"inventory.25"}
execute unless items entity @s inventory.26 * run return run function oa:inventory/release_to {slot:"inventory.26"}
execute as @e[type=minecraft:item,tag=oa.hat_hold] run data merge entity @s {PickupDelay:100s,NoGravity:0b,Invulnerable:0b}
scoreboard players set @e[type=minecraft:item,tag=oa.hat_hold] oa.wait 100
tag @e[type=minecraft:item,tag=oa.hat_hold] remove oa.hat_hold

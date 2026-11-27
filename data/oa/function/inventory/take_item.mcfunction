# 1.9.256: macro: tag  足もとに出した物（タグ $(tag) の item）を、空いているホットバー・インベントリのマスへ直接入れる（@s＝受け取る人）。
# 空きがなければ足もとに残し、すぐ拾えるようにする（PickupDelay 0）
$execute unless entity @e[type=minecraft:item,tag=$(tag),limit=1] run return 0
$execute unless items entity @s hotbar.0 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.0"}
$execute unless items entity @s hotbar.1 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.1"}
$execute unless items entity @s hotbar.2 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.2"}
$execute unless items entity @s hotbar.3 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.3"}
$execute unless items entity @s hotbar.4 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.4"}
$execute unless items entity @s hotbar.5 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.5"}
$execute unless items entity @s hotbar.6 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.6"}
$execute unless items entity @s hotbar.7 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.7"}
$execute unless items entity @s hotbar.8 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"hotbar.8"}
$execute unless items entity @s inventory.0 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.0"}
$execute unless items entity @s inventory.1 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.1"}
$execute unless items entity @s inventory.2 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.2"}
$execute unless items entity @s inventory.3 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.3"}
$execute unless items entity @s inventory.4 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.4"}
$execute unless items entity @s inventory.5 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.5"}
$execute unless items entity @s inventory.6 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.6"}
$execute unless items entity @s inventory.7 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.7"}
$execute unless items entity @s inventory.8 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.8"}
$execute unless items entity @s inventory.9 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.9"}
$execute unless items entity @s inventory.10 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.10"}
$execute unless items entity @s inventory.11 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.11"}
$execute unless items entity @s inventory.12 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.12"}
$execute unless items entity @s inventory.13 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.13"}
$execute unless items entity @s inventory.14 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.14"}
$execute unless items entity @s inventory.15 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.15"}
$execute unless items entity @s inventory.16 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.16"}
$execute unless items entity @s inventory.17 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.17"}
$execute unless items entity @s inventory.18 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.18"}
$execute unless items entity @s inventory.19 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.19"}
$execute unless items entity @s inventory.20 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.20"}
$execute unless items entity @s inventory.21 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.21"}
$execute unless items entity @s inventory.22 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.22"}
$execute unless items entity @s inventory.23 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.23"}
$execute unless items entity @s inventory.24 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.24"}
$execute unless items entity @s inventory.25 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.25"}
$execute unless items entity @s inventory.26 * run return run function oa:inventory/take_item_to {tag:"$(tag)",slot:"inventory.26"}
$execute as @e[type=minecraft:item,tag=$(tag)] run data merge entity @s {PickupDelay:0s}

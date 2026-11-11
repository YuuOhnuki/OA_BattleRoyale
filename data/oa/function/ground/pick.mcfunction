# Player executor; only one transfer succeeds, and no item is consumed on full inventory.
tag @e[type=minecraft:item,tag=oa.pick] remove oa.pick
execute as @e[type=minecraft:item,tag=oa.ground,scores={oa.wait=0},distance=..1.5,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:1}}}}},sort=nearest,limit=1] run tag @s add oa.pick
execute unless entity @e[tag=oa.pick] as @e[type=minecraft:item,tag=oa.ground,scores={oa.wait=0},distance=..1.5,sort=nearest,limit=1] run tag @s add oa.pick
execute unless entity @e[tag=oa.pick] run return 0
execute if data entity @e[tag=oa.pick,limit=1] Item.components."minecraft:custom_data".oa{kind:1} run return run function oa:ground/force_yuua
execute unless items entity @s hotbar.0 * run return run function oa:ground/transfer {slot:"hotbar.0"}
execute unless items entity @s hotbar.1 * run return run function oa:ground/transfer {slot:"hotbar.1"}
execute unless items entity @s hotbar.2 * run return run function oa:ground/transfer {slot:"hotbar.2"}
execute unless items entity @s hotbar.3 * run return run function oa:ground/transfer {slot:"hotbar.3"}
execute unless items entity @s hotbar.4 * run return run function oa:ground/transfer {slot:"hotbar.4"}
execute unless items entity @s hotbar.5 * run return run function oa:ground/transfer {slot:"hotbar.5"}
execute unless items entity @s hotbar.6 * run return run function oa:ground/transfer {slot:"hotbar.6"}
execute unless items entity @s hotbar.7 * run return run function oa:ground/transfer {slot:"hotbar.7"}
execute unless items entity @s hotbar.8 * run return run function oa:ground/transfer {slot:"hotbar.8"}
execute unless items entity @s inventory.0 * run return run function oa:ground/transfer {slot:"inventory.0"}
execute unless items entity @s inventory.1 * run return run function oa:ground/transfer {slot:"inventory.1"}
execute unless items entity @s inventory.2 * run return run function oa:ground/transfer {slot:"inventory.2"}
execute unless items entity @s inventory.3 * run return run function oa:ground/transfer {slot:"inventory.3"}
execute unless items entity @s inventory.4 * run return run function oa:ground/transfer {slot:"inventory.4"}
execute unless items entity @s inventory.5 * run return run function oa:ground/transfer {slot:"inventory.5"}
execute unless items entity @s inventory.6 * run return run function oa:ground/transfer {slot:"inventory.6"}
execute unless items entity @s inventory.7 * run return run function oa:ground/transfer {slot:"inventory.7"}
execute unless items entity @s inventory.8 * run return run function oa:ground/transfer {slot:"inventory.8"}
execute unless items entity @s inventory.9 * run return run function oa:ground/transfer {slot:"inventory.9"}
execute unless items entity @s inventory.10 * run return run function oa:ground/transfer {slot:"inventory.10"}
execute unless items entity @s inventory.11 * run return run function oa:ground/transfer {slot:"inventory.11"}
execute unless items entity @s inventory.12 * run return run function oa:ground/transfer {slot:"inventory.12"}
execute unless items entity @s inventory.13 * run return run function oa:ground/transfer {slot:"inventory.13"}
execute unless items entity @s inventory.14 * run return run function oa:ground/transfer {slot:"inventory.14"}
execute unless items entity @s inventory.15 * run return run function oa:ground/transfer {slot:"inventory.15"}
execute unless items entity @s inventory.16 * run return run function oa:ground/transfer {slot:"inventory.16"}
execute unless items entity @s inventory.17 * run return run function oa:ground/transfer {slot:"inventory.17"}
execute unless items entity @s inventory.18 * run return run function oa:ground/transfer {slot:"inventory.18"}
execute unless items entity @s inventory.19 * run return run function oa:ground/transfer {slot:"inventory.19"}
execute unless items entity @s inventory.20 * run return run function oa:ground/transfer {slot:"inventory.20"}
execute unless items entity @s inventory.21 * run return run function oa:ground/transfer {slot:"inventory.21"}
execute unless items entity @s inventory.22 * run return run function oa:ground/transfer {slot:"inventory.22"}
execute unless items entity @s inventory.23 * run return run function oa:ground/transfer {slot:"inventory.23"}
execute unless items entity @s inventory.24 * run return run function oa:ground/transfer {slot:"inventory.24"}
execute unless items entity @s inventory.25 * run return run function oa:ground/transfer {slot:"inventory.25"}
execute unless items entity @s inventory.26 * run return run function oa:ground/transfer {slot:"inventory.26"}

$data modify storage oa:br_backup p$(id) set value {slots:{},team:"",count:0}
summon minecraft:item_display ~ ~ ~ {Tags:["br.reader"]}
scoreboard players set #nonempty br.tmp 0
scoreboard players set #saved br.tmp 0
execute if items entity @s hotbar.0 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.0
$execute if items entity @s hotbar.0 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s0 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.0 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.1 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.1
$execute if items entity @s hotbar.1 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s1 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.1 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.2 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.2
$execute if items entity @s hotbar.2 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s2 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.2 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.3 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.3
$execute if items entity @s hotbar.3 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s3 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.3 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.4 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.4
$execute if items entity @s hotbar.4 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s4 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.4 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.5 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.5
$execute if items entity @s hotbar.5 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s5 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.5 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.6 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.6
$execute if items entity @s hotbar.6 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s6 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.6 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.7 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.7
$execute if items entity @s hotbar.7 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s7 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.7 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s hotbar.8 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s hotbar.8
$execute if items entity @s hotbar.8 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s8 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s hotbar.8 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.0 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.0
$execute if items entity @s inventory.0 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s9 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.0 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.1 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.1
$execute if items entity @s inventory.1 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s10 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.1 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.2 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.2
$execute if items entity @s inventory.2 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s11 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.2 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.3 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.3
$execute if items entity @s inventory.3 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s12 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.3 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.4 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.4
$execute if items entity @s inventory.4 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s13 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.4 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.5 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.5
$execute if items entity @s inventory.5 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s14 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.5 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.6 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.6
$execute if items entity @s inventory.6 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s15 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.6 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.7 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.7
$execute if items entity @s inventory.7 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s16 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.7 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.8 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.8
$execute if items entity @s inventory.8 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s17 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.8 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.9 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.9
$execute if items entity @s inventory.9 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s18 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.9 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.10 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.10
$execute if items entity @s inventory.10 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s19 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.10 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.11 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.11
$execute if items entity @s inventory.11 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s20 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.11 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.12 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.12
$execute if items entity @s inventory.12 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s21 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.12 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.13 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.13
$execute if items entity @s inventory.13 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s22 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.13 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.14 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.14
$execute if items entity @s inventory.14 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s23 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.14 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.15 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.15
$execute if items entity @s inventory.15 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s24 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.15 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.16 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.16
$execute if items entity @s inventory.16 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s25 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.16 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.17 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.17
$execute if items entity @s inventory.17 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s26 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.17 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.18 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.18
$execute if items entity @s inventory.18 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s27 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.18 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.19 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.19
$execute if items entity @s inventory.19 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s28 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.19 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.20 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.20
$execute if items entity @s inventory.20 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s29 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.20 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.21 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.21
$execute if items entity @s inventory.21 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s30 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.21 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.22 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.22
$execute if items entity @s inventory.22 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s31 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.22 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.23 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.23
$execute if items entity @s inventory.23 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s32 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.23 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.24 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.24
$execute if items entity @s inventory.24 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s33 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.24 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.25 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.25
$execute if items entity @s inventory.25 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s34 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.25 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s inventory.26 * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s inventory.26
$execute if items entity @s inventory.26 * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s35 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s inventory.26 * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s armor.head * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s armor.head
$execute if items entity @s armor.head * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s36 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s armor.head * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s armor.chest * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s armor.chest
$execute if items entity @s armor.chest * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s37 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s armor.chest * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s armor.legs * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s armor.legs
$execute if items entity @s armor.legs * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s38 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s armor.legs * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s armor.feet * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s armor.feet
$execute if items entity @s armor.feet * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s39 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s armor.feet * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
execute if items entity @s weapon.offhand * run scoreboard players add #nonempty br.tmp 1
item replace entity @e[tag=br.reader,limit=1] contents with minecraft:air
item replace entity @e[tag=br.reader,limit=1] contents from entity @s weapon.offhand
$execute if items entity @s weapon.offhand * store success score #ok br.flag run data modify storage oa:br_backup p$(id).slots.s40 set from entity @e[tag=br.reader,limit=1] item
execute if items entity @s weapon.offhand * if score #ok br.flag matches 1 run scoreboard players add #saved br.tmp 1
kill @e[tag=br.reader]
execute unless score #saved br.tmp = #nonempty br.tmp run return 0
$execute store result storage oa:br_backup p$(id).count int 1 run scoreboard players get #saved br.tmp
$data modify storage oa:br_backup p$(id).team set from entity @s Team
scoreboard players set @s br.mode 0
execute if entity @s[gamemode=creative] run scoreboard players set @s br.mode 1
execute if entity @s[gamemode=adventure] run scoreboard players set @s br.mode 2
execute if entity @s[gamemode=spectator] run scoreboard players set @s br.mode 3
execute store result score @s br.x run experience query @s levels
execute store result score @s br.z run experience query @s points
function oa:nero/save
$data modify storage oa:br_backup p$(id).position set from storage oa:position value
scoreboard players set @s br.team 0
execute if score @s oa.team matches 0.. run scoreboard players operation @s br.team = @s oa.team
scoreboard players operation @s br.flag = @s br.pick
scoreboard players set @s br.phase 0
execute if entity @s[tag=oa.player] run scoreboard players set @s br.phase 1
scoreboard players set @s br.saved 1

scoreboard players set @s br.restore 0
scoreboard players set @s br.retry 0

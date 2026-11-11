tag @s remove br.gm_override
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
tag @s remove br.native_grace
tag @s remove br.pvp_grace
tag @s remove br.mining_allowed
$execute unless data storage oa:br_backup p$(id).position run return run tellraw @s {text:"保存データがありません。復元を中断しました",color:"red"}
kill @e[tag=br.restore_item]
scoreboard players set #prepared br.tmp 0
$execute if data storage oa:br_backup p$(id).slots.s0 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot0"]}
$execute if data storage oa:br_backup p$(id).slots.s0 run data modify entity @e[tag=br.slot0,limit=1] item set from storage oa:br_backup p$(id).slots.s0
execute if items entity @e[tag=br.slot0,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s1 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot1"]}
$execute if data storage oa:br_backup p$(id).slots.s1 run data modify entity @e[tag=br.slot1,limit=1] item set from storage oa:br_backup p$(id).slots.s1
execute if items entity @e[tag=br.slot1,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s2 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot2"]}
$execute if data storage oa:br_backup p$(id).slots.s2 run data modify entity @e[tag=br.slot2,limit=1] item set from storage oa:br_backup p$(id).slots.s2
execute if items entity @e[tag=br.slot2,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s3 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot3"]}
$execute if data storage oa:br_backup p$(id).slots.s3 run data modify entity @e[tag=br.slot3,limit=1] item set from storage oa:br_backup p$(id).slots.s3
execute if items entity @e[tag=br.slot3,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s4 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot4"]}
$execute if data storage oa:br_backup p$(id).slots.s4 run data modify entity @e[tag=br.slot4,limit=1] item set from storage oa:br_backup p$(id).slots.s4
execute if items entity @e[tag=br.slot4,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s5 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot5"]}
$execute if data storage oa:br_backup p$(id).slots.s5 run data modify entity @e[tag=br.slot5,limit=1] item set from storage oa:br_backup p$(id).slots.s5
execute if items entity @e[tag=br.slot5,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s6 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot6"]}
$execute if data storage oa:br_backup p$(id).slots.s6 run data modify entity @e[tag=br.slot6,limit=1] item set from storage oa:br_backup p$(id).slots.s6
execute if items entity @e[tag=br.slot6,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s7 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot7"]}
$execute if data storage oa:br_backup p$(id).slots.s7 run data modify entity @e[tag=br.slot7,limit=1] item set from storage oa:br_backup p$(id).slots.s7
execute if items entity @e[tag=br.slot7,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s8 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot8"]}
$execute if data storage oa:br_backup p$(id).slots.s8 run data modify entity @e[tag=br.slot8,limit=1] item set from storage oa:br_backup p$(id).slots.s8
execute if items entity @e[tag=br.slot8,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s9 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot9"]}
$execute if data storage oa:br_backup p$(id).slots.s9 run data modify entity @e[tag=br.slot9,limit=1] item set from storage oa:br_backup p$(id).slots.s9
execute if items entity @e[tag=br.slot9,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s10 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot10"]}
$execute if data storage oa:br_backup p$(id).slots.s10 run data modify entity @e[tag=br.slot10,limit=1] item set from storage oa:br_backup p$(id).slots.s10
execute if items entity @e[tag=br.slot10,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s11 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot11"]}
$execute if data storage oa:br_backup p$(id).slots.s11 run data modify entity @e[tag=br.slot11,limit=1] item set from storage oa:br_backup p$(id).slots.s11
execute if items entity @e[tag=br.slot11,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s12 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot12"]}
$execute if data storage oa:br_backup p$(id).slots.s12 run data modify entity @e[tag=br.slot12,limit=1] item set from storage oa:br_backup p$(id).slots.s12
execute if items entity @e[tag=br.slot12,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s13 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot13"]}
$execute if data storage oa:br_backup p$(id).slots.s13 run data modify entity @e[tag=br.slot13,limit=1] item set from storage oa:br_backup p$(id).slots.s13
execute if items entity @e[tag=br.slot13,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s14 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot14"]}
$execute if data storage oa:br_backup p$(id).slots.s14 run data modify entity @e[tag=br.slot14,limit=1] item set from storage oa:br_backup p$(id).slots.s14
execute if items entity @e[tag=br.slot14,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s15 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot15"]}
$execute if data storage oa:br_backup p$(id).slots.s15 run data modify entity @e[tag=br.slot15,limit=1] item set from storage oa:br_backup p$(id).slots.s15
execute if items entity @e[tag=br.slot15,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s16 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot16"]}
$execute if data storage oa:br_backup p$(id).slots.s16 run data modify entity @e[tag=br.slot16,limit=1] item set from storage oa:br_backup p$(id).slots.s16
execute if items entity @e[tag=br.slot16,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s17 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot17"]}
$execute if data storage oa:br_backup p$(id).slots.s17 run data modify entity @e[tag=br.slot17,limit=1] item set from storage oa:br_backup p$(id).slots.s17
execute if items entity @e[tag=br.slot17,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s18 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot18"]}
$execute if data storage oa:br_backup p$(id).slots.s18 run data modify entity @e[tag=br.slot18,limit=1] item set from storage oa:br_backup p$(id).slots.s18
execute if items entity @e[tag=br.slot18,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s19 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot19"]}
$execute if data storage oa:br_backup p$(id).slots.s19 run data modify entity @e[tag=br.slot19,limit=1] item set from storage oa:br_backup p$(id).slots.s19
execute if items entity @e[tag=br.slot19,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s20 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot20"]}
$execute if data storage oa:br_backup p$(id).slots.s20 run data modify entity @e[tag=br.slot20,limit=1] item set from storage oa:br_backup p$(id).slots.s20
execute if items entity @e[tag=br.slot20,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s21 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot21"]}
$execute if data storage oa:br_backup p$(id).slots.s21 run data modify entity @e[tag=br.slot21,limit=1] item set from storage oa:br_backup p$(id).slots.s21
execute if items entity @e[tag=br.slot21,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s22 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot22"]}
$execute if data storage oa:br_backup p$(id).slots.s22 run data modify entity @e[tag=br.slot22,limit=1] item set from storage oa:br_backup p$(id).slots.s22
execute if items entity @e[tag=br.slot22,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s23 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot23"]}
$execute if data storage oa:br_backup p$(id).slots.s23 run data modify entity @e[tag=br.slot23,limit=1] item set from storage oa:br_backup p$(id).slots.s23
execute if items entity @e[tag=br.slot23,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s24 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot24"]}
$execute if data storage oa:br_backup p$(id).slots.s24 run data modify entity @e[tag=br.slot24,limit=1] item set from storage oa:br_backup p$(id).slots.s24
execute if items entity @e[tag=br.slot24,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s25 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot25"]}
$execute if data storage oa:br_backup p$(id).slots.s25 run data modify entity @e[tag=br.slot25,limit=1] item set from storage oa:br_backup p$(id).slots.s25
execute if items entity @e[tag=br.slot25,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s26 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot26"]}
$execute if data storage oa:br_backup p$(id).slots.s26 run data modify entity @e[tag=br.slot26,limit=1] item set from storage oa:br_backup p$(id).slots.s26
execute if items entity @e[tag=br.slot26,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s27 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot27"]}
$execute if data storage oa:br_backup p$(id).slots.s27 run data modify entity @e[tag=br.slot27,limit=1] item set from storage oa:br_backup p$(id).slots.s27
execute if items entity @e[tag=br.slot27,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s28 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot28"]}
$execute if data storage oa:br_backup p$(id).slots.s28 run data modify entity @e[tag=br.slot28,limit=1] item set from storage oa:br_backup p$(id).slots.s28
execute if items entity @e[tag=br.slot28,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s29 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot29"]}
$execute if data storage oa:br_backup p$(id).slots.s29 run data modify entity @e[tag=br.slot29,limit=1] item set from storage oa:br_backup p$(id).slots.s29
execute if items entity @e[tag=br.slot29,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s30 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot30"]}
$execute if data storage oa:br_backup p$(id).slots.s30 run data modify entity @e[tag=br.slot30,limit=1] item set from storage oa:br_backup p$(id).slots.s30
execute if items entity @e[tag=br.slot30,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s31 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot31"]}
$execute if data storage oa:br_backup p$(id).slots.s31 run data modify entity @e[tag=br.slot31,limit=1] item set from storage oa:br_backup p$(id).slots.s31
execute if items entity @e[tag=br.slot31,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s32 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot32"]}
$execute if data storage oa:br_backup p$(id).slots.s32 run data modify entity @e[tag=br.slot32,limit=1] item set from storage oa:br_backup p$(id).slots.s32
execute if items entity @e[tag=br.slot32,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s33 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot33"]}
$execute if data storage oa:br_backup p$(id).slots.s33 run data modify entity @e[tag=br.slot33,limit=1] item set from storage oa:br_backup p$(id).slots.s33
execute if items entity @e[tag=br.slot33,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s34 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot34"]}
$execute if data storage oa:br_backup p$(id).slots.s34 run data modify entity @e[tag=br.slot34,limit=1] item set from storage oa:br_backup p$(id).slots.s34
execute if items entity @e[tag=br.slot34,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s35 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot35"]}
$execute if data storage oa:br_backup p$(id).slots.s35 run data modify entity @e[tag=br.slot35,limit=1] item set from storage oa:br_backup p$(id).slots.s35
execute if items entity @e[tag=br.slot35,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s36 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot36"]}
$execute if data storage oa:br_backup p$(id).slots.s36 run data modify entity @e[tag=br.slot36,limit=1] item set from storage oa:br_backup p$(id).slots.s36
execute if items entity @e[tag=br.slot36,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s37 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot37"]}
$execute if data storage oa:br_backup p$(id).slots.s37 run data modify entity @e[tag=br.slot37,limit=1] item set from storage oa:br_backup p$(id).slots.s37
execute if items entity @e[tag=br.slot37,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s38 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot38"]}
$execute if data storage oa:br_backup p$(id).slots.s38 run data modify entity @e[tag=br.slot38,limit=1] item set from storage oa:br_backup p$(id).slots.s38
execute if items entity @e[tag=br.slot38,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s39 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot39"]}
$execute if data storage oa:br_backup p$(id).slots.s39 run data modify entity @e[tag=br.slot39,limit=1] item set from storage oa:br_backup p$(id).slots.s39
execute if items entity @e[tag=br.slot39,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute if data storage oa:br_backup p$(id).slots.s40 run summon minecraft:item_display ~ ~ ~ {Tags:["br.restore_item","br.slot40"]}
$execute if data storage oa:br_backup p$(id).slots.s40 run data modify entity @e[tag=br.slot40,limit=1] item set from storage oa:br_backup p$(id).slots.s40
execute if items entity @e[tag=br.slot40,limit=1] contents * run scoreboard players add #prepared br.tmp 1
$execute store result score #expected br.tmp run data get storage oa:br_backup p$(id).count
execute unless score #prepared br.tmp = #expected br.tmp run return run function oa:br/restore_failed
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
execute if entity @s[tag=oa.external_blind] run effect clear @s minecraft:blindness
execute if entity @s[tag=oa.external_speed] run effect clear @s minecraft:speed
execute if entity @s[tag=oa.external_slow] run effect clear @s minecraft:slowness
execute if entity @s[tag=br.spawn_protection] run effect clear @s minecraft:resistance
tag @s remove oa.external_blind
tag @s remove oa.external_speed
tag @s remove oa.external_slow
function oa:status/reset
function oa:internal/cleanup
execute if score @s br.restore matches 0 unless entity @s[tag=oa.practice] run function oa:br/drop_inventory
# A retry clears only the incomplete restoration, not dropping another copy of saved items.
scoreboard players set @s br.restore 1
function oa:br/clear_inventory
scoreboard players set #copied br.tmp 0
execute if items entity @e[tag=br.slot0,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.0 from entity @e[tag=br.slot0,limit=1] contents
execute if items entity @e[tag=br.slot0,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot1,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.1 from entity @e[tag=br.slot1,limit=1] contents
execute if items entity @e[tag=br.slot1,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot2,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.2 from entity @e[tag=br.slot2,limit=1] contents
execute if items entity @e[tag=br.slot2,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot3,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.3 from entity @e[tag=br.slot3,limit=1] contents
execute if items entity @e[tag=br.slot3,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot4,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.4 from entity @e[tag=br.slot4,limit=1] contents
execute if items entity @e[tag=br.slot4,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot5,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.5 from entity @e[tag=br.slot5,limit=1] contents
execute if items entity @e[tag=br.slot5,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot6,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.6 from entity @e[tag=br.slot6,limit=1] contents
execute if items entity @e[tag=br.slot6,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot7,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.7 from entity @e[tag=br.slot7,limit=1] contents
execute if items entity @e[tag=br.slot7,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot8,limit=1] contents * store success score #ok br.flag run item replace entity @s hotbar.8 from entity @e[tag=br.slot8,limit=1] contents
execute if items entity @e[tag=br.slot8,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot9,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.0 from entity @e[tag=br.slot9,limit=1] contents
execute if items entity @e[tag=br.slot9,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot10,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.1 from entity @e[tag=br.slot10,limit=1] contents
execute if items entity @e[tag=br.slot10,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot11,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.2 from entity @e[tag=br.slot11,limit=1] contents
execute if items entity @e[tag=br.slot11,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot12,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.3 from entity @e[tag=br.slot12,limit=1] contents
execute if items entity @e[tag=br.slot12,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot13,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.4 from entity @e[tag=br.slot13,limit=1] contents
execute if items entity @e[tag=br.slot13,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot14,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.5 from entity @e[tag=br.slot14,limit=1] contents
execute if items entity @e[tag=br.slot14,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot15,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.6 from entity @e[tag=br.slot15,limit=1] contents
execute if items entity @e[tag=br.slot15,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot16,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.7 from entity @e[tag=br.slot16,limit=1] contents
execute if items entity @e[tag=br.slot16,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot17,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.8 from entity @e[tag=br.slot17,limit=1] contents
execute if items entity @e[tag=br.slot17,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot18,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.9 from entity @e[tag=br.slot18,limit=1] contents
execute if items entity @e[tag=br.slot18,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot19,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.10 from entity @e[tag=br.slot19,limit=1] contents
execute if items entity @e[tag=br.slot19,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot20,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.11 from entity @e[tag=br.slot20,limit=1] contents
execute if items entity @e[tag=br.slot20,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot21,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.12 from entity @e[tag=br.slot21,limit=1] contents
execute if items entity @e[tag=br.slot21,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot22,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.13 from entity @e[tag=br.slot22,limit=1] contents
execute if items entity @e[tag=br.slot22,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot23,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.14 from entity @e[tag=br.slot23,limit=1] contents
execute if items entity @e[tag=br.slot23,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot24,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.15 from entity @e[tag=br.slot24,limit=1] contents
execute if items entity @e[tag=br.slot24,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot25,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.16 from entity @e[tag=br.slot25,limit=1] contents
execute if items entity @e[tag=br.slot25,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot26,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.17 from entity @e[tag=br.slot26,limit=1] contents
execute if items entity @e[tag=br.slot26,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot27,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.18 from entity @e[tag=br.slot27,limit=1] contents
execute if items entity @e[tag=br.slot27,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot28,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.19 from entity @e[tag=br.slot28,limit=1] contents
execute if items entity @e[tag=br.slot28,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot29,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.20 from entity @e[tag=br.slot29,limit=1] contents
execute if items entity @e[tag=br.slot29,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot30,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.21 from entity @e[tag=br.slot30,limit=1] contents
execute if items entity @e[tag=br.slot30,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot31,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.22 from entity @e[tag=br.slot31,limit=1] contents
execute if items entity @e[tag=br.slot31,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot32,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.23 from entity @e[tag=br.slot32,limit=1] contents
execute if items entity @e[tag=br.slot32,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot33,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.24 from entity @e[tag=br.slot33,limit=1] contents
execute if items entity @e[tag=br.slot33,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot34,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.25 from entity @e[tag=br.slot34,limit=1] contents
execute if items entity @e[tag=br.slot34,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot35,limit=1] contents * store success score #ok br.flag run item replace entity @s inventory.26 from entity @e[tag=br.slot35,limit=1] contents
execute if items entity @e[tag=br.slot35,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot36,limit=1] contents * store success score #ok br.flag run item replace entity @s armor.head from entity @e[tag=br.slot36,limit=1] contents
execute if items entity @e[tag=br.slot36,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot37,limit=1] contents * store success score #ok br.flag run item replace entity @s armor.chest from entity @e[tag=br.slot37,limit=1] contents
execute if items entity @e[tag=br.slot37,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot38,limit=1] contents * store success score #ok br.flag run item replace entity @s armor.legs from entity @e[tag=br.slot38,limit=1] contents
execute if items entity @e[tag=br.slot38,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot39,limit=1] contents * store success score #ok br.flag run item replace entity @s armor.feet from entity @e[tag=br.slot39,limit=1] contents
execute if items entity @e[tag=br.slot39,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
execute if items entity @e[tag=br.slot40,limit=1] contents * store success score #ok br.flag run item replace entity @s weapon.offhand from entity @e[tag=br.slot40,limit=1] contents
execute if items entity @e[tag=br.slot40,limit=1] contents * if score #ok br.flag matches 1 run scoreboard players add #copied br.tmp 1
kill @e[tag=br.restore_item]
execute unless score #copied br.tmp = #expected br.tmp run return run function oa:br/copy_failed
$data modify storage oa:br_work position set from storage oa:br_backup p$(id).position
function oa:internal/tp with storage oa:br_work position
gamemode survival @s
execute if score @s br.mode matches 1 run gamemode creative @s
execute if score @s br.mode matches 2 run gamemode adventure @s
execute if score @s br.mode matches 3 run gamemode spectator @s
team leave @s
$data modify storage oa:br_work team set from storage oa:br_backup p$(id).team
execute if entity @s[tag=oa.practice] unless data storage oa:br_work {team:""} run function oa:br/restore_team with storage oa:br_work
execute store result storage oa:br_work levels int 1 run scoreboard players get @s br.x
execute store result storage oa:br_work points int 1 run scoreboard players get @s br.z
function oa:br/restore_xp with storage oa:br_work
execute if entity @s[tag=oa.practice] run scoreboard players operation @s oa.team = @s br.team
execute unless entity @s[tag=oa.practice] run scoreboard players set @s oa.team 0
tag @s remove br.winner
tag @s remove br.playing
tag @s remove br.alive
tag @s remove br.spawn_protection
execute if score @s br.phase matches 0 run tag @s remove oa.player
scoreboard players set @s oa.kind -1
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
scoreboard players set @s oa.cd 0
scoreboard players set @s oa.death 0
scoreboard players set @s br.saved 0
scoreboard players set @s br.restore 0
$data remove storage oa:br_backup p$(id)
execute if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin

function oa:tayayuyu/clear

function oa:furoball/clear_up

execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 900
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
scoreboard players operation #gacha_event oa.tmp = #serial oa.serial
execute store result score #gacha_roll oa.tmp run random value 1..15
function oa:combat/select_targets
tag @s add oa.target
execute if score #gacha_roll oa.tmp matches 1 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：体力",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 2 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：炎",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 3 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：復活",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 4 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：帽子",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 5 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：TNT",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 6 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：全員ちび化",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 7 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：席替えタイム",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 8 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：強制集合",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 9 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：全員キリング気分",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 10 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：丸見え大会",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 11 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：空腹の時間",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 12 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：全員巨大化",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 13 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：瀕死の時間",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 14 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：足が棒",color:"light_purple"}
execute if score #gacha_roll oa.tmp matches 15 run tellraw @a[tag=oa.debug] {text:"たやゆゆ変態ガチャ：完全無防備",color:"light_purple"}
playsound minecraft:block.end_portal.spawn player @a[tag=oa.debug,distance=..32] ~ ~ ~ 1.2 1.5
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 1 0.7 0.2 60 normal @a[distance=..48]
execute if score #gacha_roll oa.tmp matches 1 run function oa:debug/gacha/1
execute if score #gacha_roll oa.tmp matches 2 run function oa:debug/gacha/2
execute if score #gacha_roll oa.tmp matches 3 run function oa:debug/gacha/4
execute if score #gacha_roll oa.tmp matches 4 run function oa:debug/gacha/6
execute if score #gacha_roll oa.tmp matches 5 run function oa:debug/gacha/7
execute if score #gacha_roll oa.tmp matches 6 run function oa:debug/gacha/8
execute if score #gacha_roll oa.tmp matches 7 run function oa:debug/gacha/9
execute if score #gacha_roll oa.tmp matches 8 run function oa:debug/gacha/10
execute if score #gacha_roll oa.tmp matches 9 run function oa:debug/gacha/12
execute if score #gacha_roll oa.tmp matches 10 run function oa:debug/gacha/13
execute if score #gacha_roll oa.tmp matches 11 run function oa:debug/gacha/14
execute if score #gacha_roll oa.tmp matches 12 run function oa:debug/gacha/15
execute if score #gacha_roll oa.tmp matches 13 run function oa:debug/gacha/17
execute if score #gacha_roll oa.tmp matches 14 run function oa:debug/gacha/18
execute if score #gacha_roll oa.tmp matches 15 run function oa:debug/gacha/19
function oa:combat/finish

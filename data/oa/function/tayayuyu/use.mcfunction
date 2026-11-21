execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.db_free_match] run return run function oa:debug/gacha/use
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return run tellraw @s {text:"試合中に使用してください。",color:"yellow"}
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 900
scoreboard players add @s br.gacha 1
execute if score @s br.gacha matches 3 run function oa:ach/give {id:"tayayuyu_gacha3",name:"引きの強さ"}
execute if score @s br.gacha matches 5 run function oa:ach/give {id:"tayayuyu_master",name:"たやゆゆの申し子"}
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
function oa:tayayuyu/roll
# 1.9.146: 距離で聞こえなくならないよう、各参加者の位置で鳴らして全員に聞こえるようにする
execute as @a[tag=br.playing] at @s run playsound minecraft:block.end_portal.spawn player @s ~ ~ ~ 1.2 1.5
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 1 0.7 0.2 60 normal @a[distance=..48]
# 1.9.173: ハズレを1試合で3回引くと「たやゆゆに愛される」（1.9.192 からハズレは12・13・16）
execute if score #gacha_roll oa.tmp matches 12..13 run scoreboard players add @s br.a_haz 1
execute if score #gacha_roll oa.tmp matches 16 run scoreboard players add @s br.a_haz 1
execute if score #gacha_roll oa.tmp matches 12..16 unless score #gacha_roll oa.tmp matches 14..15 if score @s br.a_haz matches 3.. run function oa:ach/give {id:"tayayuyu_unlucky",name:"たやゆゆに愛される"}
function oa:tayayuyu/apply

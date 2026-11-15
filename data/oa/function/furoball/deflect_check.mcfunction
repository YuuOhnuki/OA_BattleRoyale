# 1.9.186: ふろボールの打ち返しの判定（ボールとして、ボールの位置で。furoball/tick から）
scoreboard players operation #fid oa.tmp = @s oa.fid
tag @e[type=minecraft:interaction,tag=oa.f_hb] remove oa.f_hb
execute as @e[type=minecraft:interaction,tag=oa.furo_hitbox,distance=..6] if score @s oa.fid = #fid oa.tmp run tag @s add oa.f_hb
# 当たり判定がなければ（古いボール・読み込みのずれ）作り直す
execute unless entity @e[type=minecraft:interaction,tag=oa.f_hb] run summon minecraft:interaction ~ ~-0.45 ~ {Tags:["oa.furo_hitbox","oa.f_hb"],width:0.9f,height:0.9f,response:1b}
scoreboard players operation @e[type=minecraft:interaction,tag=oa.f_hb] oa.fid = #fid oa.tmp
scoreboard players set @e[type=minecraft:interaction,tag=oa.f_hb] oa.fhb 3
tp @e[type=minecraft:interaction,tag=oa.f_hb,limit=1] ~ ~-0.45 ~
tag @a remove oa.f_deflector
# 殴った人（interaction の attack）
execute as @e[type=minecraft:interaction,tag=oa.f_hb,limit=1] if data entity @s attack on attacker if entity @s[type=minecraft:player,gamemode=!spectator] run tag @s add oa.f_deflector
data remove entity @e[type=minecraft:interaction,tag=oa.f_hb,limit=1] attack
# 矢が当たった（ボールのまわり1.3ブロックの、刺さっていない矢・光の矢）。撃った人の弾にする
execute unless entity @a[tag=oa.f_deflector] as @e[type=#minecraft:arrows,distance=..1.3,nbt={inGround:0b},limit=1] on origin if entity @s[type=minecraft:player,gamemode=!spectator] run tag @s add oa.f_deflector
execute if entity @a[tag=oa.f_deflector] run kill @e[type=#minecraft:arrows,distance=..1.3,nbt={inGround:0b},limit=1]
execute if entity @a[tag=oa.f_deflector] run function oa:furoball/deflect

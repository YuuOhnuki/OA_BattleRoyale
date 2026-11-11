function oa:overwork/cleanup
function oa:hotchikisu/cleanup
# Explicit test reset also renews this mask's lifetime before returning it to the ground.
execute store result storage oa:args serial int 1 run scoreboard players get @s oa.owner
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/reset_age with storage oa:args
execute if entity @s[tag=oa.external_blind] run effect clear @s minecraft:blindness
tag @s remove oa.external_blind
function oa:status/reset
function oa:internal/cleanup
execute if entity @s[tag=oa.external_slow] run effect clear @s minecraft:slowness
execute if entity @s[tag=oa.external_speed] run effect clear @s minecraft:speed
tag @s remove oa.external_slow
tag @s remove oa.external_speed
scoreboard players set @s oa.cd 0
scoreboard players set @s oa.skill 0
scoreboard players set @s oa.alt 0
scoreboard players set @s oa.use 0
scoreboard players set @s oa.death 0
# Release binding safely by dropping the exact helmet, not destroying it.
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:inventory/drop {slot:"armor.head"}
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind 0
scoreboard players operation @s oa.seen = @s oa.left
scoreboard players operation @s oa.epoch = #epoch oa.epoch
tellraw @s {text:"OA状態・CTをリセット。呪いマスクは地面へ返却（再取得まで5秒）。他の所持品とゲームモードは維持。",color:"green"}
advancement revoke @s only oa:yuua/struck
tag @s remove oa.hat_victim
tag @s remove oa.routed_damage

scoreboard players set @s oa.water 0
scoreboard players set @s oa.wdelay 0
scoreboard players set @s oa.noise 0
tag @s remove oa.water_jump
execute if entity @s[tag=oa.external_glow] run effect clear @s minecraft:glowing
tag @s remove oa.external_glow

scoreboard players set @s oa.sonic 0

function oa:furoball/clear_up

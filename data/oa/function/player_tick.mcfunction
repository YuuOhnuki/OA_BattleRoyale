execute if score #perf oa.tmp matches 0 unless entity @s[tag=oa.debug] run function oa:debug/restore_foreign
tag @s add oa.current
execute unless score @s oa.seen = @s oa.left run function oa:internal/rejoin
execute unless score @s oa.epoch = #epoch oa.epoch run function oa:internal/rejoin
execute if score @s oa.death matches 1.. run function oa:internal/death
execute if entity @s[gamemode=spectator] run tag @s remove oa.current
execute if entity @s[gamemode=spectator] run return 0
# Complete the same-hit guard from the previous tick before accepting new input.
execute if entity @s[tag=oa.decoy_grace] run function oa:nero/decoy_release
scoreboard players remove @s[scores={oa.cd=1..}] oa.cd 1
scoreboard players remove @s[scores={oa.mark=1..}] oa.mark 1
scoreboard players remove @s[scores={oa.decoy=1..}] oa.decoy 1
scoreboard players remove @s[scores={oa.breath=1..}] oa.breath 1
scoreboard players remove @s[tag=oa.ambush_active,scores={oa.back=1..}] oa.back 1
execute if entity @s[tag=oa.ambush_active,scores={oa.back=0}] run function oa:yuttari/return
function oa:status/tick
execute unless entity @s[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug] run function oa:inventory/check
execute if entity @s[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug,tag=oa.inv_dirty] run function oa:perf/inventory_scan
function oa:inventory/upgrade_melee
execute if entity @s[tag=oa.db_multi] run function oa:ground/pick
execute unless entity @s[tag=oa.db_multi] if score @s oa.have matches 0 run function oa:ground/pick
# Newly acquired curse is equipped next tick; all effects are resolved from actual slots.
scoreboard players operation @s oa.old = @s oa.kind
scoreboard players set @s oa.kind 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set @s oa.kind 1
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:2}}] run scoreboard players set @s oa.kind 2
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:3}}] run scoreboard players set @s oa.kind 3
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:4}}] run scoreboard players set @s oa.kind 4
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run scoreboard players set @s oa.kind 5
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:6}}] run scoreboard players set @s oa.kind 6
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s oa.kind 7
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set @s oa.kind 7
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:8}}] run scoreboard players set @s oa.kind 8
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players set @s oa.kind 9
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run scoreboard players set @s oa.kind 10
execute unless score @s oa.kind = @s oa.old run function oa:internal/active_changed
execute if entity @s[tag=oa.db_multi] if score @s oa.kind matches 5 run function oa:debug/read_owner
execute if score @s oa.kind matches 1 run function oa:yuua/tick
execute if score @s oa.kind matches 2 run function oa:fish/tick
scoreboard players set @s oa.riptide 0
execute if items entity @s weapon.offhand minecraft:trident[minecraft:custom_data~{oa:{kind:2}}] run item modify entity @s weapon.offhand oa:fish_riptide_off
execute if score @s oa.kind matches 3 run function oa:lazi/tick
execute if score @s oa.kind matches 4 run function oa:nero/tick
execute if score @s oa.kind matches 5 run function oa:curse/tick
execute if score @s oa.kind matches 8 run function oa:komame/tick
execute if score @s oa.use matches 1.. run function oa:skill
execute if score @s oa.skill matches 1.. run function oa:skill
execute if score @s oa.alt matches 1.. if score @s oa.kind matches 4 run function oa:nero/decoy
scoreboard players set @s oa.use 0
scoreboard players set @s oa.skill 0
scoreboard players set @s oa.alt 0
scoreboard players enable @s oa.skill
scoreboard players enable @s oa.alt
execute unless entity @s[tag=br.playing] unless entity @s[tag=br.lobby_now,tag=!oa.debug] if score #clock oa.beat matches 5.. run function oa:br/zone/hud
execute if entity @s[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug] if score #perf oa.tmp matches 0 run function oa:br/zone/hud
tag @s remove oa.current

execute if score #clock oa.beat matches 1 if items entity @s weapon.mainhand *[minecraft:custom_data~{oa_overwork:1b}] run item modify entity @s weapon.mainhand oa:lore/yu
execute if score #clock oa.beat matches 1 if items entity @s weapon.offhand *[minecraft:custom_data~{oa_overwork:1b}] run item modify entity @s weapon.offhand oa:lore/yu


scoreboard players remove @s[scores={oa.i_lock=1..}] oa.i_lock 1
execute if score @s oa.kind matches 10 at @s run function oa:itori/held

execute unless score @s oa.kind matches 10 if entity @s[tag=br.alive] at @s run function oa:itori/owned_tick
execute unless score @s oa.kind matches 10 if entity @s[tag=oa.debug,tag=!br.alive] at @s run function oa:itori/owned_tick

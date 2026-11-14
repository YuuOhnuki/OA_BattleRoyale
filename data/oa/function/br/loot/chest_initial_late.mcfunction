function oa:br/loot/reset_open
function oa:br/loot/drop_chest
execute if score #chest_ok br.flag matches 0 run return 0
loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_upgraded
# 1.9.168: 特別チェストは鉄の防具を必ず1つ（chest_site と同じ最低保証。tick 7200 以降に初めて読み込まれた場合はここで足す）
execute if entity @s[tag=br.rich] run loot insert ~ ~ ~ loot oa:br/rich_iron
scoreboard players operation @s br.round = #round br.round
scoreboard players set @s br.cstage 1
function oa:br/loot/chest_rare
execute unless items block ~ ~ ~ container.* * run item replace block ~ ~ ~ container.0 with minecraft:bread 1

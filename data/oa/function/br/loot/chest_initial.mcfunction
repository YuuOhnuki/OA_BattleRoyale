function oa:br/loot/reset_open
# 1.9.159: 1.9.157〜1.9.158 でチェストの名前に付けた残り時間を消す（読み込まれていなかったチェストの分）
execute if entity @s[tag=!br.rich] run data remove block ~ ~ ~ CustomName
execute if score #time br.time matches 7200.. run return run function oa:br/loot/chest_initial_late
function oa:br/loot/drop_chest
execute if score #chest_ok br.flag matches 0 run return 0
execute if entity @s[tag=!br.rich] run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
execute if entity @s[tag=br.rich] run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site
scoreboard players operation @s br.round = #round br.round
scoreboard players set @s br.cstage 0
execute if entity @s[tag=br.rich] run scoreboard players set @s br.cstage 1
function oa:br/loot/chest_rare
execute unless items block ~ ~ ~ container.* * run item replace block ~ ~ ~ container.0 with minecraft:bread 1

scoreboard players operation #cd br.tmp = @s oa.cd
scoreboard players add #cd br.tmp 19
scoreboard players operation #cd br.tmp /= #20 br.tmp
function oa:br/ui/item_name
execute store result storage oa:br_hud cd int 1 run scoreboard players get #cd br.tmp
function oa:br/ui/actionbar with storage oa:br_hud

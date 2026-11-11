scoreboard players operation #view_phase br.tmp = @s oa.id
scoreboard players operation #view_phase br.tmp %= #ten br.tmp
execute if score #view_phase br.tmp = #vclock br.tmp run function oa:br/zone/visual

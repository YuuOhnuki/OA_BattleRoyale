scoreboard players add #member br.tmp 1
scoreboard players operation @s br.member = #member br.tmp
execute store result storage oa:br_ui_args row int 1 run scoreboard players get #member br.tmp
function oa:br/ui/member_name with storage oa:br_ui_args

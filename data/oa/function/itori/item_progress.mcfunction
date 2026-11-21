scoreboard players set #itori_text_up oa.tmp 0
execute if entity @s[tag=br.alive,tag=!oa.practice] if score #state br.state matches 1 if score #time br.time matches 7200.. run scoreboard players set #itori_text_up oa.tmp 1
$execute if score #itori_text_up oa.tmp matches 0 unless items entity @s $(slot) *[minecraft:custom_data~{oa:{description205:1b,itori_text205:$(points),description_up:0b}}] run item modify entity @s $(slot) oa:lore/k10_progress_$(points)
$execute if score #itori_text_up oa.tmp matches 1 unless items entity @s $(slot) *[minecraft:custom_data~{oa:{description205:1b,itori_text205:$(points),description_up:1b}}] run item modify entity @s $(slot) oa:lore/k10_progress_$(points)_plus1

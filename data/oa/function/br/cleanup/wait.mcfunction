execute unless score #busy br.clean matches 1 run return 0
scoreboard players add #wait br.clean 1
execute if score #wait br.clean matches ..1 run return run schedule function oa:br/cleanup/wait 1t replace
scoreboard players set #ready br.clean 1
function oa:br/cleanup/check_tile
execute if score #wait br.clean matches 200.. run return run function oa:br/cleanup/abort
execute if score #ready br.clean matches 0 run scoreboard players set #settle br.clean 0
execute if score #ready br.clean matches 0 run return run schedule function oa:br/cleanup/wait 1t replace
scoreboard players add #settle br.clean 1
execute if score #settle br.clean matches ..2 run return run schedule function oa:br/cleanup/wait 1t replace
function oa:br/cleanup_loose with storage oa:br center
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:text_display,tag=br.open_label]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:text_display,tag=br.open_label]
function oa:br/cleanup/release
scoreboard players add #quad br.clean 1
execute if score #quad br.clean matches ..3 run return run function oa:br/cleanup/tile
function oa:br/cleanup/done

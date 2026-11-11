scoreboard players operation #tile_x br.clean = #base_x br.clean
scoreboard players operation #tile_z br.clean = #base_z br.clean
execute if score #quad br.clean matches 1 run scoreboard players add #tile_x br.clean 160
execute if score #quad br.clean matches 3 run scoreboard players add #tile_x br.clean 160
execute if score #quad br.clean matches 2..3 run scoreboard players add #tile_z br.clean 160
data modify storage oa:cleanup forced set value []
scoreboard players set #wait br.clean 0
scoreboard players set #settle br.clean 0
scoreboard players set #abort br.clean 0
function oa:br/cleanup/acquire_tile
execute if score #abort br.clean matches 1 run return run function oa:br/cleanup/abort
schedule function oa:br/cleanup/wait 1t replace

execute if score #editing oa.template matches 1 run return run tellraw @s {text:"会場の手編集中です。/oaplugin map end で編集を終了してください",color:"yellow"}
execute if score #busy oa.template matches 1 run return run tellraw @s {text:"マップの保存／復元が処理中です。完了までお待ちください。",color:"yellow"}
execute if data storage oa_map2:job {deleting:1b} run return 0
execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"先に /function oa:map/create でBR会場を生成してください",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"先に試合を停止してください",color:"red"}
execute if score #tpl_br oa.template matches 1 if score #map oa.mapid matches 0 run return run function oa:template/request_map
execute if score #tpl_nether oa.template matches 1 if score #map oa.mapid matches 1 run return run function oa:template/request_map
execute if score #tpl_cave oa.template matches 1 if score #map oa.mapid matches 2 run return run function oa:template/request_map
execute if score #tpl_sky oa.template matches 1 if score #map oa.mapid matches 3 run return run function oa:template/request_map
execute if score #tpl_end oa.template matches 1 if score #map oa.mapid matches 4 run return run function oa:template/request_map
function oa:map/pause
scoreboard players set #mode oa.map2 0
function oa:map/internal/job/begin

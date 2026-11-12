execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=br.spawn]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=br.spawn]
tellraw @s {text:"安全なランダム配置を生成できませんでした。マップの地面・登録中心を確認してください。持ち物は変更していません",color:"red"}

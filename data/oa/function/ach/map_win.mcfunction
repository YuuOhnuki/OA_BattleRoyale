# 優勝者を実行者として呼ぶ。マップごとの「優勝」実績と、全マップ制覇。
execute if score #map oa.mapid matches 0 run function oa:ach/give {id:"map_br_win",name:"草原の覇者"}
execute if score #map oa.mapid matches 1 run function oa:ach/give {id:"map_nether_win",name:"灼熱の覇者"}
execute if entity @s[advancements={oa:ach/map_br_win=true,oa:ach/map_nether_win=true}] run function oa:ach/give {id:"map_all",name:"全マップ制覇"}

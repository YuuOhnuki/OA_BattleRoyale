$data modify storage oa:spawn_plan p$(id) set from storage oa:spawn_pool selected
$execute unless data storage oa:spawn_plan p$(id).x run scoreboard players set #spawn_ok br.flag 0
$execute unless data storage oa:spawn_plan p$(id).y run scoreboard players set #spawn_ok br.flag 0
$execute unless data storage oa:spawn_plan p$(id).z run scoreboard players set #spawn_ok br.flag 0

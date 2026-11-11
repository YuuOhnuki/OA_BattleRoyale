$data modify storage oa:br_item name set value {text:"$(id)"}
$execute if data storage oa:item_names names."$(id)" run data modify storage oa:br_item name set from storage oa:item_names names."$(id)"

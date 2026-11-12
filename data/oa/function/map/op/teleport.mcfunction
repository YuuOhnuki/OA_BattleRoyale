# macro: key  選択中でなくても、そのマップの登録済み中心へ移動する
$execute if data storage oa:maps {current:"$(key)"} run return run function oa:map/teleport
$execute unless data storage oa:maps saved.$(key).center run return run tellraw @s [{text:"このマップは中心が未登録です（生成または中心登録をしてください）：",color:"red"},{text:"$(key)",color:"gray"}]
$function oa:internal/tp with storage oa:maps saved.$(key).center

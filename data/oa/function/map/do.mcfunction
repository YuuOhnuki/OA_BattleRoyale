# 使い方: /function oa:map/do {key:"br",op:"teleport"}  key=br|nether  op=teleport|create|rebuild|delete|center|gen_center|border|sp_add|sp_list|sp_remove|sp_clear|select
# 指定したマップを対象に操作する。teleport 以外は、そのマップを選択中にしてから実行する（試合中・生成中は切り替えできないため実行されない）。
$data modify storage oa:maps do set value {key:"$(key)",op:"$(op)"}
$execute unless data storage oa:maps defs.$(key) run return run tellraw @s {text:"未定義のマップです。使えるキー：br / nether",color:"red"}
$execute if data storage oa:maps {do:{op:"teleport"}} run return run function oa:map/op/teleport {key:"$(key)"}
$execute unless data storage oa:maps {current:"$(key)"} run function oa:map/select {key:"$(key)"}
$execute unless data storage oa:maps {current:"$(key)"} run return run tellraw @s [{text:"マップを切り替えられませんでした（試合中・生成中は不可）。",color:"red"}]
$function oa:map/op/$(op)

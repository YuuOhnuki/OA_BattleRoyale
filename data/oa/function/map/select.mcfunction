# 使い方: /function oa:map/select {key:"br"} または {key:"nether"}（試合停止中・管理者のみ）
execute if entity @s[type=minecraft:player] unless entity @s[tag=br.admin] run return run tellraw @s {text:"登録済み管理者のみ実行できます。",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @a[tag=br.admin] {text:"試合停止中にマップを切り替えてください。",color:"red"}
execute if data storage oa_map2:job {working:1b} run return run tellraw @a[tag=br.admin] {text:"マップの生成・削除が処理中です。",color:"yellow"}
$execute unless data storage oa:maps defs.$(key) run return run tellraw @a[tag=br.admin] {text:"未定義のマップです。使えるキー：br / nether",color:"red"}
function oa:map/internal/defs
data modify storage oa:maps ctx set value {}
data modify storage oa:maps ctx.key set from storage oa:maps current
function oa:map/internal/save_cur with storage oa:maps ctx
$data modify storage oa:maps new set from storage oa:maps defs.$(key)
function oa:map/internal/select_load

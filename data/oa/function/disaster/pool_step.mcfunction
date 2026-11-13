# マップ定義 oa:maps defs.<key>.disasters の関数で、そのマップで起こる災害を抽選する（無指定は標準）。
$data modify storage oa:disaster d set from storage oa:maps defs.$(key)
execute unless data storage oa:disaster d.disasters run data modify storage oa:disaster d.disasters set value "oa:disaster/pool/default"
function oa:disaster/pool_exec with storage oa:disaster d

# 終盤演出の共通入口。br/finale/tick から0.4秒ごとに呼ばれ、選択中のマップの定義 oa:maps defs.<key>.finale の関数を実行する。
# 新マップは map/internal/defs に finale:"oa:finale/<名前>" を足すだけでよい（無指定は oa:finale/default）。
execute unless data storage oa:br center run return 0
data modify storage oa:finale a set from storage oa:br center
data modify storage oa:finale a.key set from storage oa:maps current
function oa:finale/step with storage oa:finale a

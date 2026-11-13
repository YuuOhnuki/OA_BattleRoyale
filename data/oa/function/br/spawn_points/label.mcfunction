# 開始地点の操作メッセージに出す、選択中マップの名前を oa:spawn_points label に入れる
data modify storage oa:maps ctx.key set from storage oa:maps current
function oa:br/spawn_points/label_set with storage oa:maps ctx

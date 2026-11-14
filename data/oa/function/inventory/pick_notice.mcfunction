# 固有装備を拾ったことを全員に知らせる（inventory/slot から。説明文を付けたあとの所持品を読み直す）
$data modify storage oa:scan item set from entity @s $(path)
execute if data storage oa:scan item.components run function oa:inventory/pick_notice_say with storage oa:scan item

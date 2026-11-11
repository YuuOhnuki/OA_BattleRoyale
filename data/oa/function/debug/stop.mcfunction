execute if entity @s[tag=oa.practice] run return run function oa:practice/leave
execute unless entity @s[tag=oa.debug] run return 0
function oa:furoball/clear_up
function oa:tayayuyu/clear
function oa:test/reset
function oa:debug/items_restore
tag @s remove oa.db_free_cd
tag @s remove oa.db_multi
tag @s remove oa.db_free_match
tag @s remove oa.db_free_grace
tag @s remove oa.db_friendly
tag @s remove oa.db_infinite
tag @s remove oa.db_keepwear
tag @s remove oa.db_unbind
tag @s remove oa.db_mobs
tag @s remove oa.db_heal
tag @s remove oa.debug
execute if entity @s[tag=oa.current] run tag @s add oa.db_was_current
tag @s add oa.current
function oa:inventory/check
execute unless entity @s[tag=oa.db_was_current] run tag @s remove oa.current
tag @s remove oa.db_was_current
execute if entity @s[tag=oa.db_newplayer] run tag @s remove oa.player
tag @s remove oa.db_newplayer
clear @s *[minecraft:custom_data~{oa_debug_book:1b}]
tellraw @s {text:"デバッグ終了。通常の制限へ戻しました。複数の固有装備は通常判定で余剰分を地面へ返します。",color:"green"}

function oa:tayayuyu/fall_clear

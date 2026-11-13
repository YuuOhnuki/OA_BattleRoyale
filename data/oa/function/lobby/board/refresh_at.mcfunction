scoreboard players set #10000 oa.tmp 10000
execute as @a[tag=br.lobby_now] run function oa:lobby/board/keys
function oa:lobby/board/stats_rows
function oa:lobby/board/ach_rows
execute as @a[tag=oa.last_result] run function oa:lobby/board/last_key
function oa:lobby/board/last_rows
tag @a remove oa.b_un
tag @a remove oa.b_cand
tag @a remove oa.b_done

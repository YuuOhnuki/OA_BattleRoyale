# 1.9.186: 本人の実績をすべて消す（プラグインの /oaplugin reset achievements から、本人として。管理ブックの reset_player と同じ処理）
function oa:ach/revoke_all
function oa:ach/reset
scoreboard players reset @s oa.t_ach
scoreboard players reset @s oa.mclear

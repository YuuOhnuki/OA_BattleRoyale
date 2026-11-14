# 1.9.173: 武器博士＝10種すべての固有武器の初キルの実績（マスターは廃止）
execute unless entity @s[advancements={oa:ach/yuua_kill=true,oa:ach/fish_kill=true,oa:ach/lazi_kill=true,oa:ach/nero_kill=true,oa:ach/curse_kill=true,oa:ach/yuttari_kill=true,oa:ach/hotchikisu_kill=true,oa:ach/komame_kill=true,oa:ach/tayayuyu_kill=true,oa:ach/itori_kill=true}] run return 0
function oa:ach/give {id:"weapon_all",name:"武器博士"}

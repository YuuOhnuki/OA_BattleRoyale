# 1.9.181: プラグインが試合を記録し、通算（oa.t_games・oa.t_win）を書き込んだあと、本人を実行者として呼ぶ。
execute if score @s oa.t_games matches 10.. run function oa:ach/give {id:"games10",name:"常連さん"}
execute if score @s oa.t_games matches 50.. run function oa:ach/give {id:"games50",name:"皆勤賞"}
execute if score @s oa.t_win matches 3.. run function oa:ach/give {id:"win3",name:"連勝街道"}
execute if score @s oa.t_win matches 10.. run function oa:ach/give {id:"win10",name:"OAの王者"}

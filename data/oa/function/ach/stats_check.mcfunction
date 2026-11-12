# 試合後の通算戦績を更新したあと、参加者を実行者として呼ぶ（br/stats/add の後）。
execute if score @s oa.t_games matches 10.. run function oa:ach/give {id:"games10",name:"常連さん"}
execute if score @s oa.t_games matches 50.. run function oa:ach/give {id:"games50",name:"皆勤賞"}
execute if score @s oa.t_win matches 3.. run function oa:ach/give {id:"win3",name:"連勝街道"}
execute if score @s oa.t_win matches 10.. run function oa:ach/give {id:"win10",name:"OAの王者"}

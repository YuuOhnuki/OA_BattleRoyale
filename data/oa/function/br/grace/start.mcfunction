team add oa_brgrace
team modify oa_brgrace color dark_aqua
team modify oa_brgrace friendlyFire false
# 1.9.185: ソロでも全員を同じチーム（oa_brgrace）に入れない。保護期間中のプレイヤー同士のダメージは、
# プラグイン（0.9.0〜）が br.pvp_grace を見て止める（データパックの武器は従来どおり各処理で br.pvp_grace を見る）
execute if score #mode br.mode matches 1 run team modify oa_br1 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br2 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br3 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br4 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br5 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br6 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br7 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br8 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br9 nametagVisibility hideForOtherTeams
execute if score #mode br.mode matches 1 run team modify oa_br10 nametagVisibility hideForOtherTeams
# 1.9.186: 保護期間の案内は br/intro の中に入れた

team modify oa_brgrace nametagVisibility never

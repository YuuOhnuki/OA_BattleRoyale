# 宝珠の1ティック処理（interaction として実行）。br.gkind：1=封印中、2=解錠中
execute if score @s br.gkind matches 1 run return run function oa:disaster/relic/sealed
execute if score @s br.gkind matches 2 run function oa:disaster/relic/unlock

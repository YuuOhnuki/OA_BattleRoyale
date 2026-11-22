# 1.9.223：チェストを25個開けた・鉱石を50個掘ったら「ゆー：オーバーワーク」を1つ（それぞれ1試合1回。br/second から生存者ごと）
execute if score @s br.st_open matches 25.. unless score @s br.yuchest matches 1.. run function oa:br/yu_bonus_give {flag:"br.yuchest",what:"チェストを25個開けた"}
execute if score @s br.st_ore matches 50.. unless score @s br.yuore matches 1.. run function oa:br/yu_bonus_give {flag:"br.yuore",what:"鉱石を50個掘った"}

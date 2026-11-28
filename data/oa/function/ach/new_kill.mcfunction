scoreboard players operation @s br.st_kp = @s br.st_kill
# 1.9.191: たやゆゆのガチャで復活した人が、お面を着けたままキル → 新しいお面
execute if entity @s[tag=oa.g_revived] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:tayayuyu/revive_rearm
function oa:ach/give {id:"first_kill",name:"初陣"}
# 1.9.222：2キル目のごほうび（1試合1回、1/4 で「ゆー：オーバーワーク」）
execute if score @s br.st_kill matches 2.. unless score @s br.yukill matches 1.. if entity @s[tag=br.alive] at @s run function oa:br/kill_overwork
execute if score @s br.st_kill matches 3.. run function oa:ach/give {id:"kills3",name:"ハットトリック"}
execute if score @s br.st_kill matches 5.. run function oa:ach/give {id:"kills5",name:"殲滅者"}
execute unless items entity @s weapon.mainhand * run function oa:ach/give {id:"fist_kill",name:"拳で語る"}
execute if score @s oa.kind matches 1 run function oa:ach/give {id:"yuua_kill",name:"Hi 👋 I'm yuuaHP"}
execute if score @s oa.kind matches 2 run function oa:ach/give {id:"fish_kill",name:"おはようございます"}
execute if score @s oa.kind matches 5 run function oa:ach/give {id:"curse_kill",name:"魚と肉と白飯の頭文字取ったらsnsになるな...。"}
execute if score @s oa.kind matches 8 run function oa:ach/give {id:"komame_kill",name:"豆の一撃"}
execute if score @s oa.kind matches 3 run function oa:ach/give {id:"lazi_kill",name:"音の洗礼"}
execute if score @s oa.kind matches 4 run function oa:ach/give {id:"nero_kill",name:"雑魚はすっこんでな。"}
execute if score @s oa.kind matches 6 run function oa:ach/give {id:"yuttari_kill",name:"奇襲の洗礼"}
execute if score @s oa.kind matches 7 run function oa:ach/give {id:"hotchikisu_kill",name:"針の洗礼"}
execute if score @s oa.kind matches 9 run function oa:ach/give {id:"tayayuyu_kill",name:"変態の洗礼"}
execute if score @s oa.kind matches 10 run function oa:ach/give {id:"itori_kill",name:"いとりの一撃"}
execute if score @s oa.kind matches 8 if score @s oa.small matches 1.. run function oa:ach/give {id:"komame_big",name:"小さな巨人"}
# 1.9.223：お題8［難］素手で1キル
execute if score #mission br.tmp matches 8 unless items entity @s weapon.mainhand * if score @s br.mdone matches 0 run function oa:br/mission/clear
# 1.9.261：お題15 固有武器で1キル（いま持っている固有武器 oa.kind）・お題16 弓かクロスボウで1キル
execute if score #mission br.tmp matches 15 if score @s oa.kind matches 1.. if score @s br.mdone matches 0 run function oa:br/mission/clear
execute if score #mission br.tmp matches 16 if items entity @s weapon.mainhand #oa:mission_ranged if score @s br.mdone matches 0 run function oa:br/mission/clear
# 1.9.173: ゆうあ「私こそが企業だ」（帽子を被って1試合で3キル）、ぴちぴち「カジキマグロ」（激流を使ってから1.5秒以内のキル。激流で oa.cd=100 になり毎tick減る）
execute if score @s oa.kind matches 1 run scoreboard players add @s br.a_y1k 1
execute if score @s br.a_y1k matches 3.. run function oa:ach/give {id:"yuua_corp",name:"私こそが企業だ"}
execute if score @s oa.kind matches 2 if score @s oa.cd matches 70..100 run function oa:ach/give {id:"fish_marlin",name:"カジキマグロ"}
function oa:ach/check_meta

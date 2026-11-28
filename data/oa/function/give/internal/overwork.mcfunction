# 1.9.271：中身（名前・目印）は summon の時点で入れる。以前は素のトーテムを出してから書き換えていて、
# 読み込まれていない所や同じtickに2つ出たときに書き換えが外れ、バニラの不死のトーテムが残っていた
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.overwork_spawn"],PickupDelay:20s,Item:{id:"minecraft:totem_of_undying",count:1,components:{"minecraft:custom_name":{text:"ゆー：オーバーワーク",color:"gold",italic:false},"minecraft:custom_data":{oa_overwork:1b},"minecraft:max_stack_size":1,"minecraft:item_model":"oa:yu","minecraft:lore":[{text:"インベントリにあると致死時に自動発動（1個消費）",color:"gray",italic:false},{text:"発動後に強化、その後は毒・吐き気・鈍足",color:"gray",italic:false}]}}}
execute if entity @s[tag=br.chest] run tag @e[tag=oa.overwork_spawn] add br.newunique
execute if score #state br.state matches 1 run tag @e[tag=oa.overwork_spawn] add br.matchloot
execute if entity @s[tag=tdm.yu_equip] run item replace entity @s hotbar.3 from entity @e[type=minecraft:item,tag=oa.overwork_spawn,limit=1] contents
execute if entity @s[tag=tdm.yu_equip] run kill @e[type=minecraft:item,tag=oa.overwork_spawn]
# 1.9.256: チェスト25個・鉱石50個の報酬（br/yu_bonus_give が oa.yu_direct を付けて呼ぶ）は、足もとではなくインベントリへ直接
execute if entity @s[tag=oa.yu_direct] run function oa:inventory/take_item {tag:"oa.overwork_spawn"}
tag @e[tag=oa.overwork_spawn] remove oa.overwork_spawn

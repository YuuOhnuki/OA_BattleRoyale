# 1.9.173: 実績の毎秒の判定（br/second から、試合中の生存者として、at @s）
# ゆったりの武器を持ち続けた秒数（60秒で「haves」）
execute if score @s oa.kind matches 6 run scoreboard players add @s br.a_yhold 1
execute unless score @s oa.kind matches 6 run scoreboard players set @s br.a_yhold 0
execute if score @s br.a_yhold matches 60.. run function oa:ach/give {id:"yuttari_haves",name:"haves"}
# 1.9.180: 帽子（ゆうあ）・マスク（キリング）を被っている間に一度もキルしなければ「明日早いので寝ます」「そろそろ寝るか...。」
# 試合単位ではなく、被っている期間ごと：被り始めにキル数を覚え（br.a_k1/a_k5、印 oa.a_on1/a_on5）、外したときに増えていなければ実績。
# 倒された・試合が終わったときの期間の終わりは ach/finish_check で判定する。頭の装備を直接見る（oa.kind は手に持った武器で上書きされるため）
execute store success score #aw1 br.tmp if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}]
execute if score #aw1 br.tmp matches 1 unless entity @s[tag=oa.a_on1] run scoreboard players operation @s br.a_k1 = @s br.st_kill
execute if score #aw1 br.tmp matches 1 run tag @s add oa.a_on1
execute if score #aw1 br.tmp matches 0 if entity @s[tag=oa.a_on1] if score @s br.st_kill = @s br.a_k1 run function oa:ach/give {id:"yuua_sleep",name:"明日早いので寝ます"}
execute if score #aw1 br.tmp matches 0 run tag @s remove oa.a_on1
execute store success score #aw5 br.tmp if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}]
execute if score #aw5 br.tmp matches 1 unless entity @s[tag=oa.a_on5] run scoreboard players operation @s br.a_k5 = @s br.st_kill
execute if score #aw5 br.tmp matches 1 run tag @s add oa.a_on5
execute if score #aw5 br.tmp matches 0 if entity @s[tag=oa.a_on5] if score @s br.st_kill = @s br.a_k5 run function oa:ach/give {id:"killing_sleep",name:"そろそろ寝るか...。"}
execute if score #aw5 br.tmp matches 0 run tag @s remove oa.a_on5
# 動かずに立ち止まった秒数（位置が0.1ブロック以上変わらない。30秒で「一旦離席」）。保護期間のあとだけ数える
execute store result score #ax br.tmp run data get entity @s Pos[0] 10
execute store result score #ay br.tmp run data get entity @s Pos[1] 10
execute store result score #az br.tmp run data get entity @s Pos[2] 10
scoreboard players set #amv br.tmp 0
execute unless score #ax br.tmp = @s br.a_px run scoreboard players set #amv br.tmp 1
execute unless score #ay br.tmp = @s br.a_py run scoreboard players set #amv br.tmp 1
execute unless score #az br.tmp = @s br.a_pz run scoreboard players set #amv br.tmp 1
scoreboard players operation @s br.a_px = #ax br.tmp
scoreboard players operation @s br.a_py = #ay br.tmp
scoreboard players operation @s br.a_pz = #az br.tmp
execute if score #amv br.tmp matches 1 run scoreboard players set @s br.a_afk 0
execute if score #amv br.tmp matches 0 if score #time br.time matches 1200.. run scoreboard players add @s br.a_afk 1
execute if score @s br.a_afk matches 30.. run function oa:ach/give {id:"afk",name:"一旦離席"}

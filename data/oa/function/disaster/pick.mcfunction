# 生成：scripts/gen_disasters.py（直接編集しない）
# 重み付きで1つ選び #pN=1 にする（cfg.weight.kN。0なら出ない）。選べなければ #picked=0
scoreboard players set #picked br.tmp 0
scoreboard players set #wt br.tmp 0
scoreboard players set #w1 br.tmp 0
execute if score #av1 br.tmp matches 1 unless score #p1 br.tmp matches 1 unless score #ds1 br.tmp matches 1.. store result score #w1 br.tmp run data get storage oa:disaster cfg.weight.k1
execute if score #avoid_last br.tmp matches 1 if score #last1 br.tmp matches 1 run scoreboard players set #w1 br.tmp 0
execute if score #w1 br.tmp matches ..-1 run scoreboard players set #w1 br.tmp 0
scoreboard players operation #wt br.tmp += #w1 br.tmp
scoreboard players set #w2 br.tmp 0
execute if score #av2 br.tmp matches 1 unless score #p2 br.tmp matches 1 unless score #ds2 br.tmp matches 1.. store result score #w2 br.tmp run data get storage oa:disaster cfg.weight.k2
execute if score #avoid_last br.tmp matches 1 if score #last2 br.tmp matches 1 run scoreboard players set #w2 br.tmp 0
execute if score #w2 br.tmp matches ..-1 run scoreboard players set #w2 br.tmp 0
scoreboard players operation #wt br.tmp += #w2 br.tmp
scoreboard players set #w3 br.tmp 0
execute if score #av3 br.tmp matches 1 unless score #p3 br.tmp matches 1 unless score #ds3 br.tmp matches 1.. store result score #w3 br.tmp run data get storage oa:disaster cfg.weight.k3
execute if score #avoid_last br.tmp matches 1 if score #last3 br.tmp matches 1 run scoreboard players set #w3 br.tmp 0
execute if score #w3 br.tmp matches ..-1 run scoreboard players set #w3 br.tmp 0
scoreboard players operation #wt br.tmp += #w3 br.tmp
scoreboard players set #w4 br.tmp 0
execute if score #av4 br.tmp matches 1 unless score #p4 br.tmp matches 1 unless score #ds4 br.tmp matches 1.. store result score #w4 br.tmp run data get storage oa:disaster cfg.weight.k4
execute if score #avoid_last br.tmp matches 1 if score #last4 br.tmp matches 1 run scoreboard players set #w4 br.tmp 0
execute if score #w4 br.tmp matches ..-1 run scoreboard players set #w4 br.tmp 0
scoreboard players operation #wt br.tmp += #w4 br.tmp
scoreboard players set #w5 br.tmp 0
execute if score #av5 br.tmp matches 1 unless score #p5 br.tmp matches 1 unless score #ds5 br.tmp matches 1.. store result score #w5 br.tmp run data get storage oa:disaster cfg.weight.k5
execute if score #avoid_last br.tmp matches 1 if score #last5 br.tmp matches 1 run scoreboard players set #w5 br.tmp 0
execute if score #w5 br.tmp matches ..-1 run scoreboard players set #w5 br.tmp 0
scoreboard players operation #wt br.tmp += #w5 br.tmp
scoreboard players set #w6 br.tmp 0
execute if score #av6 br.tmp matches 1 unless score #p6 br.tmp matches 1 unless score #ds6 br.tmp matches 1.. store result score #w6 br.tmp run data get storage oa:disaster cfg.weight.k6
execute if score #avoid_last br.tmp matches 1 if score #last6 br.tmp matches 1 run scoreboard players set #w6 br.tmp 0
execute if score #w6 br.tmp matches ..-1 run scoreboard players set #w6 br.tmp 0
scoreboard players operation #wt br.tmp += #w6 br.tmp
scoreboard players set #w7 br.tmp 0
execute if score #av7 br.tmp matches 1 unless score #p7 br.tmp matches 1 unless score #ds7 br.tmp matches 1.. store result score #w7 br.tmp run data get storage oa:disaster cfg.weight.k7
execute if score #avoid_last br.tmp matches 1 if score #last7 br.tmp matches 1 run scoreboard players set #w7 br.tmp 0
execute if score #w7 br.tmp matches ..-1 run scoreboard players set #w7 br.tmp 0
scoreboard players operation #wt br.tmp += #w7 br.tmp
scoreboard players set #w8 br.tmp 0
execute if score #av8 br.tmp matches 1 unless score #p8 br.tmp matches 1 unless score #ds8 br.tmp matches 1.. store result score #w8 br.tmp run data get storage oa:disaster cfg.weight.k8
execute if score #avoid_last br.tmp matches 1 if score #last8 br.tmp matches 1 run scoreboard players set #w8 br.tmp 0
execute if score #w8 br.tmp matches ..-1 run scoreboard players set #w8 br.tmp 0
scoreboard players operation #wt br.tmp += #w8 br.tmp
scoreboard players set #w9 br.tmp 0
execute if score #av9 br.tmp matches 1 unless score #p9 br.tmp matches 1 unless score #ds9 br.tmp matches 1.. store result score #w9 br.tmp run data get storage oa:disaster cfg.weight.k9
execute if score #avoid_last br.tmp matches 1 if score #last9 br.tmp matches 1 run scoreboard players set #w9 br.tmp 0
execute if score #w9 br.tmp matches ..-1 run scoreboard players set #w9 br.tmp 0
scoreboard players operation #wt br.tmp += #w9 br.tmp
scoreboard players set #w10 br.tmp 0
execute if score #av10 br.tmp matches 1 unless score #p10 br.tmp matches 1 unless score #ds10 br.tmp matches 1.. store result score #w10 br.tmp run data get storage oa:disaster cfg.weight.k10
execute if score #avoid_last br.tmp matches 1 if score #last10 br.tmp matches 1 run scoreboard players set #w10 br.tmp 0
execute if score #w10 br.tmp matches ..-1 run scoreboard players set #w10 br.tmp 0
scoreboard players operation #wt br.tmp += #w10 br.tmp
scoreboard players set #w11 br.tmp 0
execute if score #av11 br.tmp matches 1 unless score #p11 br.tmp matches 1 unless score #ds11 br.tmp matches 1.. store result score #w11 br.tmp run data get storage oa:disaster cfg.weight.k11
execute if score #avoid_last br.tmp matches 1 if score #last11 br.tmp matches 1 run scoreboard players set #w11 br.tmp 0
execute if score #w11 br.tmp matches ..-1 run scoreboard players set #w11 br.tmp 0
scoreboard players operation #wt br.tmp += #w11 br.tmp
scoreboard players set #w12 br.tmp 0
execute if score #av12 br.tmp matches 1 unless score #p12 br.tmp matches 1 unless score #ds12 br.tmp matches 1.. store result score #w12 br.tmp run data get storage oa:disaster cfg.weight.k12
execute if score #avoid_last br.tmp matches 1 if score #last12 br.tmp matches 1 run scoreboard players set #w12 br.tmp 0
execute if score #w12 br.tmp matches ..-1 run scoreboard players set #w12 br.tmp 0
scoreboard players operation #wt br.tmp += #w12 br.tmp
execute if score #wt br.tmp matches ..0 run return 0
execute store result score #r br.tmp run random value 0..1000000
scoreboard players operation #r br.tmp %= #wt br.tmp
scoreboard players add #r br.tmp 1
scoreboard players operation #r br.tmp -= #w1 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p1 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w2 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p2 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w3 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p3 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w4 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p4 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w5 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p5 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w6 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p6 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w7 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p7 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w8 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p8 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w9 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p9 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w10 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p10 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w11 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p11 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1
scoreboard players operation #r br.tmp -= #w12 br.tmp
execute if score #r br.tmp matches ..0 run scoreboard players set #p12 br.tmp 1
execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1

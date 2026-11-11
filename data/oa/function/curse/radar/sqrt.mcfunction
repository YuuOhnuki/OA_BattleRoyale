scoreboard players operation #r_mid oa.tmp = #r_lo oa.tmp
scoreboard players operation #r_mid oa.tmp += #r_hi oa.tmp
scoreboard players set #r_two oa.tmp 2
scoreboard players operation #r_mid oa.tmp /= #r_two oa.tmp
scoreboard players operation #r_test oa.tmp = #r_mid oa.tmp
scoreboard players operation #r_test oa.tmp *= #r_mid oa.tmp
execute if score #r_test oa.tmp <= #r_sq oa.tmp run scoreboard players operation #r_lo oa.tmp = #r_mid oa.tmp
execute if score #r_test oa.tmp > #r_sq oa.tmp run scoreboard players operation #r_hi oa.tmp = #r_mid oa.tmp
scoreboard players operation #r_gap oa.tmp = #r_hi oa.tmp
scoreboard players operation #r_gap oa.tmp -= #r_lo oa.tmp
execute if score #r_gap oa.tmp matches 2.. run function oa:curse/radar/sqrt

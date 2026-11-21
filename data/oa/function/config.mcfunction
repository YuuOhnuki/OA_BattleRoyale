# Editable defaults. Cooldowns persist on players across dropping/reacquiring gear.
scoreboard players set #mark oa.mark 400
scoreboard players set #decoy oa.decoy 200

# v0.4: 0.3 blocks/tick x 160 ticks = 48 blocks. Decoy CD 30 sec.
# 1.9.186: ネロの印は 1m/tick・最大48m（0.25m を1 tick に4回）
scoreboard players set #flight oa.tmp 48

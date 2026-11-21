# 1.9.213: 試合開始の5秒のカウントダウン（br/start から）。その場で動けなくし、終わるまで試合時間（#time）を進めない（br/tick が止める）
scoreboard players set #countdown br.tmp 100
execute as @a[tag=br.playing,tag=br.alive] run function oa:br/countdown/lock
title @a[tag=br.playing] times 0 20 4

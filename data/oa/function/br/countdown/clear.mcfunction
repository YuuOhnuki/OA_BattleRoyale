# 試合の終わり・中止・ログイン時：カウントダウンの拘束を残さない
scoreboard players set #countdown br.tmp 0
execute as @a[tag=oa.countdown] run function oa:br/countdown/unlock

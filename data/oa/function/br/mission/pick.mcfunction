# 1.9.261：お題は24種類（うち［難］8種類。ごほうびに「ゆー：オーバーワーク」）。1.9.223 は12種類
execute store result score #mission br.tmp run random value 1..24
function oa:br/mission/name
execute as @a[tag=br.playing] run function oa:br/mission/reset
# 1.9.186: 表示は br/intro（試合開始の案内の中）

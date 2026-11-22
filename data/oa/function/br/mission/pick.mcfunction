# 1.9.223：お題は12種類（うち［難］5種類。ごほうびに「ゆー：オーバーワーク」）
execute store result score #mission br.tmp run random value 1..12
function oa:br/mission/name
execute as @a[tag=br.playing] run function oa:br/mission/reset
# 1.9.186: 表示は br/intro（試合開始の案内の中）

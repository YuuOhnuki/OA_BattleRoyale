# 1.9.221：お題は12種類（うち難しいもの4種類。ごほうび2倍）
execute store result score #mission br.tmp run random value 1..12
function oa:br/mission/name
execute as @a[tag=br.playing] run function oa:br/mission/reset
# 1.9.186: 表示は br/intro（試合開始の案内の中）

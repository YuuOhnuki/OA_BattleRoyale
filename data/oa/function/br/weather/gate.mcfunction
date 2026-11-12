# 選択中マップで天候システムを使うか（マップ定義の weather。無指定・0なら使わない＝ネザー・エンド・地下など）
scoreboard players set #wx br.tmp 0
$execute store result score #wx br.tmp run data get storage oa:maps defs.$(current).weather

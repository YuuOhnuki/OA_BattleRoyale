tag @s add oa.spec_init
# 1.9.147: 脱落しても自動では生存者に追従しない（自由視点のまま。/trigger oa.spec かチャットのボタンで切り替える）
tellraw @s {text:"脱落しました。生存者を観戦できます（下のボタンか /trigger oa.spec）。",color:"yellow"}
function oa:br/spec/buttons

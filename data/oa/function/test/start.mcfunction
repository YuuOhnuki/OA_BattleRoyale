# Explicit optional test setup: affects executor only; no global gamerules.
function oa:test/join
gamemode adventure @s
tellraw @s {text:"自分だけアドベンチャーへ変更しました。PvPはserver.propertiesのpvp=trueを使用してください。",color:"yellow"}

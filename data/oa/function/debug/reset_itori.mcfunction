execute unless entity @s[tag=br.admin,tag=oa.debug] run return run tellraw @s {text:"デバッグ中の管理者だけが使用できます。",color:"yellow"}
function oa:itori/progress_reset
tellraw @s {text:"いとりの解放進行度と採掘・開封カウントを0に初期化しました。解放段階・ローテーションをガイアに戻しました。",color:"aqua"}

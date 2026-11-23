# 1.9.180: 保存データがないときの復元の中断。restore_failed と同じく br.retry=1 にして、br/tick が毎tick復元を試して
# 同じメッセージを出し続けるのを止める（以前は止まらず、試合後も参加者のままになった。プラグインの自動テストで発見）。
scoreboard players set @s br.retry 1
tellraw @s {text:"保存データがありません。復元を中断しました（管理者へ連絡してください）",color:"red"}
tellraw @a[tag=br.admin] [{selector:"@s",color:"red"},{text:" の保存データがないため、復元を中断しました"}]

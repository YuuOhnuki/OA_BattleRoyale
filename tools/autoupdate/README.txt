OA Battle Royale データパック自動更新
==================================
GitHub の YuuOhnuki/OA_BattleRoyale の main が更新されたら（push の直後に GitHub Actions の self-hosted runner が起動して更新（定期チェックはなし））、
world\datapacks\OA_BattleRoyale_auto を差し替え、起動中のサーバーに /reload を送ります。

■ 導入（1回だけ）
1. （自動で /reload するために必要）server.properties を enable-rcon=true にして、サーバーを再起動。
   rcon.password は設定済みです。RCON のポート(25575)はルーターで公開しないでください。
   RCON を使わない場合は、更新ファイルの差し替えだけ行い、/reload は手動です。
2. サーバーを止めてから、PowerShell で次を実行:
     powershell -ExecutionPolicy Bypass -File D:\MinecraftServer\oa_battle_royale\autoupdate\install.ps1
   → 今の main を導入し、（定期実行は登録しません。更新は runner が行います。）
   → 古い OA_BattleRoyale*.zip/フォルダーは autoupdate\retired に移動します。
3. サーバーを起動（新しいデータパックは起動時に自動で有効化されます）。
   ※ サーバーを動かしたまま導入しても、RCON が有効なら古いパックを無効化して切り替えます。

■ 手動で反映する（2026-11-16〜、applyMode "manual"）
- config.json に "applyMode": "manual" を書くと、push のたびに
  データパックは world\datapacks\OA_BattleRoyale_auto に置くだけ、プラグインの jar は autoupdate\pending\ に置くだけになります。
- 反映は、ゲーム内の /oaplugin update apply、または管理メニュー（/oamenu →「その他」→「更新を反映する（再起動）」）。
  プラグインが autoupdate\apply.ps1 を起動し、30秒予告してサーバーを再起動します（jar の入れ替え・起動の確認・失敗なら戻す）。
  試合中・会場の生成中・練習場に人がいるときは反映できません。
- 状態は /oaplugin update（反映待ちのデータパック・プラグイン）。
- 入れ替えるファイル：autoupdate\update.ps1、autoupdate\apply.ps1（新規）、autoupdate\plugin-update.ps1（プラグインのリポジトリ）、
  config.json に "applyMode": "manual" を1行追加。
- サーバーが別の理由で再起動したときも、置いてあった版はそのとき読み込まれます。

■ 反映のしかた（2026-11-15〜：再起動方式）
- config.json の applyMode が "restart"（書いていなければこちら）なら、データパックを置いたあと
  「30秒後にサーバーを再起動します」と予告して再起動し、起動時に読み込ませます（/reload は使いません）。
  大きなデータパックの /reload は60秒以上サーバーを止め、Paper の watchdog に止められたことがあるためです。
- 再起動は start-server.bat（ループ起動）で動いているときだけ。そうでなければファイルを置くだけで、次の起動で反映されます。
- 試合中・マップ生成中・練習場に人がいる間は待ち、空いたら再起動します（予告中に始まったら延期）。
- 再起動のあとに読み込みエラーがあれば（7分以内に起動しなければ）、前の版に戻してもう一度再起動します。
- 従来の /reload に戻すときは config.json に "applyMode": "reload" を書きます。
- 入れ替え：この update.ps1 を D:\MinecraftServer\oa_battle_royale\autoupdate\update.ps1 に上書きするだけ（config.json はそのままでよい）。

■ 動作
- 試合中・マップ生成中は適用を保留し、1分ごとに確認して、終わってから適用します（最大約3時間。RCON 有効時）。
- 読み込みエラー（Failed to load function など）が出たら、前の版へ自動で戻します。同じ版は再試行しません。
- ディメンション関連ファイルが変わった更新は、/reload では完全に反映されません。サーバーの再起動が必要です
  （ゲーム内メッセージとログで知らせます）。
- 差し替え前の版は autoupdate\backup に3世代保存します。

■ 確認・停止
- ログ: autoupdate\update.log
- 今すぐ更新: powershell -ExecutionPolicy Bypass -File autoupdate\update.ps1 -Force
- 停止: runner を止める（docs/server-autoupdate.md）。旧版の定期チェックを消すには uninstall.ps1
- 設定: autoupdate\config.json（branch を別ブランチにすれば、確認済みの版だけを配信できます）

■ 注意
- main に push した内容は、そのまま稼働中のサーバーに入ります。未確認の変更を入れたくない場合は、
  config.json の branch を release 用のブランチにして、確認後に main から反映してください。

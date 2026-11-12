# サーバー自動更新（main への push で更新）

`main` に push → GitHub Actions（`.github/workflows/deploy-server.yml`）→ サーバーPCの self-hosted runner → `autoupdate\update.ps1` → データパック差し替え＋RCON で `/reload`。
外部からの接続は受けない（runner が GitHub へ取りに行く）。10分ごとのタスクは、試合中に保留した更新の再試行用。

## runner の登録
1. GitHub の `YuuOhnuki/OA_BattleRoyale` → Settings → Actions → Runners → New self-hosted runner → Windows / x64。
2. 画面に出るコマンドで runner を `D:\actions-runner` などに展開。
3. 画面のトークン（有効1時間）で登録：
   `.\config.cmd --url https://github.com/YuuOhnuki/OA_BattleRoyale --token <TOKEN> --labels oa-server --unattended`
4. `.\run.cmd` で起動（常駐させるなら `.\svc.cmd`系ではなく、自分のアカウントで動くサービスにする）。

## 安全上の注意
- このワークフローは `push`（main）と手動実行のみ。`pull_request` を足さないこと（外部の変更がサーバーPCで動くため）。
- runner を動かすアカウントは、サーバーフォルダへの書き込みと 127.0.0.1 の RCON に届く必要がある。

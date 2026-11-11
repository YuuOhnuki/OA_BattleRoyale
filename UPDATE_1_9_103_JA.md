# v1.9.103 更新内容（修正）
対応：データパック 1.9.103 ＋ リソースパック 1.9.34（変更なし）

## 修正
- `Unknown block type 'minecraft:chain'` で `oa:lobby/decor` と `oa:map/internal/tiles/place/82`（帆船）が読み込めない問題を修正。26.3では鎖のブロックIDが `minecraft:iron_chain` のため置換した。
- 他の新規ブロックIDは標準名のため変更なし。

## 導入手順
`/reload` のあと、1.9.102 の手順（`/function oa:map/rebuild`、ロビー更新 `oa.admin 14`）を実施。

## 検証
- 静的確認のみ（ID置換、関数参照）。実機の再読み込みは未確認（ログで確認をお願いします）。

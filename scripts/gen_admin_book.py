#!/usr/bin/env python3
"""管理ブック（oa:admin/book）を生成する。使い方: python3 -I scripts/gen_admin_book.py <repo root>
ページ構成を変えたら、このスクリプトを直して再生成する（コマンドの対応は admin/dispatch.mcfunction）。"""
import sys,json
ROOT=sys.argv[1]
def t(text,color=None,**kw):
    d={"text":text}
    if color: d["color"]=color
    d.update(kw); return d
def link(label,code,color="dark_blue"):
    return t("▸ "+label+"\n",color,underlined=True,click_event={"action":"run_command","command":f"/trigger oa.admin set {code}"})
def page_link(label,page): return t("▸ "+label+"\n","dark_blue",underlined=True,click_event={"action":"change_page","page":page})
def back(page=1,label="‹ 目次",extra=None):
    r=[t("\n","black"),t(label,"dark_blue",underlined=True,click_event={"action":"change_page","page":page})]
    if extra: r.append(t("  "+extra[0],"dark_blue",underlined=True,click_event={"action":"change_page","page":extra[1]}))
    return r
def head(s): return t(s+"\n","dark_purple",bold=True)
def note(s,c="gray"): return t(s+"\n",c)
pages=[]
def add(*parts): pages.append({"raw":{"text":"","extra":list(parts)}})
MAPOPS=[("選択して使う",71),("中心へ移動",60),("会場を生成",61),("会場を再生成",62),("会場を削除",63)]
# ページ番号: 1,2 目次 / 3 メニュー / 4 準備 / 5-6 地上 / 7-8 ネザー / 9 選択中 / 10 参加者 / 11-12 固有装備 / 13 消耗品 / 14 生成管理 / 15 デバッグ / 16 削除 / 17 手動更新
add(head("管理メニュー"),note("項目をクリックして移動\n"),page_link("OA 管理メニュー",3),page_link("準備・ロビー",4),page_link("地上マップ",5),page_link("ネザーマップ",7),page_link("選択中のマップ（旧）",9),page_link("参加者・復活",10),t("\n","black"),t("次の目次 ›","dark_blue",underlined=True,click_event={"action":"change_page","page":2}))
add(head("管理メニュー"),note("項目をクリックして移動\n"),page_link("固有装備を入手",11),page_link("消耗品・通常武器",13),page_link("生成・削除の管理",14),page_link("デバッグの使い方",15),page_link("削除・初期設定",16),page_link("手動更新・版数・観戦",17),t("\n","black"),t("‹ 前の目次","dark_blue",underlined=True,click_event={"action":"change_page","page":1}))
add(t("OA 管理メニュー\n","dark_purple",bold=True),note("青文字をクリックして操作"),link("① 準備状態を確認",2),link("② ソロで試合開始",5),link("② チームで試合開始",6),link("試合を中止して復元",7),link("デバッグ開始／専用ブック",40),note("試合に使うマップは、地上／ネザーのページで選ぶ"),*back())
add(head("準備・ロビー"),link("基本設定を補完",33),link("現在地にロビーを作成",4),link("ロビーへ移動",32),link("ロビー展示だけ更新",46),link("ロビーを再建",14),link("練習場を生成",58),note("生成は周囲を書き換えます。","red"),*back())
def map_pages(name,base,pg):
    ops=[(l,base+i) for i,l in enumerate(["中心へ移動","会場を生成","会場を再生成","会場を削除","現在地を中心に登録","生成した中心を使う","ボーダーを自動設定","開始地点を追加","開始地点を確認","2m以内の地点を削除","全地点を削除","このマップを試合に使う"])]
    add(head(f"{name}マップ 1/2"),note(f"対象：{name}（選択中でなくてもよい）"),link(ops[11][0],ops[11][1]),link(ops[0][0],ops[0][1]),link(ops[1][0],ops[1][1],"red"),link(ops[2][0],ops[2][1],"red"),link(ops[3][0],ops[3][1],"red"),note("試合中・生成中は切替不可。\n中心移動のみ試合中も可。","gray"),*back(1,"‹ 目次",("続き ›",pg+1)))
    add(head(f"{name}マップ 2/2"),note(f"対象：{name}。{name}の中に立って実行"),link(ops[4][0],ops[4][1]),link(ops[5][0],ops[5][1]),link(ops[6][0],ops[6][1]),link(ops[7][0],ops[7][1]),link(ops[8][0],ops[8][1]),link(ops[9][0],ops[9][1],"red"),link(ops[10][0],ops[10][1],"red"),*back(1,"‹ 目次",("‹ 1/2",pg)))
map_pages("地上",60,5); map_pages("ネザー",80,7)
add(head("選択中のマップ（旧）"),note("以前からのコマンド。\n現在選択中のマップが対象。\n開始地点の登録は地上／ネザーの各ページへ。"),link("現在地をBR中心に登録",29),link("生成したマップ中心を使う",30),link("登録した中心へ移動",31),link("BR専用会場を生成",3),link("マップを全面再生成",13),link("ボーダーを自動設定",49),*back())
add(head("参加者・復活"),link("プレイヤーを選んで管理",35),note("参加・観戦・復活・GM変更"),link("自分のゲームモード",38),link("自分を復活",39),*back())
add(head("固有装備を入手 1/2"),note("クリックで1個入手"),*[link(n,c) for n,c in (("ゆうあ",20),("ぴちぴち",21),("lazi",22),("ネロ",23),("キリング",24),("ゆったり",25),("ほちきす",26),("こまめ",27))],*back(1,"‹ 目次",("続き ›",12)))
add(head("固有装備を入手 2/2"),link("たやゆゆ",36),link("いとり",53),*back())
add(head("消耗品・通常武器"),*[link(n,c) for n,c in (("ゆー｜オーバーワーク",28),("ふろボール",37),("木のバット",9),("ノックバック棒",10),("包帯",42),("応急キット",43),("バフ医療品4種",17),("雪玉 ×16",44),("卵 ×16",45))],*back())
add(head("生成・削除の管理"),note("対象：選択中のマップ"),link("生成を停止",11),link("生成を再開",12),link("マップを全面再生成",13,"red"),link("飛び道具の状態確認",34),note("再生成・削除は取り消せません。","red"),*back(2))
add(head("デバッグの使い方"),note("待機中に本人の制限を変更。\n通常の試合開始で自動解除。\n","black"),link("デバッグを開始",40),link("デバッグブックを再発行",41),note("専用ブックでCT・所持数・標的・消費などを切替。"),*back(2))
add(head("削除・初期設定"),link("登録済みロビーを削除",47,"red"),link("選択中のマップを削除",48,"red"),link("ボーダーを中心から自動設定",49),note("マップ別の削除は地上／ネザーのページ。"),*back(2))
add(head("手動更新・版数・観戦"),link("展示プレイヤースキンを更新",51),t("▸ 版数を表示\n","dark_blue",underlined=True,click_event={"action":"run_command","command":"/function oa:version"}),note("全員は /trigger oa.ver","gray"),note("観戦（参加者以外）：\n/trigger oa.spec 1次 2前 3自由\n","black"),note("実績リセット：\n/function oa:admin/ach/reset_player {player:\"名前\"}","gray"),*back(2))
book={"title":{"raw":"OA 管理ブック"},"author":"OA BattleRoyale","generation":0,"resolved":True,"pages":pages}
body=json.dumps(book,ensure_ascii=False,separators=(",",":"))
lines=[open(f"{ROOT}/data/oa/function/admin/book.mcfunction",encoding="utf8").read().split("\n")[i] for i in (0,1)]
out=lines[0]+"\n"+lines[1]+"\n"+'give @s minecraft:written_book[minecraft:written_book_content='+body+',minecraft:custom_name={"text":"OA 管理ブック","color":"gold","italic":false},minecraft:custom_data={"oa_admin_book":true,"book_v1111":true},minecraft:max_stack_size=1] 1\n'+'tellraw @s {text:"管理ブック：右クリックで開く → 青文字をクリック。",color:"gold"}\n'
open(f"{ROOT}/data/oa/function/admin/book.mcfunction","w",encoding="utf8").write(out)
print(len(pages),"pages")

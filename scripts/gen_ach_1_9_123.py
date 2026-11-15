"""1.9.123: 実績をカテゴリごとの枝分かれのツリーにする。1.9.125でタブは1つ（OA）に統合し、カテゴリは枝の頭（cat_*）にした。
既存IDは変えず（進行度を保つ）、parent と表示だけ更新する。新規は表のとおり追加する。
list / count_ach / revoke_all も同じ表から作り直す。使い方: python3 -I scripts/gen_ach_1_9_123.py <repo>
"""
import json, os, sys
R = sys.argv[1]
ADV = f"{R}/data/oa/advancement/ach"
FN = f"{R}/data/oa/function"

# タブ（ルート）は1つだけにする（バニラのタブと順番が混ざらないように、OAを1か所に並べる）。
TABS = [("root", "OAバトルロワイヤル", "OAバトルロワイヤルの実績", "diamond_sword", "stone")]
# カテゴリ：ルートの子で、自動で解除される枝の頭。(id, 表示名, 説明, アイコン)
CATS = [("cat_br", "バトルロワイヤル", "試合全体の実績（キル・チェスト・お題・勝利）", "diamond_sword"),
        ("cat_map", "マップ", "マップごとの実績", "filled_map"),
        ("cat_weapon", "固有武器", "固有武器ごとの実績", "netherite_sword")]

# (id, parent, title, desc, icon, frame, hidden)  既存は None を入れると既存の表示を引き継ぐ。
E = []
def a(id, parent, title=None, desc=None, icon=None, frame=None, hidden=None):
    E.append((id, parent, title, desc, icon, frame, hidden))

# --- バトルロワイヤル全体 ---
a("first_kill", "cat_br")
a("kills3", "first_kill")
a("kills5", "kills3", "殲滅者", "1試合で5キルした", "netherite_sword", "goal", False)
a("chests10", "cat_br")
a("chests20", "chests10", "大富豪", "1試合でチェストを20個開けた", "gold_ingot", "goal", False)
a("mission1", "cat_br")
a("mission5", "mission1")
a("games10", "cat_br", "常連さん", "通算10試合に参加した", "oak_door", "task", False)
a("winner", "cat_br")
a("win3", "winner", "連勝街道", "通算3勝した", "gold_block", "goal", False)
a("win10", "win3", "OAの王者", "通算10勝した", "dragon_head", "challenge", False)

# --- マップ ---
a("map_br_play", "cat_map", "草原の戦場へ", "地上マップで試合に参加した", "grass_block", "task", False)
a("map_br_win", "map_br_play", "草原の覇者", "地上マップで優勝した", "golden_helmet", "goal", False)
a("map_nether_play", "cat_map", "炎獄の戦場へ", "ネザーマップで試合に参加した", "netherrack", "task", False)
a("map_nether_win", "map_nether_play", "灼熱の覇者", "ネザーマップで優勝した", "magma_block", "goal", False)
a("map_cave_play", "cat_map", "地底の戦場へ", "洞窟マップで試合に参加した", "amethyst_shard", "task", False)
a("map_cave_win", "map_cave_play", "地底の覇者", "洞窟マップで優勝した", "sculk_catalyst", "goal", False)
a("map_all", "map_nether_win", "全マップ制覇", "すべてのマップで優勝した", "nether_star", "challenge", False)
# map_all の親は1つしか持てないので、地上側の枝とはゲーム内の条件で結ぶ。

# --- 固有武器（武器ごとの枝。1.9.173 で「装備したまま3キル連続（マスター）」を廃止し、名前と実績を入れ替えた） ---
a("yuua_kill", "cat_weapon", "Hi 👋 I'm yuuaHP", "ゆうあ：初めてキルした", "golden_helmet", "task", False)
a("yuua_counter", "yuua_kill", "今何かしたか？", "ゆうあ：社会的制裁（帽子の反撃）で敵を倒した", "golden_helmet", "goal", False)
a("yuua_corp", "yuua_kill", "私こそが企業だ", "ゆうあ：帽子を被って1試合で3キルした", "gold_ingot", "goal", False)
a("yuua_sleep", "yuua_kill", "明日早いので寝ます", "ゆうあ：帽子を30秒以上被ったのに、被っている間に一度もキルできなかった", "red_bed", "task", True)
a("fish_kill", "cat_weapon", "おはようございます", "ぴちぴち：初めてキルした", "cod", "task", False)
a("fish_marlin", "fish_kill", "カジキマグロ", "ぴちぴち：激流の勢いで敵をキルした", "trident", "goal", False)
a("pichi_20s", "fish_kill", "僕は4次元です()", "ぴちぴち：敵を20秒間連続で跳ねさせた", "cod", "goal", True)
a("lazi_kill", "cat_weapon", "音の洗礼", "lazi：初めてキルした", "jukebox", "task", False)
a("lazi_tired", "lazi_kill", "すり抜け", "lazi：息切れした", "note_block", "task", False)
a("lazi_midnight", "lazi_kill", "午前0時", "lazi：息切れしているときに倒された", "clock", "task", True)
a("nero_kill", "cat_weapon", "雑魚はすっこんでな。", "ネロノワール：初めてキルした", "bone", "task", False)
a("nero_decoy", "nero_kill", "ビビらせてやる！", "ネロノワール：身代わりの術で初めて攻撃を受け流した", "ender_pearl", "goal", False)
a("nero_decoy10", "nero_decoy", "弱さを見せるな、絶対にだ！", "ネロノワール：1試合で10回、身代わりの術で攻撃を受け流した", "shield", "challenge", True)
a("curse_kill", "cat_weapon", "魚と肉と白飯の頭文字取ったらsnsになるな...。", "キリング：初めてキルした", "wither_skeleton_skull", "task", False)
a("killing_guard", "curse_kill", "やっべ思い出忘れてきた！", "キリング：攻撃を無効化した", "carved_pumpkin", "goal", False)
a("killing_streak", "killing_guard", "走り撃ち", "キリング：3回続けてダメージを無効化した", "arrow", "challenge", True)
a("killing_sleep", "curse_kill", "そろそろ寝るか...。", "キリング：マスクを30秒以上被ったのに、被っている間に一度もキルできなかった", "white_bed", "task", True)
a("yuttari_kill", "cat_weapon", "奇襲の洗礼", "ゆったり：初めてキルした", "feather", "task", False)
a("yuttari_back", "yuttari_kill", "親フラ", "ゆったり：敵の背後へ瞬間移動した", "clock", "goal", False)
a("yuttari_haves", "yuttari_kill", "haves", "ゆったり：ゆったりの武器を1分間持ち続けた", "feather", "task", True)
a("hotchikisu_kill", "cat_weapon", "針の洗礼", "ほちきす：初めてキルした", "shears", "task", False)
a("hotchikisu_first", "hotchikisu_kill", "しんちょうのびた？", "ほちきす：初めて敵を拘束した", "iron_chain", "task", True)
a("hotchikisu_root", "hotchikisu_kill", "人が病んでるところみると興奮する", "ほちきす：拘束している敵をキルした", "iron_bars", "goal", False)
a("hk_lazi", "hotchikisu_kill", "らじちゃんかわいいねえ", "ほちきす：ほちきすの武器で lazi_3253 をキルした", "player_head", "goal", True)
a("hk_itori", "hotchikisu_kill", "いとりちゅあん", "ほちきす：ほちきすの武器で itori0814 をキルした", "player_head", "goal", True)
a("hk_pichi", "hotchikisu_kill", "おやすみぴちこたん", "ほちきす：ほちきすの武器で pichipichi_256 をキルした", "player_head", "goal", True)
a("hk_nero", "hotchikisu_kill", "れろのあーるはん", "ほちきす：ほちきすの武器で NeroNoir9696 をキルした", "player_head", "goal", True)
a("hk_kiri", "hotchikisu_kill", "きりんぐしね", "ほちきす：ほちきすの武器で KiRiSaN_1110 をキルした", "player_head", "goal", True)
a("komame_kill", "cat_weapon", "豆の一撃", "こまめ：初めてキルした", "slime_ball", "task", False)
a("komame_big", "komame_kill", "小さな巨人", "こまめ：小さくなっている間に敵を倒した", "cookie", "goal", False)
a("tayayuyu_kill", "cat_weapon", "変態の洗礼", "たやゆゆ：初めてキルした", "amethyst_shard", "task", False)
a("tayayuyu_gacha3", "tayayuyu_kill", "引きの強さ", "たやゆゆ：1試合でガチャを3回回した", "nether_star", "goal", False)
a("tayayuyu_master", "tayayuyu_gacha3", "たやゆゆの申し子", "たやゆゆ：1試合でガチャを5回回した", "amethyst_shard", "challenge", False)
a("tayayuyu_unlucky", "tayayuyu_kill", "たやゆゆに愛される", "たやゆゆ：1試合でハズレの効果を3回引いた", "poisonous_potato", "goal", False)
a("tayayuyu_dqn", "tayayuyu_kill", "DQNに屈した", "たやゆゆ：自分のガチャで帽子の効果を引き、その帽子を被った人に倒された", "golden_helmet", "goal", False)
a("itori_kill", "cat_weapon", "いとりの一撃", "いとり：初めてキルした", "blaze_rod", "task", False)
a("furoball_blast", "cat_weapon")
a("weapon_all", "cat_weapon", "武器博士", "10種すべての固有武器で初めてキルした", "beacon", "challenge", True)

# --- 隠し実績（関連する枝に入れる。解除するまで名前と条件が見えない） ---
a("peace_win", "winner")
a("close_call", "winner")
a("poor_win", "winner", "清貧の勝者", "チェストを1つも開けずに優勝した", "barrel", "goal", True)
a("no_jump_win", "winner", "地を這う者", "1度もジャンプせずに優勝した", "iron_boots", "challenge", True)
a("walker", "cat_br")
a("jumper", "cat_br")
a("first_out", "cat_br")
a("fist_kill", "first_kill", "拳で語る", "素手でキルした", "leather", "goal", True)
a("greedy30", "chests20", "強欲な探検家", "1試合でチェストを30個開けた", "ender_chest", "goal", True)
a("games50", "games10", "皆勤賞", "通算50試合に参加した", "clock", "goal", True)
a("afk", "cat_br", "一旦離席", "試合中、30秒間動かずに立ち止まった", "armor_stand", "task", True)
a("armor_break", "cat_br", "腹は使い捨てですわ～", "固有装備以外の防具を、耐久値0まで使って壊した", "iron_chestplate", "task", True)

def cat_of(id):
    p = {e[0]: e[1] for e in E}
    while p.get(id) and not p[id].startswith("cat_"):
        id = p[id]
    return p.get(id)

def write(id, d):
    with open(f"{ADV}/{id}.json", "w", encoding="utf-8") as f:
        json.dump(d, f, ensure_ascii=False, indent=2)

for tid, title, desc, icon, bg in TABS:
    write(tid, {"display": {"icon": {"id": "minecraft:" + icon}, "title": {"text": title},
        "description": {"text": desc}, "background": f"minecraft:gui/advancements/backgrounds/{bg}",
        "frame": "task", "show_toast": False, "announce_to_chat": False, "hidden": False},
        "criteria": {"auto": {"trigger": "minecraft:tick"}}})
for cid, title, desc, icon in CATS:
    write(cid, {"parent": "oa:ach/root", "display": {"icon": {"id": "minecraft:" + icon}, "title": {"text": title},
        "description": {"text": desc}, "frame": "goal", "show_toast": False, "announce_to_chat": False, "hidden": False},
        "criteria": {"auto": {"trigger": "minecraft:tick"}}})

info = {}  # id -> (title, desc, hidden)
for id, parent, title, desc, icon, frame, hidden in E:
    path = f"{ADV}/{id}.json"
    if title is None:
        d = json.load(open(path, encoding="utf-8"))
        d["parent"] = "oa:ach/" + parent
    else:
        d = {"parent": "oa:ach/" + parent, "display": {"icon": {"id": "minecraft:" + icon},
            "title": {"text": title}, "description": {"text": desc}, "frame": frame,
            "show_toast": True, "announce_to_chat": False, "hidden": hidden},
            "criteria": {"done": {"trigger": "minecraft:impossible"}}}
    write(id, d)
    x = d["display"]
    info[id] = (x["title"]["text"], x["description"]["text"], x["hidden"])

# 木の整合性：定義した以外のach JSONがないか
files = {f[:-5] for f in os.listdir(ADV)}
known = {t[0] for t in TABS} | {c[0] for c in CATS} | set(info)
assert files == known, (files - known, known - files)

# list（/trigger oa.achv）
lines = ['tellraw @s {text:"━━ 実績一覧（解除済み ✔）━━",color:"yellow",bold:true}']
for cid, ttl, _, _ in CATS:
    lines.append(f'tellraw @s {{text:"▼ {ttl}",color:"aqua",bold:true}}')
    for id, parent, *_ in E:
        if cat_of(id) != cid:
            continue
        t, dsc, h = info[id]
        c = f"@s[advancements={{oa:ach/{id}=true}}]"
        lines.append(f'execute if entity {c} run tellraw @s [{{text:"✔ ",color:"green"}},{{text:"{t}",color:"gold"}},{{text:" ／ {dsc}",color:"gray"}}]')
        if h:
            lines.append(f'execute unless entity {c} run tellraw @s [{{text:"・ ",color:"dark_gray"}},{{text:"？？？",color:"dark_gray"}},{{text:" ／ 隠し実績",color:"dark_gray"}}]')
        else:
            lines.append(f'execute unless entity {c} run tellraw @s [{{text:"・ ",color:"dark_gray"}},{{text:"{t}",color:"white"}},{{text:" ／ {dsc}",color:"dark_gray"}}]')
open(f"{FN}/ach/list.mcfunction", "w", encoding="utf-8").write("\n".join(lines) + "\n")

ids = [e[0] for e in E]
open(f"{FN}/br/stats/count_ach.mcfunction", "w", encoding="utf-8").write(
    "scoreboard players set @s oa.t_ach 0\n" + "\n".join(
        f"execute if entity @s[advancements={{oa:ach/{i}=true}}] run scoreboard players add @s oa.t_ach 1" for i in ids) + "\n")
open(f"{FN}/ach/revoke_all.mcfunction", "w", encoding="utf-8").write(
    "\n".join(f"advancement revoke @s only oa:ach/{i}" for i in ids) + "\n")
# 1.9.157: 実績の名前と説明をストレージに置く（チャットの解除メッセージでカーソルを合わせると説明が出る。ach/give → ach/announce）
# 1.9.158: 先頭の「data modify storage oa:ach_info set value {}」はパスがなく読み込みエラーだったので削除（各IDを個別に上書きする）
info_lines = ["# 生成: scripts/gen_ach_1_9_123.py（直接編集しない）。load から呼ぶ"]
for i in ids:
    t, dsc, h = info[i]
    assert not any(ch in t + dsc for ch in '"\\$'), i   # マクロで文字列に埋め込むため
    info_lines.append(f'data modify storage oa:ach_info {i} set value {{name:"{t}",desc:"{dsc}"}}')
open(f"{FN}/ach/info.mcfunction", "w", encoding="utf-8").write("\n".join(info_lines) + "\n")
print(len(ids), "achievements,", len(CATS), "categories")

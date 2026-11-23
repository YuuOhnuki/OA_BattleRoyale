"""Build a complete, reviewable file appendix and resource/unit validation record."""
from pathlib import Path
import subprocess,json,hashlib,xml.etree.ElementTree as ET
from PIL import Image

ROOT=Path(__file__).resolve().parents[1];WS=ROOT.parent
out=ROOT/'docs/upgrade-1.9.239-files.md'
repositories={'datapack':ROOT,'plugin':WS/'oa_battleroyale_plugin','resourcepack':WS/'oa_battleroyale_resourcepack'}
special={
 'MatchSafety':'奈落死亡と自分のふろボールの独立した落下保護',
 'SkySelection':'本人限定の確認・バックアップ完了後の生成',
 'MatchMapService':'完成キャッシュ・プレビュー・非同期チャンク準備',
 'SupplyChunks':'補給範囲の準備と物資チャンクの維持',
 'ChunkLeases':'同じプラグイン内のチャンクチケット参照数管理',
 'DisasterService':'ブタの隊列、ニワトリ追従・卵の1HPと演出',
 'TowerBarrage':'段階的待機短縮・警告と着弾の演出',
 'ParadeGeometry':'剛体隊列の回転と間隔',
 'MeleeProcs':'通常命中の20%抽選、既存押し出しは維持',
 'KillLog':'奈落死亡の原因表示、既存攻撃者のキル表示は維持',
 'SkyFallRescue':'既存周期からMatchSafetyを呼び出す',
 'TemplateFiles':'sky/endと対応ワールドの保存範囲',
 'TemplateState':'現在の完成状態・地点名・柱・登録座標を世代保存',
 'TemplateService':'5会場・現在地判定・編集ロックと保存操作',
 'TemplateRestore':'保存形式互換・描画世代の更新',
 'PlayerMenu':'5会場の生成状態と天空島確認の入口',
 'FakePlayers':'検査サーバー専用の被弾/音パケット記録',
 'TestCommand':'検査サーバー専用の安全・地面・体力・無効被弾検査',
}
def reason(repo,path):
 p=Path(path)
 if repo=='plugin':
  if '/test/' in path or path.startswith('tools/'):return '自動検査・5会場回帰・今回の不具合再現と原記録'
  if p.stem in special:return special[p.stem]
  if '/zone/' in path:return '実際に体力が減った時だけバニラ被弾音'
 if repo=='resourcepack' and path.endswith('.png'):return 'ガラスを除いた天空島/エンドの固定見本を再描画'
 if path.startswith('data/oa/function/maps/') or path.endswith('.nbt') or path.endswith('.npz'):return '生成スクリプトの出力：島・鉱石・通行経路・登録点・エンド表示'
 if path.startswith('MAP_'):return '実際に生成した数・到達性・修正地点の検査記録'
 if '/br/ui/' in path:return '既存お題の表示、開始/終了の整合、239の版数'
 if '/spawn_points/' in path:return '既存候補からの最大最小距離による配置'
 if '/mining/' in path or '/medical/' in path:return '対象鉱石だけ100%回復、他鉱石の既存報酬を維持'
 if '/loot_table/' in path or '/item_modifier/' in path or '/normal/' in path:return 'パール/バット/確率説明、他の抽選枠と内部IDは維持'
 if path.startswith('scripts/'):return '生成・確率・説明の正本と再生成時の整合'
 if path.startswith('tools/'):return '確率・複数シード・配布内容の再現可能な検査'
 if '/lobby/' in path or '/map/' in path:return '5会場の状態・名称・安全ロック・完成後の表示'
 if path.endswith('.md') or path.endswith('VALIDATION.json') or p.name in ('pack.mcmeta','gradle.properties','SKIN_SOURCES.json'):return '版・仕様・検証と未確認範囲・配布説明'
 if '/br/supply/' in path:return 'ゆー15%とチャンク準備を既存抽選へ接続'
 if '/br/yu_bonus' in path:return '獲得通知の送信先を本人だけへ'
 if 'tayayuyu/hit' in path:return '通常効果を1/5へ（専用スキルは維持）'
 if '/br/start' in path or '/br/stop' in path:return '完成状態・編集ロック・地図準備・お題表示の開始終了'
 if '/disaster/' in path:return 'ブタ爆発のプラグイン担当と旧版フォールバック'
 return '今回の5会場対応・表示/互換性・検査の整合（差分で確認）'

lines=['# 1.9.239 / 0.50.0 / RP1.9.48 変更ファイル付録','',
       '追跡済み差分と未追跡の追加ファイルを列挙。生成したタイル/NBTも省略しない。テスト用run・workとdistの原記録は配布ソースとは別。','']
counts={};fingerprints={}
for label,repo in repositories.items():
 def git(*args):return subprocess.check_output(['git',*args],cwd=repo,stderr=subprocess.DEVNULL).decode('utf-8')
 paths=set(git('diff','HEAD','--name-only','-z').split('\0'))|set(git('ls-files','--others','--exclude-standard','-z').split('\0'));paths.discard('')
 if label=='datapack':paths.add(out.relative_to(repo).as_posix())
 counts[label]=len(paths);lines += [f'## {label}（{len(paths)}ファイル）','','|ファイル|変更理由|','|---|---|']
 for path in sorted(paths):
  lines.append(f'|`{path}`|{reason(label,path)}|')
  f=repo/path
  if f.exists() and f!=out:fingerprints[label+'/'+path]=hashlib.sha256(f.read_bytes()).hexdigest()
 lines.append('')
out.write_text('\n'.join(lines),encoding='utf-8')
rp=repositories['resourcepack'];json_count=0
for f in rp.rglob('*.json'):
 if '.git' in f.parts:continue
 json.loads(f.read_text(encoding='utf-8-sig'));json_count+=1
images={}
for key in ('sky','end'):
 f=rp/f'assets/oa/textures/item/br_lobby_map_{key}.png'
 with Image.open(f) as im:im.verify()
 with Image.open(f) as im:
  assert im.size==(512,512)
  images[key]={'size':im.size,'mode':im.mode,'sha256':hashlib.sha256(f.read_bytes()).hexdigest()}
unit={'tests':0,'failures':0,'errors':0,'skipped':0}
for f in (repositories['plugin']/'build/test-results/test').glob('TEST-*.xml'):
 root=ET.parse(f).getroot()
 for key in unit:unit[key]+=int(root.attrib.get(key,0))
evidence={'changedFiles':counts,'resourceJsonFilesParsed':json_count,'images':images,'junit':unit,'sourceHashes':fingerprints}
(WS/'dist/upgrade239-source-evidence.json').write_text(json.dumps(evidence,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in evidence.items() if k!='sourceHashes'},ensure_ascii=False))

from pathlib import Path
import re,json,shutil
p=Path('revision/pack');f=p/'data/oa/function'
# Use a named compound under each storage root, and pass that same compound to macros.
for x in f.rglob('*.mcfunction'):
 s=x.read_text();t=s
 for store in ['oa:roster_spawn','oa:g_move','oa:throw_push']:
  # The source side of copies needs explicit args too after moving the working compound.
  t=re.sub(r'(data modify storage '+re.escape(store)+r') set\b',r'\1 args set',t)
  t=re.sub(r'(execute store (?:result|success) storage '+re.escape(store)+r') (\S+)',r'\1 args.\2',t)
  t=re.sub(r'(with storage '+re.escape(store)+r')(?=\s*$)',r'\1 args',t,flags=re.M)
  t=re.sub(r'(from storage '+re.escape(store)+r')(?=\s*$)',r'\1 args',t,flags=re.M)
 if t!=s:x.write_text(t)
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.8.2','1.8.3')
  if s!=t:x.write_text(t)
x=p/'README_JA.md';x.write_text(x.read_text()+'\n本体1.8.3では作業用ストレージをargs複合タグに統一し、管理者の試合復帰・ガチャ移動・雪玉／卵の補助押し出しの対象パスとマクロ引数を揃えています。ZIP交換後 `/reload` で反映します。リソパ交換・マップ再生成は不要です。\n')
shutil.copyfile('release_1_8_3/fix183.py',p/'source/fix183.py')
print('Storage targets and macro argument paths fixed')

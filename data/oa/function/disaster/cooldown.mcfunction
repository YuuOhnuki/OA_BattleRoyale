# 1.9.212：次の通常の災害までの秒（cfg.cd_min〜cd_max。1.9.211 までは 70〜110）
$execute store result score #dis_cd br.tmp run random value $(cd_min)..$(cd_max)

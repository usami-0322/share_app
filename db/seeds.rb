3.times do |i|
  User.create(
    name: "ユーザー #{i + 1}",
    employee_number: i + 1 ,
    password: "password"
)
end

3.times do |i|
  Post.create(
    user_id: User.find(i+1).id,
    title: "【週報】〇〇のセット販売にともなう売上改善について",
    content: "- 改善点 -
    骨の生成サイクルを考慮し、〇〇を3個セットで販売。
    骨密度、自己チェックリストを売り場に設置。
    - 結果 -
    〇〇販売実績 前週比　◯％
    販売金額　◯円
    - 次週の目標 -
    自己チェックリストを売り場に設置。
    従業員への勉強会実施。
    ",
    field: "売上改善"
  )
end

3.times do |i|
  Post.create(
    user_id: User.find(i+1).id,
    title: "【週報】〇〇イベント実施",
    content: "- 接客 -
    朝礼での勉強会実施。
    従業員の意見を拾い上げ、〇〇の訴求を中心に行なっていくことにした。
    ワークスケジュールに接客時間の落とし込み、接客した時の反応を各自1行で簡潔にまとめる。
    - 結果 -
    〇〇販売実績 前週比　◯%
    販売金額　◯円
    - 次週の目標 -
    接客によるお客様の反応から次週は〇〇を追加で訴求していく。",
    field: "接客"
  )
end

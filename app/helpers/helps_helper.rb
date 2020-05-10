module HelpsHelper
  
  def category_array
    category_array = [
      ["選択してください", nil],
      ["会員登録前の質問", 1],
      ["会員登録について", 2],
      ["初期設定について", 3],
      ["プロフィール登録", 4],
      ["ライブハウス登録", 5],
      ["オファー", 6],
      ["メッセージ機能", 7],
      ["見積り", 8],
      ["決済及び支払い", 9],
      ["演奏当日のトラブルなど", 10],
      ["レビュー", 11],
      ["名刺作成", 12],
      ["ご意見・改善リクエスト",98],
      ["その他", 99]
    ]
    return category_array
  end

  def category_show(int)
    begin
      category_name = category_array.to_h.key(int)
      return category_name
    rescue
      return int
    end
  end

end

module HelpsHelper

  def category_array
    category_array = [
      ["選択してください", nil],
      ["サービス", 1],
      ["会員登録", 2],
      ["Stripe登録", 3],
      ["アカウントについて", 4],
      ["ライブハウス登録", 5],
      ["支援方法", 6],
      ["決済及びお支払い", 7],
      ["その他サービスの使用方法", 8],
      ["協賛・協力について", 9],
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

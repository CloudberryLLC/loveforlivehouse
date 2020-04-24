module NameCardOrdersHelper
  def show_payment_option(payment_option)
    case payment_option
    when 1
      "クレジットカード"
    when 2
      "銀行振込"
    else
      "支払い方法が選択されていません。修正してください。"
    end
  end
end

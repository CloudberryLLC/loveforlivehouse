module PaymentsHelper
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

  def show_payment_status(paid)
    if paid == true
      "支払い済み"
    else
      "未払い"
    end
  end
end

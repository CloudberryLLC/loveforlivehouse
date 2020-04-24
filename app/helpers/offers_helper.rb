module OffersHelper

	#オファーのステータス一覧
  def offer_status_array
    offer_status_array = [
      ["問い合わせ", 0],
      ["オファー中", 1],
      ["オファー(変更)", 2],
      ["オファー不成立(パフォーマー非承認)", 3],
      ["見積り提示中", 4],
      ["再見積り依頼中", 5],
      ["オファー不成立(クライアント非承認)", 6],
      ["オファー仮承諾(入金待ち)", 7],
      ["オファー仮承諾(支払手続中)", 8],
      ["オファー仮承諾(入金確認中)", 9],
      ["オファー不成立(期限切れ)", 10],
      ["オファー取り下げ", 11],
      ["入金前キャンセル(入金期限切れ)", 12],
      ["オファー確定(入金完了)", 13],
      ["キャンセル(クライアント側)", 14],
      ["キャンセル(パフォーマー側)", 15],
      ["キャンセル(ユーザー都合以外の理由)", 16],
      ["完了(レビューをお願いします)", 17],
      ["完了(レビュー済)", 18],
      ["支払後キャンセル(返金申請中)", 19],
      ["キャンセル払戻完了", 20],
      ["完了(パフォーマーへ支払済み)", 21],
      ["その他例外", 22]
    ]
    return offer_status_array
  end

  #支援画面の相手写真を表示
  def get_photo_of_counterpart(client, contractor, performer)
		begin
			if client == current_user.id
				photo = PerformerProfile.find(performer).profile_photo
			elsif contractor == current_user.id
				photo = Basic.find_by("user_id = ?", client).profile_photo
			end
			return photo
		rescue
			return 'nophoto.png'
		end
  end

  def get_name_of_counterpart(client, contractor, performer)
    begin
  		if client == current_user.id
  			reciever = PerformerProfile.find(performer)
        name = reciever.performer_name
  		elsif contractor == current_user.id
  			reciever = Basic.find_by("user_id = ?", client)
        name = reciever.lastname + reciever.firstname
  		end
			return name
    rescue
      return ""
		end
  end

	#オファーのステータスを表示する
  def show_offer_status(int)
    begin
      offer_status = offer_status_array.to_h.key(int)
      return offer_status
    rescue
      return int
    end
  end

  #オファー画面のタイトル切り替え
  def select_offer_page_title(int)
    begin
      unless int == 0
        return "オファー"
      else
        return "問い合わせ"
      end
    rescue
      return "オファー・問い合わせ"
    end
  end

  def show_offer_accept_button?(int)
    case int
    when 1, 2, 5 #オファーステータスの値が1,2,5のとき
      return true
    else
      return false
    end
  end

  def show_offer_edit_button?(int)
    case int
    when 1, 2 ,4 ,5
      return true
    else
      return false
    end
  end

  def show_estimation_edit_button?(int)
    int == 5 ? true : false
  end

  def show_last_updater(last_updater)
    begin
      return last_updater.basic.lastname + last_updater.basic.firstname
    rescue
      return
    end
  end

  def show_bank_account(user)
    begin
      bank_account = user.bank.bank_name + " " +
      user.bank.bank_branch + " (" +
      user.bank.bank_branch_code + ") " +
      user.bank.bank_type + " " +
      user.bank.bank_number + " " +
      user.bank.bank_owner + " (" +
      user.bank.bank_owner_kana + ")"
      return simple_format(bank_account)
    rescue
      return "銀行口座情報が不完全です。ユーザーに入力を依頼してください。"
    end
  end

  #Offer#Update時のメッセージ切り替え
  def offer_notice(offer_status)
    message_list = [
      ["パフォーマーに新規オファーを出しました。", 1],
      ["オファーの内容が変更されました。", 2],
      ["このオファーを見送りました。", 3],
      ["クライアントに見積りを送りました。", 4],
      ["パフォーマーに再見積りを依頼しました。", 5],
      ["このオファーを見送りました。", 6],
      ["このオファーを承認しました。", 7],
      ["支払い方法を選択しました", 8],
      ["ありがとうございます。入金確認後オファーが確定します。", 9],
      ["お支払いが完了しました。", 13],
      ["このオファーをキャンセルしました。", 14],
      ["このオファーをキャンセルしました。", 15],
      ["このオファーをキャンセルしました。", 16],
      ["クライアントとパフォーマーへの払戻が完了しました。", 20]
    ]
    begin
      return message_list.to_h.key(offer_status)
    rescue
      return "オファーの内容を変更しました。"
    end
  end

	#オファー画面の見出し切り替え
	def offer_title(offer_status)
		if offer_status == 0
			offer_status = 1
			offer_title = "新規オファー"
		else
			offer_title = "オファー編集"
			offer_status = 5
		end
		return offer_title, offer_status
	end

#見積りがない時の仮見積り
	def estimate_guarantee(offer, performer)
		number_of_member = performer.number_of_member
		guarantee = performer.basic_guarantee * number_of_member
		start = offer.meeting_time
		finish = offer.release_time
		playing = offer.playing_time
		#拘束時間2時間以内、かつ演奏時間10分以内の場合
		duration = get_duration(finish, start)[2]
		if (duration <= 2 && playing.to_i <= 15)
			days = 0.5
		else
			days = 1 + duration.div(24).to_i
		end
			guarantee = (guarantee * days).to_i
	end

#見積りがあるかないかの判定
	def estimation_exists?(offer_id)
		return Estimation.exists?(:offer_id => offer_id)
	end

#見積り及び請求金額の総額
	def total(model)
		total =
		model.guarantee.to_i +
		model.staff.to_i +
		model.withholding_tax.to_i +
		model.system_fee.to_i +
		model.transport.to_i +
		model.accommodation.to_i +
		model.carriage.to_i +
		model.equipment.to_i +
		model.other_expenses.to_i
		return total.to_i
	end

#小計(演奏料＋スタッフ人件費＋システム利用料)
	def subtotal_main(estimation)
		subtotal =
		estimation.guarantee.to_i +
		estimation.staff.to_i +
		estimation.withholding_tax.to_i +
		estimation.system_fee.to_i
		return subtotal.to_i
	end

#小計(経費)
	def subtotal_expenses(estimation)
		subtotal =
    estimation.transport.to_i +
    estimation.accommodation.to_i +
    estimation.carriage.to_i +
    estimation.equipment.to_i +
    estimation.other_expenses.to_i
		return subtotal.to_i
	end
#見積り中の、事前精算費用の計算
	def calculate_pre_paid_expenses(estimation)
		pre_paid_expenses = estimation.transport.to_i +
		estimation.accommodation.to_i +
		estimation.carriage.to_i +
		estimation.equipment.to_i +
		estimation.other_expenses.to_i
		return pre_paid_expenses.to_i
	end

  def show_change_payment_method_button?(offer_status)
    case offer_status
    when 8, 9
      return true
    else
      return false
    end
  end

#請求書と領収書ボタン表示振り分け
	def show_invoice?(user, offer_status)
    if user.user_type == 1
  		case offer_status
  		#オファー成立時に請求書のリンクを表示
      when 7..9, 13..21
  			return true
      else
        return false
      end
    elsif user.user_type == 3
  		case offer_status
  		#オファー成立時に請求書のリンクを表示
    when 17..21
  			return true
      else
        return false
      end
    end
  end

  def show_reciept?(user, offer_status)
    if user.user_type == 1
      case offer_status
  		#支払完了時に請求書と領収書のリンクを表示
      when 13..21
  			return true
  		else
  			return false
  		end
    elsif user.user_type == 3
      case offer_status
  		#支払完了時に請求書と領収書のリンクを表示
      when 21
  			return true
  		else
  			return false
  		end
    end
	end

  def show_no_invoices?(user, offer_status)
    if ( show_invoice?(user, offer_status) == false && show_reciept?(user, offer_status) == false )
      return true
    else
      return false
    end
  end

  def show_payback_statement?(offer_status)
    case offer_status
		when 20
      return true
    else
      return false
    end
  end

#支払い方法を表示する
	def view_payment_option(option)
		case option
		when 1
			return "クレジットカードまたはデビットカード"
		when 2
			return "銀行振込"
		else
			return "選択なし"
		end
	end

	def show_decline_button?(offer)
		case offer.offer_status
		when 7,8,9
			return true
		else
			return false
		end
	end

	def show_cancel_button?(offer)
		if offer.offer_status == 13
			return true
		else
			return false
		end
	end

	def cancel_due(offer_status)
		case offer_status
		when 14
			return "クライアント都合"
		when 15
			return "パフォーマー都合"
		when 16
			return "天候・災害等の不可抗力"
		end
	end

	def show_phone_number_of_counterpart(offer, client, contractor)
		if current_user == client
			return 'パフォーマーの当日連絡先: ' + contractor.basic.phone.to_s
		elsif current_user == contractor
			return 'クライアントの当日連絡先: ' + client.basic.phone.to_s
		else
		end
	end

#オファーが不成立かどうかの判定
  def offer_declined?(offer)
    case offer.offer_status
    when 3, 6, 10, 11, 12, 14, 15, 16
      return true
    else
      return false
    end
  end

  def set_decline_status_value
    if livehouse?
      return 3
    elsif supporter?
      return 6
    end
  end

#オファー不成立の際のメッセージ
  def offer_declined_message(offer)
    case offer.offer_status
    when 3, 6
      return "このオファーは承認されませんでした"
    when 10, 12
      return "このオファーは期限切れとなりました"
    when 14, 15, 16
      return "このオファーはキャンセルされました"
    else
      return false
    end
  end

#オファー不成立、キャンセル時に背景をグレイにする
  def css_offer_expired?(offer)
    begin
      case offer.offer_status
      when 3, 6, 10, 11, 12, 14, 15, 16
        return "offer_expired"
      else
        return
      end
    rescue
      return
    end
  end

end

module ApplicationHelper

#ユーザータイプの判定
	def supporter?
		current_user.user_type == 1
	end

	def livehouse?
		current_user.user_type == 3
	end

	def admin?
		current_user.admin == true
	end

	def show_user_type(user)
		begin
			case user.user_type
			when 1
				return "支援者"
			when 3
				return "ライブハウス"
			end
		rescue
			return "ユーザータイプが取得できませんでした。"
		end
	end

#プロフィール写真があればそれを、なければnophoto.pngを返す
	def photo(attached_photo)
		begin
			attached_photo.attached? ? attached_photo : 'nophoto.png'
		rescue
			photo = 'nophoto.png'
		end
	end

	def thumbnail(attached_photo)
		begin
			attached_photo.attached? ? attached_photo.variant(combine_options:{resize:"480x480^", crop:"480x480+0+0",gravity: :center}).processed : photo = 'nophoto.png'
		rescue
			photo = 'nophoto.png'
		end
	end

#プロフィールのYoutubeURLを埋め込み形式に変換
	def movie(url)
		if url.present?
			url[/(youtube\.com\/watch\?v=)|(youtu\.be\/)/] = "youtube.com\/embed\/"

			iframe = content_tag(
			:iframe,
			'', # empty body
			width: 320,
			height: 240,
			src: url,
			frameborder: 0,
			allowfullscreen: true
			)
			content_tag(:div, iframe, class: 'col-lg-4 videos')
		else
			#Youtubeリンクがない場合は何も表示しない
		end
	end

#時間計算、表示に関わる関数。第一引数に時間表記、第二引数は秒数を返す。
  def get_duration(t1, t2)
    duration = t1-t2
    hour = duration.div(3600)
    min = duration.div(60) - hour * 60
    show_duration = hour.to_s + "時間" + min.to_s + "分"
    return show_duration, duration, hour, min
  end

#日付表示(領収書及び請求書)
	def show_date(datetime)
		year = datetime.year.to_s
		month = datetime.month.to_s
		day = datetime.day.to_s
		return year + "年" + month + "月" + day + "日"
	end

#会社名の表示
	def show_company_name(basic)
		unless basic.company == "なし"
			return basic.company
		end
	end

#基本演奏料+スタッフ人件費(税込)から表示価格(税込)を計算
	def calculate_price(guarantee)
		begin
			item = []
			#アーティストの手取り額、つまり振込額。消費税込み。
			item[0] = guarantee
			#報酬(消費税・源泉税等込)
			item[1] = reward = (guarantee / (1 - Constants::WITHHOLDING_TAX_RATE))
			#システム利用料(消費税込)
			item[2] = system_fee = [(reward * Constants::SYSTEM_FEE), Constants::SYSTEM_FEE_LIMIT].min
			#報酬とシステム利用料の合計(税込)
			item[3] = net_price = reward + system_fee
			#源泉税・特別復興加算税等の額
			item[4] = withholding_tax = reward - guarantee
			#消費税(総額)
			item[5] = net_sales_tax = (reward + system_fee) * Constants::SALES_TAX / (1 + Constants::SALES_TAX)
			#報酬(税抜)
			item[6] = reward_exclude_sales_tax = reward / (1 + Constants::SALES_TAX)
			#システム利用料(税抜)
			item[7] = system_fee_exclude_sales_tax = system_fee / (1 + Constants::SALES_TAX)
			#報酬にかかる消費税
			item[8] =  sales_tax_for_reward = reward - reward_exclude_sales_tax
			#システム利用料にかかる消費税
			item[9] = sales_tax_for_system_fee = system_fee - system_fee_exclude_sales_tax
			return item
		rescue
		end
	end

	def review_score(review)
		review ||= 0.00
	end

	def favorite_toggle(favorite_status)
		favorite_status ? 'pink' : 'gray'
	end


#テキストの要素がない場合はない旨を、ある場合はその内容を表示
def description(text)
	begin
		text.present? ? simple_format(text) : "記載はありません。"
	rescue
		return "記載はありません。"
	end
end

#以下、定数を返す関数
	#源泉税率を返す
	def withholding_tax_rate
		return Constants::WITHHOLDING_TAX_RATE
	end

	def sales_tax_rate
		return Constants::SALES_TAX
	end

	#システム利用料を返す
	def system_fee_rate
		return Constants::SYSTEM_FEE
	end

#領収書、請求書の番号を返す
  def set_number(offer)
		begin
	    number =
	      (offer.release_time.year - 2000).to_s +
	      offer.release_time.month.to_s +
	      offer.release_time.day.to_s +
	      offer.id.to_s
	    return number
		rescue
		end
  end


# partial/performer_listに格納するローカル変数がPerformerProfileクラスでない場合に
# PerformerProfileクラスから該当するインスタンスを呼び出す
	def set_profile_card_instance(performer)
		begin
			case performer
			when PerformerProfile
				return performer
			when FavoritePerformer
				performer = PerformerProfile.find(performer.performer)
				return performer
			when String
				performer = PerformerProfile.find(performer)
				return performer
			end
		rescue
			performer = nil
			return performer
		end
	end

#Donation#Newを作る時の確認用ハッシュ生成
	def livehouse_hash(livehouse)
		return Digest::SHA256.hexdigest(livehouse.id.to_s + livehouse.shop_email.to_s + livehouse.user_id.to_s)
	end

	def encode_livehouse_id(livehouse)
		return (livehouse.to_i * 357) + 6775636
	end

	def decode_livehouse_id(livehouse)
		if (livehouse.to_i - 6775636) % 357 == 0
			return (livehouse.to_i - 6775636) / 357
		else
			return -1
		end
	end

end

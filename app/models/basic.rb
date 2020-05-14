class Basic < ApplicationRecord

	belongs_to :user, optional: true

	has_one_attached :profile_photo
	has_one_attached :cover_photo

	has_one_attached :id_front
	has_one_attached :id_back
	has_one_attached :company_certification

	#ライブハウスと支援者で必須項目が違うので、presence:true はviewでinput要素のrequired属性を使って代替しています(止むを得ず)。
	validates :phone, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
	validates :zipcode, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }

end

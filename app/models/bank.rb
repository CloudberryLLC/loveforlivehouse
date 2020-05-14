class Bank < ApplicationRecord

	belongs_to :user, optional: true

	#ライブハウスと支援者で必須項目が違うので、presence:true はviewでinput要素のrequired属性を使って代替しています(止むを得ず)。
	#validates :bank_branch_code, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
	#validates :bank_number, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
	#validates :bank_owner_kana, format: { with: /\A[ァ-ンー－]*\Z/, allow_blank: true, message:"は、全角カタカナで入力してください" }

end

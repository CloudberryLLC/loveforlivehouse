module DashboardHelper
  def show_reward(livehouse)
    #月の設定
    beginning_of_month = DateTime.now.beginning_of_month
    end_of_month = DateTime.now.end_of_month
    #支援金の計算
  	donations = Donation.where('livehouse_id = ? AND (created_at BETWEEN ? AND ?)', livehouse, beginning_of_month, end_of_month)
    donation_total = donations.sum(:amount)
    donation_recievable = donation_total * ( 1 - Constants::SYSTEM_FEE )
    return donations.length, donation_total, donation_recievable.to_i
  end
end

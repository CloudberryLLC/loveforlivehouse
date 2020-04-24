module DashboardHelper
  def show_reward(performer)
    salary = 0
    beginning_of_month = DateTime.now.beginning_of_month
    end_of_month = DateTime.now.end_of_month
  	offers = Offer.where('offered_performer = ? AND (meeting_time BETWEEN ? AND ?)', performer, beginning_of_month, end_of_month)
    offers.each do |i|
      if i.payment.present?
        salary += (i.payment.guarantee + i.payment.withholding_tax)
      else
        salary += 0
      end
    end
    return offers.length, salary
  end

end

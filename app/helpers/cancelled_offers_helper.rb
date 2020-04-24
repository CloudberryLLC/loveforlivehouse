module CancelledOffersHelper
  include OffersHelper

  def show_profit(c)
    profit = c.recieved_amount.to_i - c.pay_amount_to_performer.to_i - c.pay_amount_to_client.to_i rescue 0
    return profit.to_s(:delimited)
  end
end

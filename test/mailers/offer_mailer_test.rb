require 'test_helper'

class OfferMailerTest < ActionMailer::TestCase
  test "new_offer" do
    mail = OfferMailer.new_offer_notice
    assert_equal "New offer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

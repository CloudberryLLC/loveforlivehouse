require 'test_helper'

class NameCardOrderMailerTest < ActionMailer::TestCase
  test "order_confirmed" do
    mail = NameCardOrderMailer.order_confirmed
    assert_equal "Order confirmed", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "coming_order" do
    mail = NameCardOrderMailer.coming_order
    assert_equal "Coming order", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

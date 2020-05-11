require 'test_helper'

class ReviewMailerTest < ActionMailer::TestCase
  test "to_admin" do
    mail = ReviewMailer.to_admin
    assert_equal "To admin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "to_contractor" do
    mail = ReviewMailer.to_livehouse
    assert_equal "To contractor", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "to_supporter" do
    mail = ReviewMailer.to_supporter
    assert_equal "To supporter", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

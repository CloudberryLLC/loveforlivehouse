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
    mail = ReviewMailer.to_performer
    assert_equal "To contractor", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "to_client" do
    mail = ReviewMailer.to_client
    assert_equal "To client", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

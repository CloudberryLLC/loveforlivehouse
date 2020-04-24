require 'test_helper'

class UserProfileCertificationMailerTest < ActionMailer::TestCase
  test "send_admin" do
    mail = UserProfileCertificationMailer.send_admin
    assert_equal "Send admin", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "send_user" do
    mail = UserProfileCertificationMailer.send_user
    assert_equal "Send user", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

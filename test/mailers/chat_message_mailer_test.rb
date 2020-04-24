require 'test_helper'

class ChatMessageMailerTest < ActionMailer::TestCase
  test "send_reciever_message" do
    mail = ChatMessageMailer.send_reciever_message
    assert_equal "Send reciever message", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

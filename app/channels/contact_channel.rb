class ContactChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    contact = Contact.find(params[:contact_id])
    stream_for contact.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end

App.MakeContactChannel = (contact_id) ->
  App.contact = App.cable.subscriptions.create {channel: "ContactChannel", contact_id: contact_id},
    connected: ->
      console.log 'connected'

    disconnected: ->
      # Called when the subscription has been terminated by the server
      console.log 'disconnected'

    rejected: ->
      console.log 'rejected'

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      $('#chat_messages').append data['chat_message']

      if $('#fromId').val() == $('.new-sender-id').text()
        $('.chat-new-sender').remove()
        $('.chat-new-body').addClass 'chat-sender-body'
      else
        $('.chat-new-sender').addClass 'chat-sender'
        $('.chat-new-body').addClass 'chat-reciever-body'
        $('div').removeClass 'chat-new-sender'

      $('div').removeClass 'chat-new-body'
      $('.new-sender-id').remove()
      $('#new_message').remove()

      $('.container').scrollTop($('#chat_messages')[0].scrollHeight);
      $('#chatMessagesBody').val('')

      console.log 'recieve_successed!'

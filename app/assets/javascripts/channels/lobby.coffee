App.lobby = App.cable.subscriptions.create "LobbyChannel",
  appendGiphy: (user, message) ->
    reply = user + ': ' + '<img src="' + message + '"><br>'
    $('.messages').append(reply)
    $('html,body').animate({scrollTop: $(document).height()}, 1000);

  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data.action
      when "speak"
        App.lobby.appendGiphy(data['user'], data['message'])

  speak: (message) ->
    @perform 'speak', message: message

$(document).on "keypress", '[data-behavior~=lobby_speaker]', (event) ->
  if event.keyCode is 13
    App.lobby.speak event.target.value
    event.target.value = ''
    event.preventDefault()

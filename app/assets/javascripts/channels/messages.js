App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    var room_id = $('#title').attr('room')

    if (data.msg.room_id == room_id)
      $('#message-list').append("<li>" + data.str + "</li>");
  }
});

App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(msg) {
    return $('#message-list').append("<li>" + msg + "</li>");
  }
});

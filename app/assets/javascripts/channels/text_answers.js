App.messages = App.cable.subscriptions.create('TextAnswersChannel', {  
    received: function(question) {
      var room_id = $('#room-title').attr('room')
      
      if (question.room_id == room_id) {
        chart_exists = $('#chart-' + question.id).length != 0
        if (chart_exists)
          viewResults(question.id)
      }
    }
  });
  
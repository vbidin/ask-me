App.messages = App.cable.subscriptions.create('QuestionsChannel', {  
  received: function(question) {
    var room_id = $('#room-title').attr('room')

    if (question.room_id == room_id)
      $('#question-list').append(`
        <button type="button" onclick="loadQuestion(` + question.id + `)" class="question-button list-group-item list-group-item-action">` + question.title + `</button>
      `);
  }
});

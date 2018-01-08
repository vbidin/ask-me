function rowStyle(row, index) {
  if (row.permission == "Admin")
    return { classes: "info" }
  if (row.status == "Open")
    return { classes: "success" }
  return { classes: "" }
}

function loadQuestion(id) {
  $.get("/questions/" + id + ".json")
    .done(function(question) {
      $('#question-title').html(question.title)
      $('#question-text').html(question.text)
      $('#question-answers').html("answers go here")
  })
}

function postMessage(user_id, room_id) {
  var text = $('#message-box').val()
  $.post("/messages.json", { message: { user_id: user_id, room_id: room_id, text: text } })
    .done(function(message) {
      $('#message-list').append("<li>" + message + "</li>")
    })
}
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
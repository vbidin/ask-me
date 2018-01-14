function rowStyle(row, index) {
  if (row.permission == "Admin")
    return { classes: "info" }
  if (row.status == "Open")
    return { classes: "success" }
  return { classes: "" }
}

function loadQuestion(id) {
  $.get("/questions/" + id + ".json")
    .done(function(data) {
      let question = data.question
      let type = data.type
      let answers = data.answers

      $('#question-title').html(question.title)
      $('#question-text').html(question.text)
      $('#question-answers').empty()
      $('#question-footer').empty()

      if (type.name == "choice")
        loadChoiceAnswers(answers)
      else if (type.name == "multiple choice")
        loadMultipleChoiceAnswers(answers)
      else
        throw "unsupported question type: " + type.name

      footer = $('#question-footer')
      footer.append(`<button id="` + question.id + `" type="button" onclick="submitAnswer(` + question.id + `)" class="btn btn-sm btn-primary btn-submit">Submit</button>`)
      footer.append(`<button id="` + question.id + `" type="button" onclick="viewResults(` + question.id + `)" class="btn btn-sm btn-primary btn-view">View results</button>`)
  })
}

function loadChoiceAnswers(answers) {
  let container = $('#question-answers')
  container.empty();

  answers.forEach(function(answer) {
    container.append(`
      <div class="radio">
        <label><input value="` + answer.id + `" type="radio">` + answer.data + `</label>
      </div>`)
  })
}

function loadMultipleChoiceAnswers(answers) {
  let container = $('#question-answers')
  container.empty();

  answers.forEach(function(answer) {
    container.append(`
      <div class="checkbox">
        <label><input value="` + answer.id + `" type="checkbox">` + answer.data + `</label>
      </div>`)
  })
}

function submitAnswer(question_id) {
  alert("submitting...")
}

function viewResults(question_id) {
  alert("viewing...")
}

function postMessage(user_id, room_id) {
  var text = $('#message-box').val()
  $.post("/messages.json", { message: { user_id: user_id, room_id: room_id, text: text } })
  $('#message-box').val("")
}
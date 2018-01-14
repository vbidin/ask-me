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
      $('#question-text').append("<hr>")
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
        <label><input value="` + answer.id + `" type="radio" name="option">` + answer.data + `</label>
      </div>
    `)
  })
}

function loadQuestionForm() {
  let title_container = $('#question-title')
  title_container.empty()
  title_container.html(`
    <div class="row">
      <form class="form-inline">
        <label for="title">Title:</label>
        <input id="title" type="text" class="form-control">
      </form>
    </div>
  `)

  let text_container = $('#question-text')
  text_container.empty()
  text_container.append(`
    <div class="row">
      <div class="form-group">
        <textarea rows=1 style="resize: none; width: 90%; display: inline-block" id="text" class="form-control"/>
      </div>
    </div>
  `)

  let answers_container = $('#question-answers')
  answers_container.empty()
  answers_container.append(`
    <div class="row">
      <button type="button" onclick="addAnswer()" style="float: center; width: 20%" class="btn btn-sm btn-success"><b>Add</b></button>
      <button type="button" onclick="removeAnswer()" style="float: center; width: 20%" class="btn btn-sm btn-danger"><b>Remove</b></button>
    </div>
    <hr>
    </div>
    <div id="answer-list"></div>
  `)

  let footer_container = $('#question-footer')
  footer_container.empty()
  footer_container.append(`
    <button type="button" onclick="saveQuestion()" style="float: center; width: 20%" class="btn btn-sm btn-primary">Submit</button>
  `)
}

function addAnswer() {
  let answers = $('#answer-list')
  answers.append(`
    <form class="form-inline">
      <input type="text" class="form-control" style="display: inline-block; width: 50%">
      <div class="checkbox">
        <input type="checkbox">
      </div>
    </form>
  `)
}

function removeAnswer() {
  $('#answer-list form:last').remove()
}

function saveQuestion() {
  let user_id = $('#room-title').attr('user')
  let room_id = $('#room-title').attr('room')
  let type_id = 2
  let title = $('#title').val()
  let text = $('#text').val()
  let visible = true
  let locked = false

  $.post("/questions.json", { question: {
      user_id: user_id,
      room_id: room_id,
      type_id: type_id,
      title: title,
      text: text,
      visible: visible,
      locked: locked
    }
  }).done(function(question) {
    let answers = []
    $('#answer-list > form').each(function() {
      let question_id = question.id
      let data = $(this).find('input').val()
      let correct = $(this).find('.checkbox > input').is(":checked")
      answers.push({ question_id: question_id, data: data, correct: correct })
    })

    answers.forEach(function(answer) {
      $.post("/answers.json", { answer: answer })
    })

    setTimeout(function() {
      loadQuestion(question.id)
    }, 1000)

    $('#info').html(`
      <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <p>Successfully created a question.</p>
      </div>
    `)
    
  }).fail(function(data) {
    $('#info').html(`
      <div class="alert alert-danger alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
      </div>
    `)
    data.responseJSON.forEach(function(error) {
      $('#info > div').append("<p>" + error + "</p")
    })
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
  alert("submitting answer...")
}

function viewResults(question_id) {
  alert("viewing results...")
}

function postMessage(user_id, room_id) {
  var text = $('#message-box').val()
  $.post("/messages.json", { message: { user_id: user_id, room_id: room_id, text: text } })
  $('#message-box').val("")
}
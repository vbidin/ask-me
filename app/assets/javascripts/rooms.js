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
      let answered = data.answered
      let given_answers = data.given_answers

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
      footer.append(`<button id="submit" type="button" onclick="submitAnswer(` + question.id + `)" class="btn btn-sm btn-primary btn-submit">Submit</button>`)
      footer.append(`<button id="view-results" type="button" onclick="viewResults(` + question.id + `)" class="btn btn-sm btn-primary btn-view">View results</button>`)

      if (answered) {
        loadGivenAnswers(given_answers)
        markCorrectAnswers(answers)
        $("input[type=checkbox], input[type=radio]").prop("disabled", true)
      }

      if (answered || question.locked)
        $('#submit').prop("disabled", true)
      else
        $('#view-results').prop("disabled", true)
  })
}

function loadChoiceAnswers(answers) {
  let container = $('#question-answers')
  container.empty();

  answers.forEach(function(answer) {
    container.append(`
      <div class="radio">
        <input value="` + answer.id + `" type="radio" name="option"><label>` + answer.data + `</label>
      </div>
    `)
  })
}

function loadMultipleChoiceAnswers(answers) {
  let container = $('#question-answers')
  container.empty();

  answers.forEach(function(answer) {
    container.append(`
      <div class="checkbox">
        <input value="` + answer.id + `" type="checkbox"><label>` + answer.data + `</label>
      </div>`)
  })
}

function loadGivenAnswers(given_answers) {
  given_answers.forEach(function(ga) {
    if (ga != null) {
      answer = $('input[value=' + ga.answer_id + ']')
      answer.prop("checked", true)
    }
  })
}

function markCorrectAnswers(answers) {
  answers.forEach(function(answer) {
    if (answer.correct) {
      label = $('input[value=' + answer.id + ']').parent().children().eq(1)
      label.addClass("correct")
    }
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
      $('#info').html(`
        <div class="alert alert-success alert-dismissable">
          <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          <p>Successfully created a question.</p>
        </div>
      `)
    }, 300)
    
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

function submitAnswer(question_id) {
  let user_id = $('#room-title').attr('user')
  let inputs = $('input[type=checkbox], input[type=radio]')

  inputs.each(function() {
    let answer_id = $(this).val()
    let isChecked = this.checked

    if (isChecked)
      $.post("/given_answers.json", { given_answer: { user_id: user_id, answer_id: answer_id } })
      .fail(function(data) {
        $('#info').html(`
          <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
          </div>
        `)
        data.responseJSON.forEach(function(error) {
          $('#info > div').append("<p>" + error + "</p")
        })
      })
  })

  setTimeout(function() {
    $('#info').html(`
      <div class="alert alert-success alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <p>Successfully submitted answer.</p>
      </div>
    `)
    loadQuestion(question_id)
  }, 300)
}

function viewResults(question_id) {
  let container = $('#question-answers')
  container.empty()

  let id = "chart-" + question_id
  container.append(`<canvas id="` + id + `"></canvas>`)
  
  let context = document.getElementById(id).getContext('2d');
  $.get("/given_answers/" + question_id)
    .done(function(chart) {
      new Chart(context, chart)
  });

  $('#view-results').html("View answer")
  $('#view-results').attr("onclick", "loadQuestion(" + question_id + ")")
}

function postMessage(user_id, room_id) {
  var text = $('#message-box').val()
  $.post("/messages.json", { message: { user_id: user_id, room_id: room_id, text: text } })
  $('#message-box').val("")
}
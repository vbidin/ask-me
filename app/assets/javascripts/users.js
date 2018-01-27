function viewUserResults(user_id) {
    let container = $('#user-answers')
    container.empty()
  
    let id = "stats-" + user_id
    container.append(`<canvas id="` + id + `"></canvas>`)
    
    let context = document.getElementById(id).getContext('2d');

   $.get("/users/" + user_id)
      .done(function(chart) {
        new Chart(context, chart)
    });

}
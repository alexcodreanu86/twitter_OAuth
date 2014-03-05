$(document).ready(function(){
  function enterPacman() {
      $("#pacman").html("<h1> Wait for it... Proccessing request </h1><div id='spinner'></div>");
  };

  removePacman = function() {
      $("#pacman").html("");
  }

  $('form').on('submit', function(e) {
    e.preventDefault();
    data = $(this).serialize();
    enterPacman()
    $.post('/tweet', data, function(response) {
      url = "/status/" + response
      var checkInterval = setInterval(function(){
        $.get(url,function(sdata){
          if(sdata == "done"){        
            removePacman();
            var appHtml = "<p>Your tweet has been posted.</p>";
            $("#print-out").append(appHtml);
            clearInterval(checkInterval);
          };
        });
      },2000);
    });   

  });
})  

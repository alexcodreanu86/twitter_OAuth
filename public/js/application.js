$(document).ready(function() {
    function enterPacman() {
        $("#pacman").html("<h1> Wait for it... Proccessing request </h1><div id='spinner'></div>");
    };

    function removePacman() {
        $("#pacman").html("");
    }

    $('form').on('submit', function(e) {
        e.preventDefault();
        data = $(this).serialize();
        enterPacman()
        $.post('/tweet', data, function(response) {
            $("#print-out").append(response);

        })
        setTimeout(removePacman, 2000)
        $("textarea").val("");
    });
});

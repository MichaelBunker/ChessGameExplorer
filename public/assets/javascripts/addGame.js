
var pgnCheck = function() {
  $.get( "/uploads/game/pgn/51/AGame.pgn", function( data ) {
    var gamePgn = data;
    var gameNum = (location.href).split("/").pop();
    var gameNotation = (data.split("\n\n").pop()).replace(/(\r\n|\n|\r)/gm,"").replace(/(\d+\.)/g, '$1 ');
    $.ajax({
      type: "PUT",
      url: "/games/" + gameNum,
      data: {gameNum: gameNum, gamePgn: gamePgn, gameNotation: gameNotation},
      dataType: 'json',
      // success: function(json, responseText, jqXHR) {
      // }
    })
  });
};

$(document).ready(pgnCheck);
// $(document).on('page:load', pgnCheck);


$.ajax({
  type: "GET",
  url: "/players",
  data: {game_pgn: game_pgn, moves: moves, turn: turn},
  dataType: 'json',
  success: function(json, responseText, jqXHR) {
    $('#moves_display').text("")
    moveNumber = json.moves.length
    for (var i = 0; i < moveNumber; i++) {
      $('#moves_display').append("<tr> <td> " + json.moves[0] + "</td>" + "<td>" + json.next_move[0] + "</td>" + "</tr>" )
      json.moves.splice(0,1);
      json.next_move.splice(0,1);
    }
  }
})

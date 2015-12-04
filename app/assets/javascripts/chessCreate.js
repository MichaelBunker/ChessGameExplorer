
var game = new Chess();
statusEl = $('#status');
fenEl = $('#fen');
pgnEl = $('#pgn');

var removeGreySquares = function() {
  $('#board .square-55d63').css('background', '');
};

var greySquare = function(square) {
  var squareEl = $('#board .square-' + square);
  var background = '#a9a9a9';
  if (squareEl.hasClass('black-3c85d') === true) {
    background = '#696969';
  }
  squareEl.css('background', background);
};

var onDragStart = function(source, piece) {
  // do not pick up pieces if the game is over or if it's not that side's turn
  if (game.game_over() === true ||
      (game.turn() === 'w' && piece.search(/^b/) !== -1) ||
      (game.turn() === 'b' && piece.search(/^w/) !== -1)) {
    return false;
  }
};

var onDrop = function(source, target) {
  removeGreySquares();
  // check if the move is legal
  var move = game.move({
    from: source,
    to: target,
    promotion: 'q'
  });
  // illegal move
  if (move === null) return 'snapback';
  updateStatus();
  // AJAX request for games in DB.
  var moves = game.moves();
  var game_pgn = game.pgn();
  var turn = game.turn();
  $.ajax({
      type: "GET",
      url: "/players",
      data: {game_pgn, moves, turn},
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
};

var onMouseoverSquare = function(square, piece) {
  var moves = game.moves({
    square: square,
    verbose: true
  });
  // exit if there are no moves available for this square
  if (moves.length === 0) return;
  greySquare(square);
  // highlight the possible squares for this piece
  for (var i = 0; i < moves.length; i++) {
    greySquare(moves[i].to);
  }
};

var onMouseoutSquare = function(square, piece) {
  removeGreySquares();
};

var onSnapEnd = function() {
  board.position(game.fen());
};

var updateStatus = function() {
  var status = '';
  var moveColor = 'White';
  if (game.turn() === 'b') {
    moveColor = 'Black';
  }

  if (game.in_checkmate() === true) {
    status = 'Game over, ' + moveColor + ' is in checkmate.';
  }

  else if (game.in_draw() === true) {
    status = 'Game over, drawn position';
  }
  // game still on
  else {
    status = moveColor + ' to move';
    // check?
    if (game.in_check() === true) {
      status += ', ' + moveColor + ' is in check';
    }
  }
  statusEl.html(status);
  fenEl.html(game.fen());
  pgnEl.html(game.pgn());
};

var cfg = {
  draggable: true,
  position: 'start',
  onDragStart: onDragStart,
  onDrop: onDrop,
  onMouseoutSquare: onMouseoutSquare,
  onMouseoverSquare: onMouseoverSquare,
  onSnapEnd: onSnapEnd
};

var board = ChessBoard('board', cfg);

$('#startBtn').on('click', function() {
  board.start();
  var game = new Chess("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
  updateStatus();
});

$('#clearBtn').on('click', function() {
  board.start();
  board.clear();
  game.reset();
  statusEl.html("");
  fenEl.html("");
  pgnEl.html("");
});

$('#undoBtn').on('click', function() {
  game.undo();
  var fen = game.fen();
  board.position(fen);
  updateStatus();
});

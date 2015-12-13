var onDragStart = function(source, piece) {
  // do not pick up pieces if the game is over or if it's not that side's turn
  if (game.game_over() === true ||
      (game.turn() === 'w' && piece.search(/^b/) !== -1) ||
      (game.turn() === 'b' && piece.search(/^w/) !== -1)) {
    return false;
  }
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
};

// game lets the board be created at the start position.
// gameHistory gets this pgn of the game we want to study.
var game = new Chess();
var gameHistory = new Chess();
var pgn = $('#ind_game_pgn').text();
gameHistory.load_pgn(pgn);
var moves = gameHistory.history();
var cfg = {
  draggable: true,
  position: 'start',
};

var board = ChessBoard('show_game_board', cfg);

$('#startBtn').on('click', function() {
  board.start();
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
});
$('#moveBtn').on('click', function() {
  game.move(moves[0]);
  fen = game.fen();
  board.position(fen);
  moves.splice(0,1)
});

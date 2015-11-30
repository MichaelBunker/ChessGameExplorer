// game lets the board be created at the start position.
// gameHistory gets this pgn of the game we want to study.
var game = new Chess();
var gameHistory = new Chess();
gameHistory.load_pgn(pgn);
var pgn = $('#ind_game_pgn').text();
var moves = gameHistory.history();
var cfg = {
  draggable: true,
  position: 'start',
  onDragStart: onDragStart,
  onDrop: onDrop,
  onMouseoutSquare: onMouseoutSquare,
  onMouseoverSquare: onMouseoverSquare,
  onSnapEnd: onSnapEnd
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

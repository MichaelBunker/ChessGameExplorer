// game lets the board be created at the start position.
// gameHistory gets this pgn of the game we want to study.
var game = new Chess();
var gameHistory = new Chess();
var pgn = $('#ind_game_pgn').text();

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
  // fen = game.fen()
  // board.position(fen)
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
// this gets me the first move. need to figure out best way to loop through array.
// maybe deleting element after it is used? This works, but doesn't save the pgn globally, meaning it sees the full pgn each tmie button is clicked. Need to play around with this to figure out best solution.
  gameHistory.load_pgn(pgn);
  var moves = gameHistory.history();
  game.move(moves[0]);
  fen = game.fen();
  board.position(fen);
  moves.splice(0,1)
});

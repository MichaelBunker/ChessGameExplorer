// var ruyLopez = 'r1bqkbnr/pppp1ppp/2n5/1B2p3/4P3/5N2/PPPP1PPP/RNBQK2R';
// var board1 = ChessBoard('board1', ruyLopez);

var cfg = {
  position: 'start',
  draggable: true,
  dropOffBoard: 'trash',
};
var board = ChessBoard('board1', cfg);

$('#startBtn').on('click', board.start);
$('#clearBtn').on('click', board.clear);

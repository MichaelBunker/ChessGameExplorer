// var stockfish = STOCKFISH();
//
// stockfish.onmessage = function(event) {
//     console.log(event.data);
// };
//
// function uciCmd(cmd) {
//     console.log("UCI: " + cmd);
//     stockfish.postMessage(cmd);
// };
//
// if (game.turn() == 'b') {
//   stockfish.postMessage('position fen ' + fenEl);
//   stockfish.postMessage('go depth 10');
//
// }

// var gameAI = function(line) {
//   if (game.turn() == 'b') {
//     stockfish.postMessage('position fen ' + game.fen());
//     stockfish.postMessage('go depth 1');
//     var move = line.match(/^bestmove ([a-h][1-8])([a-h][1-8])([qrbk])?/);
//     game.move({from: move[1], to: move[2], promotion: move[3]});
//
//   }
// }

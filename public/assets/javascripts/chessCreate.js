// index board
game = new Chess(),
statusEl = $('#status'),
fenEl = $('#fen'),
pgnEl = $('#pgn');
var turn = game.turn();
var stockfish = STOCKFISH();
var evaler = typeof STOCKFISH === "function" ? STOCKFISH() : new Worker(options.stockfishjs || 'stockfish.js');

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
  prepareMove();
  updateStatus();
  // AJAX request for games in DB.
  var moves = game.moves();
  var game_pgn = game.pgn();
  var turn = game.turn();
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
  var status = 'Engine: ';
  if(!engineStatus.engineLoaded) {
      status += 'loading...';
  } else if(!engineStatus.engineReady) {
      status += 'loaded...';
  } else {
      status += 'ready.';
  }
  status += ' Book: ' + engineStatus.book;
  if(engineStatus.search) {
      status += '<br>' + engineStatus.search;
      if(engineStatus.score && displayScore) {
          status += ' Score: ' + engineStatus.score;
      }
  }
  $('#engineStatus').html(status);
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

stockfish.onmessage = function(event) {
  // console.log(event.data ? event.data : event);
  var line;
  if (event && typeof event === "object") {
     line = event.data;
  } else {
     line = event;
  }
  /// Ignore some output.
  if (line === "uciok" || line === "readyok" || line.substr(0, 11) === "option name") {
     return;
  } else if (line.indexOf("depth") >= 0) {
    return;
  } else if (line.indexOf("nodes") >= 0) {
    return;
  }

  var turn = game.turn()
  var move = event.match(/^bestmove ([a-h][1-8])([a-h][1-8])([qrbk])?/);
  if (typeof move !== null) {
    console.log("engine: " + line);
    console.log("gameturn: " + turn);

    console.log("best moveees " + move)
    // game.move({from: move[1], to: move[2]});
  }

  if (turn == 'b') {
    // console.log('stylin', move)
    game.move({from: move[1], to: move[2], promotion: move[3]});
    board.move(move[1] + '-' + move[2]);
  // console.log('AAA', line);
  // line = event.data;
  // console.log('bbb', line);
  }
};
function get_moves()
{
    var moves = '';
    var history = game.history({verbose: true});

    for(var i = 0; i < history.length; ++i) {
        var move = history[i];
        moves += ' ' + move.from + move.to + (move.promotion ? move.promotion : '');
    }

    return moves;
};

function uciCmd(cmd) {
    stockfish.postMessage(cmd);
};
uciCmd('uci');

function prepareMove() {
    $('#pgn').text(game.pgn());
    board.position(game.fen());
    var turn = game.turn() == 'w' ? 'white' : 'black';
    if(!game.game_over()) {
      if(turn = 'b') {
          uciCmd('position startpos moves' + get_moves());
          // evaluation_el.textContent = "";
          uciCmd('go depth 10');
      };
    };
};

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

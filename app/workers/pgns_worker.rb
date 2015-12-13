class PgnsWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(pgn_id)
    pgn = Pgn.find(pgn_id)
    path = pgn.pgn.current_path
    games = File.open(path)
    unparsed_games = games.read
    # split uploaded file based on games (3 newline breaks from Chess.com)
    split_games = unparsed_games.split(/\r\n\r\n\r\n/)

    # ((?<=White )"\w{3,15}")
    # ((?<=Black )"\w{3,15}")
    split_games.each do |game|
      # split game notation from rest of PGN info, add spaces to normalize data, remove extra line breaks.
      white = game.scan(/(?<=White )"\w{3,15}"/)
      black = game.scan(/(?<=Black )"\w{3,15}"/)
      puts white
      player1 = Player.find_or_create_by(name: white, rating: 1000)
      puts player1.name
      player2 = Player.find_or_create_by(name: black, rating: 1000)
      player1.save
      player2.save
      game_notation = game.split(/\r\n\r\n/).pop
      game_notation.gsub!(/(\d+\.)/, '\1 ')
      game_notation.gsub!(/\r\n/, '')
      puts game_notation
      game = Game.new
      game = Game.new(notation: game_notation)
      game.players.push(player1)
      game.save
    end
  end

end
# rough estimate. 1k smallish games of just notation parsed and added -  done: 11.752 sec.

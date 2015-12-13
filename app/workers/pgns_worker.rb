class PgnsWorker
  include Sidekiq::Worker

  def perform(pgn_id)
    pgn = Pgn.find(pgn_id)
    path = pgn.pgn.current_path
    games = File.open(path)
    unparsed_games = games.read
    # split uploaded file based on games (3 newline breaks from Chess.com)
    split_games = unparsed_games.split(/\r\n\r\n\r\n/)
    player = Player.find(1) #this is just a stand in, but creating or finding id's based on name search will be next.
    split_games.each do |game|
      # split game notation from rest of PGN info, add spaces to normalize data, remove extra line breaks.
      game_notation = game.split(/\r\n\r\n/).pop
      game_notation.gsub!(/(\d+\.)/, '\1 ')
      game_notation.gsub!(/\r\n/, '')
      puts game_notation
      game = Game.new
      game = Game.new(notation: game_notation)
      game.players.push(player)
      game.save
    end
  end

end

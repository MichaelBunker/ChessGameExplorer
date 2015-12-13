class PgnsWorker
  include Sidekiq::Worker

  def perform(pgn_id)
    puts pgn_id
    pgn = Pgn.find(pgn_id)
    path = pgn.pgn.current_path
    games = File.open(path)
    unparsed_games = games.read
    split_games = unparsed_games.split(/\r\n\r\n\r\n/)
    puts split_games.last
    player = Player.find(1)
    split_games.each do |game|
      game_notation = game.split(/\r\n\r\n/).pop
      game_notation.gsub!(/(\d+\.)/, '\1 ')
      puts game_notation
      game = Game.new
      game = Game.new(notation: game_notation)
      game.players.push(player)
      game.save
    end
  end

end

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
  end

end

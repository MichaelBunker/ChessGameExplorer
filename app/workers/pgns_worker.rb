class PgnsWorker
  include Sidekiq::Worker

  def perform(pgn_id)
    pgn = Pgn.find(pgn_id)
    puts pgn
    puts "HERE IS PGN"
  end

end

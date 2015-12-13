# This is kind of awkward. but for now, separating adding game by PGN parser, and games played or put in manually is easiest.
class PgnsController < ApplicationController


private
  def pgn_params
    params.require(:pgn).permit(:pgn)
  end

public
  def new
    @pgn = Pgn.new
  end

  def create
    @pgn = Pgn.new(pgn_params)
    if @pgn.save
    # binding.pry
      PgnsWorker.perform_async(@pgn.id)
      redirect_to pgn_path(@pgn)
    else
      flash[:alert] = "Something Went wrong."
      redirect_to new_pgn_path
    end
  end


  def show
    @pgn = Pgn.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
    @players = Player.all
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      flash[:alert] = "PGN can't be blank"
      redirect_to game_path(@game)
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to players_path
  end

end

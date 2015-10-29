class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to players_path
    else
      render :new
    end
  end

private
  def game_params
    params.require(:game).permit(:notation)
  end
end

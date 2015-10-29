class GamesController < ApplicationController

  def new
    @players = Player.all
    @game = Game.new
  end

  def create
    @players = Player.all
    @game = Game.new(game_params)
    players = params[:Player]
    players.each do |player|
    binding.pry
      @player = Player.new(name: player[0], rating: player[1])
      @player.save
      @game.players.push(@player)
    end
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to players_path
  end

private
  def game_params
    params.require(:game).permit(:notation)
  end

  def player_params
    params.permit(:Player)
  end
end

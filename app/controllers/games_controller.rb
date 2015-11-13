class GamesController < ApplicationController

  def new
    @players = Player.all
    @game = Game.new
  end

  def create
    @players = Player.all
    @game = Game.new(game_params)
    players = Player.find(params[:player_ids])
    players.each do |player|
      @game.players.push(player)
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
    params.require(:game).permit(:notation, :player_id)
  end
end

class GamesController < ApplicationController

  def new
    @players = Player.all
    @game = Game.new
  end

  def create
    @players = Player.all
    @game = Game.new(game_params)
    if @game.save
      players = params[:Player]
      players.each do |player|
        @game.players.create(name: name, game_id: game_id)
      redirect_to game_path(@game)
    else
      render :new
    end
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
end

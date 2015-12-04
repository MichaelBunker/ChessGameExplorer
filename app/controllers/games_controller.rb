class GamesController < ApplicationController

  def new
    @players = Player.all
    @game = Game.new
  end

  def create
    @players = Player.all
    @game = Game.new(game_params)
    if params[:player_ids]
      players = Player.find(params[:player_ids])
      players.each do |player|
        @game.players.push(player)
      end
    else
      @game = Game.new({notation: ""})
    end
    if @game.save
      redirect_to game_path(@game)
    else
      flash[:alert] = "Games must have a PGN and a player selected."
      redirect_to new_game_path
    end
  end


  def show
    @game = Game.find(params[:id])

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

private
  def game_params
    params.require(:game).permit(:notation, :player_id)
  end
end

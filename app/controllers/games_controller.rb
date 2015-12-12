class GamesController < ApplicationController
  respond_to :js, :json, :html

  def new
    @players = Player.all
    @game = Game.new
  end

  def create
    @players = Player.all
    @game = Game.new(game_params)
    @game.pgn = game_params[:file]
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
    respond_with do |format|
      format.html do
        @game = Game.find(params[:id])
        unless @game.update(game_params)
          flash[:alert] = "PGN can't be blank"
          puts 'game update section'
          redirect_to game_path(@game)
        end
        format.js do
          @game = Game.find(params[:gameNum])
          @game.notation = params[:gameNotation]
          puts 'pgn format response'
          render nothing: true
        end
      end
    end
  end
    #
    # respond_to do |format|
    #   format.js do
    #     # binding.pry
    #     @game = Game.find(params[:gameNum])
    #     @game.notation = params[:gameNotation]
    #     puts 'pgn format response'
    #     render nothing: true
    #   end
    # end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to players_path
  end

private
  def game_params
    params.permit(:notation, :player_id, :pgn)
  end
end

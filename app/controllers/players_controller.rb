class PlayersController < ApplicationController

  before_action :authenticate_user!
  respond_to :js, :json, :html

  def index
    @user = current_user
    @players = Player.all
    pgn = params[:game_pgn]
    # ('keywords LIKE ?', '%crescent%').all
    # @games = Game.where("notation = '#{pgn}'")
    @games = Game.where("notation LIKE ?", "%#{pgn}%")
    respond_with do |format|
      format.html
      format.json { render :json => @games }
    end
    # @moves = params[:moves]
    # @moves.each do |move|
    #   result = Game.where("notation like ?", "%1. e4%")
    # end
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_path(@player)
    else
      render :new
    end
  end

  def show
    @player = Player.find(params[:id])
    @games = @player.games.all
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to player_path(@player)
    else
      render :edit
    end
  end

  def destroy
    player = Player.find(params[:id])
    player.destroy
    redirect_to players_path
  end


private
  def player_params
    params.require(:player).permit(:name, :rating)
  end

end

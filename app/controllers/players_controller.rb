class PlayersController < ApplicationController

  before_action :authenticate_user!
  respond_to :js, :json, :html

  private
    def player_params
      params.require(:player).permit(:name, :rating)
    end

  public
  def index
    # refactor this into something respectable
    @user = current_user
    @players = Player.all
    pgn = params[:game_pgn]
    moves = params[:moves]
    turn = params[:turn]
    if moves
      @games = Game.where("notation LIKE ?", "#{pgn}%")
      @moves_a = []
      # adds space and move number to pgn to allow for DB searching.
      if turn == 'w'
        number = pgn.scan(/\d\./)
        convert = number.last.to_i
        addToGame = convert + 1
        newStringNum = addToGame.to_s
        pgn.concat(" " + newStringNum + ".")
      end
      moves.each do |move|
          number = @games.where("notation LIKE ?", "#{pgn} #{move}%")
        if number == 0
          @moves_a << 0
        else
          @moves_a << number.length
        end
      end
      respond_with do |format|
        format.html

        format.json do
          render json: {
            moves: moves,
            next_move: @moves_a
          }.to_json
        end
      end
    end
  end

  def new
    @player = Player.new
    @players = Player.all
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to player_path(@player)
    else
      flash[:alert] = "All Fields must be filled in."
      render :index
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

end

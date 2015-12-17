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
    win_cons = ['1-0','0-1','½–½']
    white_win = "1-0"
    black_win = "0-1"
    draw = "1/2-1/2"
    if moves
      @games = Game.where("notation LIKE ?", "#{pgn}%")
      @moves_a = []
      @white_wins = []
      @black_wins = []
      @draws = []
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
        if number.length > 0
          white_wins = @games.where("notation LIKE ? AND notation LIKE ?", "#{pgn} #{move}%", "%#{white_win}%")
          black_wins = @games.where("notation LIKE ? AND notation LIKE ?", "#{pgn} #{move}%", "%#{black_win}%")
          draws      = @games.where("notation LIKE ? AND notation LIKE ?", "#{pgn} #{move}%", "%#{draw}%")
          @white_wins << white_wins.length
          @black_wins << black_wins.length
          @draws << draws.length
          @moves_a << number.length
        else

        end
      end
      # binding.pry
      respond_with do |format|
        format.html

        format.json do
          render json: {
            moves: moves,
            white_wins: @white_wins,
            black_wins: @black_wins,
            draws: @draws,
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

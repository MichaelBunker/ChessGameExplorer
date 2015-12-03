class PlayersController < ApplicationController

  before_action :authenticate_user!
  respond_to :js, :json, :html

  def index
    @user = current_user
    @players = Player.all
    pgn = params[:game_pgn]
    moves = params[:moves]
    if moves
      @games = Game.where("notation LIKE ?", "#{pgn}%")
      @moves_a = []
      if pgn.include?("1. e4")
        if pgn == "1. e4"
          moves.each do |move|
            number = @games.where("notation LIKE ?", "#{pgn} #{move}%")
            if number == 0
              @moves_a << 0
            else
              @moves_a << number.length
            end
          end
        end
        # I think a better solution to all of this might be to pass in which color turn it is. If white's turn, search and add number. Since black will already have it in the string.
        #bug where second move by black is caught in this section.
        # IE. (notation LIKE '1. e4 d5 2. exd5 3. Qxd5%') instead of (notation LIKE '1. e4 d5 2. exd5 Qxd5%')
        number = pgn.scan(/\d\./)
        convert = number.last.to_i
        addToGame = convert + 1
        newStringNum = addToGame.to_s
        pgn.concat(" " + newStringNum + ". ")
        pry
      end
      moves.each do |move|
          number = @games.where("notation LIKE ?", "#{pgn}#{move}%")
        if number == 0
          @moves_a << 0
        else
          @moves_a << number.length
        end
      end
      respond_with do |format|
        format.html
        format.json { render :json => {"moves": moves, "next_move": @moves_a} }
      end
    end
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

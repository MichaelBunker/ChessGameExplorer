class GamesController < ApplicationController

  def new
    @players = Player.all
    @game = Game.new
  end

  ## example
  # def create
  #   @post = Post.find(params[:post_id])
  #   @tag = @post.tags.new(tag_params) #should have find or create instead of new to accomodate same tags.
  #   @post.tags.push(@tag)
  #   if @tag.save
  #     redirect_to post_path(@post)
  #   else
  #     render :new
  #   end
  # end
  # # trying to modify for my purposes
  # def create
  #   players = params[:player]
  #   @game = player.games.new(game_params)
  #   binding.pry
  #   players.each do |player|
  #     @game.players.push(player)
  #   end
  #   @game.save
  #   redirect_to game_path(@game)
  # end
  # ##


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

  # def player_params
  #   params.require(:player).permit(:name, :rating)
  # end

  # Is this messing with how the object is getting dealt with in the form/create method?
  def player_params
    params.permit(:player)
  end
end

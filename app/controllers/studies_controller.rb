class StudiesController < ApplicationController

  def show

  end

  def index
# == on wiki is header, === subheader.
    @response = Wikipedia.find('Pawn_structure')
    # @images = @response.image_urls
    # @images.each do |image|
    @content = @response.text
    # count = @content.scan(/(?=#{"===".downcase()})/).count
    @content.gsub!(/([===])/, "<br>")
  end

  def new
    @study = Study.new
  end

private
  def study_params
    params.require(:study).permit(:name)
  end

end

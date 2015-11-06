class StudyController < ApplicationController

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
    # binding.pry

  end

end

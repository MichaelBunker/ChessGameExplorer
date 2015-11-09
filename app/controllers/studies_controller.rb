class StudiesController < ApplicationController

  def show
    @study = Study.find(params[:id])
    name = @study.name
    @study_info = Wikipedia.find(name)
    @study_page = @study_info.text
    @study_page.gsub!(/([===])/, "<br>")
  end

#   def index
# # == on wiki is header, === subheader.
#     @response = Wikipedia.find('Pawn_structure')
#     # @images = @response.image_urls
#     # @images.each do |image|
#     @content = @response.text
#     # count = @content.scan(/(?=#{"===".downcase()})/).count
#     @content.gsub!(/([===])/, "<br>")
#   end

  def new
    @study = Study.new
  end

  def create
    @study = Study.create(study_params)
    redirect_to study_path(@study)
  end

private
  def study_params
    params.require(:study).permit(:name)
  end

end

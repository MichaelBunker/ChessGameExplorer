class StudiesController < ApplicationController

  def show
    @study = Study.find(params[:id])
    name = @study.name
    @study_info = Wikipedia.find(name)
    @study_page = @study_info.text
    # == on wiki is header, === subheader.
    @study_page.gsub!(/([===])/, "<br>")
  end

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

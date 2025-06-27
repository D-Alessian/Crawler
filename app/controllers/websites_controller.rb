class WebsitesController < ApplicationController
  def show
    @website = Website.find(params[:id])
    @diff = @website.diff
    authorize :project, :index?
  end
end

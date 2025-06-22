class WebsitesController < ApplicationController

  before_action :set_website, only: [:show, :edit, :update, :destroy]
  def index
    @websites = Website.order(last_change: :desc)
    @websites = policy_scope(Website)
  end

  def new
    @website = Website.new
    @website.key_actors.build
    @website.hyperlinks.build
    authorize @website
  end

  def create
    @website = Website.new(article_params)
    if @website.save
      redirect_to @website, notice: 'Website was successfully created.'
    else
      flash.now[:alert] = 'Error creating website.'
      render :new
    end
    authorize @website
  end

  def show
    authorize @website
  end

  def edit
    authorize @website
  end

  def update
    authorize @website
  end

  def destroy
    @website.destroy
    authorize @website
  end

  def article_params
    params.require(:website).permit(:url, :country, :website_type, :size, :name, :status, :start_date, key_actors_attributes: [:id, :name, :_destroy], hyperlinks_attributes: [:id, :url, :_destroy])
  end

  private
  def set_website
    @website = Website.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to websites_path, alert: 'Website not found.'
  end
end

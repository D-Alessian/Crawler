class CrawlConfigsController < ApplicationController
  before_action :set_config, only: [:edit, :update]

  def edit
    authorize @config
  end

  def update
    authorize @config
    if @config.update(crawl_config_params)
      redirect_to edit_crawl_config_path, notice: "Config saved."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_config
    @config = CrawlerConfig.first_or_create!(
      time_of_day: '09:00', regularity_days: 1, sender_email: "crawler@no-reply.com"
    )
  end

  def crawl_config_params
    params.require(:crawler_config)
          .permit(:time_of_day, :regularity_days, :sender_email)
  end
end

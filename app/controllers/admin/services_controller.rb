class Admin::ServicesController < ApplicationController
  def run_notifier
    authorize :services, :scan?
    Crawler::Notifier.main 
    redirect_to admin_path, notice: 'Notifier has been run successfully.'
  rescue => e
    redirect_to admin_path, alert: "Error: #{e.message}"
  end

  def run_comparison
    authorize :services, :scan?
    Crawler::Processor.compare_all
    redirect_to admin_path, notice: 'Comparison has been run successfully.'
  rescue => e
    redirect_to admin_path, alert: "Error: #{e.message}"
  end
end

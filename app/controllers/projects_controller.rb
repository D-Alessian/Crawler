class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  def index
    @projects = Project.order(last_change: :desc)
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new
    @project.key_actors.build
    @project.hyperlinks.build
    Website.website_types.keys.each do |type|
      @project.websites.build(website_type: type)
    end
    authorize @project
  end

  def create
    @project = Project.new(article_params)
    if @project.save
      Crawler::Processor.first_seed(@project)
      redirect_to @project, notice: 'Project was successfully created.'
    else
      flash.now[:alert] = 'Error creating project.'
      render :new
    end
    authorize @project
  end

  def show
    @project = Project.find(params[:id])
    @project_page = @project.websites.find_by(website_type: :projects)
    @linkedin_page = @project.websites.find_by(website_type: :linkedin)
    @jobs_page = @project.websites.find_by(website_type: :jobs)
    @news_page = @project.websites.find_by(website_type: :news)
    authorize @project
  end

  def edit
    @project = Project.find(params[:id])
    existing = @project.websites.map(&:website_type)
    (Website.website_types.keys - existing).each do |type|
      @project.websites.build(website_type: type)
    end
    authorize @project
  end

  def update
    authorize @project
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
    authorize @project
  end

  def import_form
    @project = Project.new
    authorize @project
  end

  def import_csv
    file = params[:csv_file]
    if file.nil?
      redirect_to import_form_projects_path, alert: "Please choose a CSV file."
      return
    end

    result = Project.import_from_csv(file.path)
    if result[:errors].any?
      redirect_to import_form_projects_path,
                  alert: "Imported with errors on rows: #{result[:errors].join(', ')}"
    else
      redirect_to projects_path,
                  notice: "Successfully imported #{result[:count]} records."
    end
    authorize Project
  end

  def article_params
    params.require(:project).permit(:country, :size, :name, :status, :date_started_tracking, :is_member, :is_seeded, websites_attributes: [:id, :url, :body, :digest, :website_type, :_destroy], key_actors_attributes: [:id, :name, :_destroy], hyperlinks_attributes: [:id, :url, :_destroy])
  end

  private
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to projects_path, alert: 'Project not found.'
  end
end

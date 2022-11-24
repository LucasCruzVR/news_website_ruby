class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show update destroy]

  def index
    @publications = Publication.all
  end

  def show; end

  def create
    @publication = Publication.new(publication_params)
    AwsRequests::DeleteImageAwsService.call(publication: @publication)
    if publication_params[:image_file].present?
      @publication.image = AwsRequests::SendImageAwsService.call(publication: @publication,
                                                                 image_file: publication_params[:image_file])
    end
    if @publication.save
      render :show, status: :created
    else
      AwsRequests::DeleteImageAwsService.call(publication: @publication)
      render json: @publication.errors.messages, status: 422
    end
  end

  def update
    if @publication.update(publication_params)
      render :show, status: 200
    else
      render json: @publication.errors.messages, status: 422
    end
  end

  def destroy
    if @publication.destroy
      head :ok
    else
      render json: @publication.errors.messages, status: 422
    end
  end

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def publication_params
    params.permit(:title, :title_description, :content, :image_file, :category_id)
  end
end

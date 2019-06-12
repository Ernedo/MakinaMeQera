class PhotosController < ApplicationController
  before_action :set_photo, only: [ :edit, :update, :destroy, :show]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    # if current_user.admin?
      @photos = Photo.all
    # else
    #   @photos = Photo.where(user_id: current_user.id)
    # end
  end

  def show
  end

  def new
    @photo = Photo.new
  end
  def edit

  end

  def create
    Rails.logger.info "Params: #{photo_params}"
    @photo = Photo.new(photo_params)
    @photo.assign_attributes(user_id: current_user.id)
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }

      else
        format.html { render :edit }

      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }

    end
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end


    def photo_params
      params.require(:photo).permit(:image)
    end
end

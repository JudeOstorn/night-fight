class PhotosController < ApplicationController

def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new

  end

  def create
    @photo = Photo.new(photo_params)#(params[:photo].permit(:image, :title))
    if @photo.save
      flash[:success] = "Photo saved!"
     redirect_to photos_path
    else
      render 'new'
    end
  end


  def show
    @photo = Photo.find(params[:id])
  end


def destroy
  @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photo_path
  
=begin
@photo.destroy
respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
=end
end



  private

  def photo_params
    params.require(:photo).permit(:image, :title)
  end

end

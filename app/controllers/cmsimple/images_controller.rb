module Cmsimple
  class ImagesController < Cmsimple.configuration.parent_controller.constantize

    self.responder = Cmsimple::ApiResponder

    respond_to :json, :html
    layout 'panel'

    def index
      @images = Image.all
      respond_with @images
    end

    def new
      @image = Image.new
      respond_with @image
    end

    def create
      @image = Image.new(image_params)
      @image.save
      if request.xhr?
        render json: {url: @image.attachment.url}
      else
        respond_with @image, location: new_image_path
      end
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      respond_with @image
    end

    private

    def image_params
      whitelisted = [:attachment, :title]
      params.require(:image).permit(*whitelisted)
    end

  end
end

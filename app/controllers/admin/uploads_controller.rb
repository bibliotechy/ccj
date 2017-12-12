module Admin
  class UploadsController < Admin::ApplicationController



    def create
      upload = Upload.new(upload_params)
      upload.file = upload_params[:file]
      upload.process_upload
      if upload.save
        redirect_to(
          [namespace, upload],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, upload),
        }
end
    end

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Upload.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Upload.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

  private

    def upload_params
      params.require(:upload).permit(:file)
    end
  end
end

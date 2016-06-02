module Admin
  class UsersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.all.paginate(10, params[:page])
    # end
    #
    # if admin create user the password will be generated and send mail to user.
    def create
      generated_password = Devise.friendly_token.first(8)
      user = User.create!(
        first_name: resource_params[:first_name], last_name: resource_params[:last_name],
        email: resource_params[:email], password: generated_password)
      if user
        UserMailer.welcome_new_user(user, generated_password).deliver_now
        redirect_to(
          [namespace, user],
          notice: translate_with_resource("create.success")
        )
      else
         render :new, page: Administrate::Page::Form.new(dashboard, user)
      end
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end

module Admin
  class UsersController < Admin::ApplicationController
    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(resource_resolver, search_term).run
      resources = resources.order(:id).page(params[:page]).per(records_per_page)
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
        resources: resources,
        search_term: search_term,
        page: page,
      }
    end

    # if admin creates a user the password will be generated and email
    # sent to user.
    def create
      generated_password = Devise.friendly_token.first(8)
      user = User.create!(
        first_name: resource_params[:first_name],
        last_name: resource_params[:last_name],
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

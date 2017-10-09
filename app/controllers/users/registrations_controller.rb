class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super { render :quick_new and return if params[:type] == 'quick' }
  end

  # POST /resource
  def create
    super do |resource|
      if params[:quick_sign_up] == 'true'
        resource.skip_password_validations!
        unless resource.save
          flash[:alert] = t('.wrong_email')
          redirect_to new_user_registration_path(type: :quick) and return
        end
      end
    end
  end

  # DELETE /resource
  def destroy
    if params[:destroying_confirmation]
      super
    else
      redirect_to edit_user_registration_path, alert: t('.confirm_destroying')
    end
  end

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      billing_address_attributes:  Address::FIELDS,
      shipping_address_attributes: Address::FIELDS
    ])
  end

  def update_resource(resource, params)
    if params[:password].present?
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def after_sign_up_path_for(resource)
    if params[:quick_sign_up] == 'true'
      checkout_index_path
    else
      after_sign_in_path_for(resource)
    end
  end
end

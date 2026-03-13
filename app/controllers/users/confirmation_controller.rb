# frozen_string_literal: true

class Users::ConfirmationController < Devise::ConfirmationsController
   # GET /resource/confirmation/new
   def new
     super
    end

   # POST /resource/confirmation
   def create
     super
    end

   # GET /resource/confirmation?confirmation_token=abcdef
   def show
     self.resource = resource_class.confirm_by_token(params[:confirmation_token])
     if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      sign_in(resource_name, resource)
      redirect_to root_path
     else
      redirect_to new_user_session_path, alert: "Invalid URL or expired confirmation token."
     end
    end

   protected

   # The path used after resending confirmation instructions.
   # def after_resending_confirmation_instructions_path_for(resource_name)
   # super(resource_name)
   # end

   # The path used after confirmation.
   # def after_confirmation_path_for(resource_name, resource)
   # super(resource_name, resource)
   # end

   def after_confirmation_path_for(resource_name, resource)
      root_path
    end
end

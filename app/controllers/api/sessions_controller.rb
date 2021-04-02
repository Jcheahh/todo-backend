class Api::SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      token = current_user.generate_jwt
      render json: { token: token }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

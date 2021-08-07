class Api::SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:validate_token]

  def create
    user = User.find_by_email!(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      token = current_user.generate_jwt
      render json: { token: token, user: current_user }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def validate_token
    render json: current_user
  end
end

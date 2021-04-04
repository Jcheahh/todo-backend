class Api::RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)

    if user.save
      token = user.generate_jwt
      render json: { token: token }
    else
      # TODO: user.errors.full_messages
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

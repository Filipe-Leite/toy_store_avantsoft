class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :register]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def register
  
  user = User.new(email: params[:email], password: params[:password])
  
  if user.save
    token = JsonWebToken.encode(user_id: user.id)
    @user = User.find(user.id)
    render json: @user, status: :created
  else
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  end
end
end
class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login, :register]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      @user = User.find(user.id)

      render json: { 
                    token: token,
                    user: {
                      id: @user.id,
                      email: @user.email
                    }
      }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def register
  
    user = User.new(email: params[:email], password: params[:password])
    
    if user.save
      token = JsonWebToken.encode(user_id: user.id)

      render json: @user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def validate_token
    auth_header = request.headers['Authorization']
    
    if auth_header.blank?
      return render json: { valid: false, error: 'Token não fornecido' }, status: :bad_request
    end

    token = auth_header.split(' ').last
    
    begin
      decoded = JsonWebToken.decode(token)
      user = User.find(decoded[:user_id])
      
      render json: { 
        valid: true,
        user: {
          id: user.id,
          email: user.email
        }
      }, status: :ok
      
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { 
        valid: false,
        error: 'Token inválido ou expirado'
      }, status: :unauthorized
    end
  end
end
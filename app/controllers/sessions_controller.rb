# File: app/controllers/sessions_controller.rb

class SessionsController < ApplicationController
  # Ensure user is logged in for certain actions if required
  before_action :require_login, only: [:authenticated, :destroy]

  # POST /sessions
def create
  if params[:user].nil? || params[:user][:username].nil? || params[:user][:password].nil?
    render json: { error: 'Invalid username or password parameters' }, status: :unprocessable_entity
    return
  end

  @user = User.find_by(username: params[:user][:username])

  if @user&.authenticate(params[:user][:password])
    session_record = @user.sessions.create
    cookies.permanent.signed[:todolist_session_token] = {
      value: session_record.token,
      httponly: true
    }
    render json: { success: true }, status: :created  # Ensure status is :created
  else
    render json: { error: 'Invalid username or password' }, status: :unauthorized
  end
end


  # GET /authenticated
  def authenticated
    token = cookies.permanent.signed[:todolist_session_token]
    session_record = Session.find_by(token: token)

    if session_record
      @user = session_record.user
      render json: {
        authenticated: true,
        username: @user.username
      }
    else
      render json: { authenticated: false }
    end
  end

  # DELETE /sessions
def destroy
  token = cookies.permanent.signed[:todolist_session_token]
  session_record = Session.find_by(token: token)

  if session_record && session_record.destroy
    cookies.delete(:todolist_session_token)
    head :no_content  # Ensure response is :no_content
  else
    render json: { error: 'Failed to log out' }, status: :unprocessable_entity
  end
end
  private

  def current_user
    token = cookies.permanent.signed[:todolist_session_token]
    session_record = Session.find_by(token: token)
    @current_user ||= session_record&.user
  end

  def require_login
    unless current_user
      render json: { error: 'Must be logged in' }, status: :unauthorized
    end
  end
end


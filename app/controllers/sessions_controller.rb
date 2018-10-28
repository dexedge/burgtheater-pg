# Code for users and sessions is based on the Gist:
# https://gist.github.com/iscott/4618dc0c85acb3daa5c26641d8be8d0d
# supplemented by GoRails video 80:
# https://youtu.be/85CbiZYa3l0

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:login][:username])

    # Verify user exists in db and run has_secure_password's .authenticate() 
    # method to see if the password submitted on the login form was correct: 
    if user && user.authenticate(params[:login][:password]) 
      # Save the user.id in that user's session cookie:
      session[:user_id] = user.id.to_s
      redirect_to params[:redirect_to], notice: 'Logged in'
    else
      # if username or password incorrect, re-render login page:
      render :new, notice: 'Username or password incorrect'
    end
  end
  
  def destroy
    # delete the saved user_id key/value from the cookie:
    session.delete(:user_id)
    redirect_to params[:redirect_to], notice: 'Logged out'
  end
end

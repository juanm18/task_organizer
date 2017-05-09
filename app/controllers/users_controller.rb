class UsersController < ApplicationController
  def login
    if request.post?
      user = User.find_by ({username: params[:username], password: params[:password]})

      puts "************"
      puts user
      puts "************"
      unless user
        flash[:loginError] = 'Incorrect login information'
        redirect_to '/'
      else
        session[:id] = user.id
        session[:username] = user.username
        redirect_to '/tasks'
      end
    end
  end

  def new
  end

  def create
    @user = User.new(user_params)
    @user.save
    puts "**********"
    puts @user.errors.full_messages
    puts "**********"
    if @user.errors.any? == true
      flash[:userError] = @user.errors.full_messages
      redirect_to '/'
    else
      session[:id]= @user.id
      session[:name] = @user.username
      redirect_to '/tasks'
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def login_params
    params.require(:user).permit(:username, :password)
  end
end

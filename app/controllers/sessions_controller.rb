class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Successfully logged in."
        redirect_to "/posts"
      else
        flash["notice"] = "Incorrect password."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "You have logged out."
    redirect_to "/login"
  end
end
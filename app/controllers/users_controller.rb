class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create 
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to root_url, :notice => "Thanks! Your account has been submitted to Amrit for approval. "
  	else
  		render 'new'
  	end
  end

  def edit
    @users = User.where(:approved => false)
  end

  def update 
    @users = User.where(:approved => false)
    @users.update_all({:approved => true}, {:id => params[:user_ids]})
    flash[:notice] = "Approved users!"
    redirect_to admin_path
  end
end
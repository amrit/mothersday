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

  # def foursquare
  #   client = OAuth2::Client.new(
  #   "KLZRLZMEQJRUP511S5PJPLGZ4DJYFRRKCABAFFYCO4K3EIF",
  #   "1WW3ZMV5QZAZ3GCVJHJUDWL3SLGBTBLAMNRDBFXYSWSOCHMC", 
  #   :authorize_url => "/oauth2/authorize", 
  #   :token_url => "/oauth2/access_token", 
  #   :site => "https://foursquare.com/"
  #   )

  #   puts client.auth_code.authorize_url(:redirect_uri => "http://localhost:3000/foursquare")

  #   code = gets.chomp

  #   token = client.auth_code.get_token(code, :redirect_uri => "http://localhost:3000/foursquare")

  #   token = OAuth2::AccessToken.new(client, token.token, {
  #     :mode => :query,
  #     :param_name => "oauth_token",
  #   })

  #   @response = token.get('https://api.foursquare.com/v2/users/self/checkins')


  # end
end
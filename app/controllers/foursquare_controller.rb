class FoursquareController < ApplicationController
	protect_from_forgery :except => 'post'


	def connect
		@foursquare = Foursquare::Base.new("YKLZRLZMEQJRUP511S5PJPLGZ4DJYFRRKCABAFFYCO4K3EIF", "VAQMIJPU2BGFMPIFCY5GRHIM0PH04EAS2B44H52ENQOOGTXZ")
		redirect_to @foursquare.authorize_url("http://localhost:3000/foursquare/callback")
	end

	def callback
		@foursquare = Foursquare::Base.new("YKLZRLZMEQJRUP511S5PJPLGZ4DJYFRRKCABAFFYCO4K3EIF", "VAQMIJPU2BGFMPIFCY5GRHIM0PH04EAS2B44H52ENQOOGTXZ")
		access_token = @foursquare.access_token(params["code"], "http://localhost:3000/foursquare/callback")
		redirect_to root_path
	end


	def post
  	checkin_hash = JSON.parse(params[:checkin])
  	user_hash = JSON.parse(params[:user])
    
    # Look up the user based on foursquare ID
    user = User.find_by_email("slicekick@gmail.com")
 
  	if checkin_hash["shout"].include? "#mom"
  		@location = checkin_hash["venue"]["name"]
  		user.location = @location
  		if user.save
  			
  	end
  	render :nothing => true
	end

end
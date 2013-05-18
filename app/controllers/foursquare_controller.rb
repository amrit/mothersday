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
  	
    
    
    user = User.find_by_email("slicekick@gmail.com")
    approved_users = User.where(:approved => true)
    numbers_array = approved_users.map! &:phone_number
 
  	if checkin_hash["shout"].include? "#mom"
  		@location = checkin_hash["venue"]["name"]
  		user.location = @location
  		if user.save
  			#number_to_send_to = "(424)234-9577"
				
				twilio_sid = "AC2ec5fa1768f45bef44fb03a9a2255406"
				twilio_token = "ad3c0183666b730f2f72615fc61ebc1a"
				twilio_phone_number = "(847)737-3174"

				@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
				numbers_array.each do |number|
					@twilio_client.account.sms.messages.create(
						:from => "+1#{twilio_phone_number}",
						:to => number, 
						:body => "Hey there! Amrit's just arrived at #{@location}, safe and sound!")
					end
				end
			end
  	render :nothing => true
	end

end
class SendTextController < ApplicationController
	def index
	end

	def send_text_message
		number_to_send_to = User.phone_number
		location = User.location

		twilio_sid = "AC2ec5fa1768f45bef44fb03a9a2255406"
		twilio_token = "ad3c0183666b730f2f72615fc61ebc1a"
		twilio_phone_number = "(847)737-3174"

		@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

		@twilio_client.account.sms.messages.create(
			:from => "+1#{twilio_phone_number}",
			:to => number_to_send_to, 
			:body => "Hey there! Amrit's just arrived at #{location}.")
	end
end

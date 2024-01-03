class SmsMessagesController < ApplicationController
  def index
    @messages = SmsMessage.all.order(created_at: :desc).page(params[:page])
  end
end

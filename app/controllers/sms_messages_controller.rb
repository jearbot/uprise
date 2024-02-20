class SmsMessagesController < ApplicationController
  def index
    @messages = SmsMessage.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @options = [ { "volunteers" => "All Volunteers", "students" => "All Students" } ]
  end

  def create
    BulkMessageSenderJob.perform_async(create_params[:member_scope], create_params[:message])
    flash[:success] = "Message sent!"

    redirect_to action: :new
  end

  private

  def create_params
    params.require(:sms_message).permit(:member_scope, :message)
  end
end

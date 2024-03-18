class Callbacks::Twilio::MessageReceiverController < Callbacks::BaseController
  STOP_PHRASES = ["STOP", "STOPALL", "UNSUBSCRIBE", "CANCEL", "END", "QUIT"]
  START_PHRASES = ["START", "YES", "UNSTOP", "SUBSCRIBE", "RESUME"]

  before_action :validate_twilio_request, only: [:create]

  def create
    body = create_params[:Body].upcase
    member = Member.unscoped.find_by(normalized_phone_number: create_params[:From])

    unless member
      return
    end

    # TODO: Refactor this to allow this to receive a message from a member regarding their attendance

    if START_PHRASES.include?(body)
      Member.find_by(normalized_phone_number: create_params[:From])&.resubscribe
      MessageReceiverJob.perform_async(create_params[:From])
    elsif STOP_PHRASES.include?(body)
      Member.find_by(normalized_phone_number: create_params[:From])&.unsubscribe
    end

    SmsMessage.create!(
      from_number: create_params[:From],
      to_number: create_params[:To],
      outbound: false,
      message_sid: create_params[:SmsMessageSid],
      delivery_status: create_params[:SmsStatus],
      segment_count: create_params[:NumSegments],
      message_body: create_params[:Body],
    )

    head :ok
  end

  def status
    binding.pry
    render plain: "Not implemented", status: :not_implemented
  end

  private

  def validate_twilio_request
    twilio_auth_token = ENV['TWILIO_AUTH_TOKEN']
    validator = Twilio::Security::RequestValidator.new(twilio_auth_token)
    begin
      twilio_signature = request.headers['X-Twilio-Signature']
      unless validator.validate(
        request.original_url,
        request.request_parameters,
        twilio_signature
      )
        render plain: "Unauthorized", status: :unauthorized
      end
    rescue NoMethodError
      render plain: "Bad Request", status: :bad_request
    end
  end

  def create_params
    params.permit(:SmsMessageSid, :SmsStatus, :MessagingServiceSid, :NumSegments, :Body, :AccountSid, :From, :To)
  end

  def update_params
    # params.permit(:MessageSid, :SmsStatus, :MessageStatus, :To, :MessageSid, :AccountSid, :From, :ApiVersion)
  end
end

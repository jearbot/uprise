class CalendarService
  require 'google-apis-calendar_v3'
  require 'googleauth'

  def self.refresh_token
    calendar = Google::Apis::CalendarV3::CalendarService.new
    calendar.authorization = Google::Auth::UserRefreshCredentials.new(
      client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
      refresh_token: Token.last.refresh_token,
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR
    )

    response = calendar.authorization.fetch_access_token!

    if response['access_token']
      expires_at = Time.now + response['expires_in'].to_i.seconds

      Token.create!(
        expires_in: response['expires_in'],
        granted_scopes: response['granted_scopes'],
        refresh_token: Token.last.refresh_token,
        token_type: response['token_type'],
        token: response['access_token'],
        user_id: current_user.id,
        expires_at: expires_at,
      )
    end
  end

  def initialize
    @calendar = Google::Apis::CalendarV3::CalendarService.new

    access_token = Token.last.token
    authorization = Signet::OAuth2::Client.new(access_token: access_token)

    @calendar.authorization = authorization
  end

  def book_event(event, member_id)
    
  end

  def list_events
    current_time = Time.now.in_time_zone('Central Time (US & Canada)')
    end_time = current_time + 2.days
    calendar_id = 'primary'
    response = @calendar.list_events(
      calendar_id,
        max_results: 10,
        single_events: true,
        order_by: 'startTime',
        time_min: current_time.iso8601,
        time_max: end_time.iso8601
    )

    response.items
  end
end
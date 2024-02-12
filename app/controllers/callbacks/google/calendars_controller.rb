class Callbacks::Google::CalendarsController < ApplicationController
  require 'googleauth'
  require 'googleauth/web_user_authorizer'
  require 'googleauth/stores/redis_token_store'
  require 'redis'
  require 'uri'

  before_action :set_auth_uri, only: [:index]

  def index; end

  def oauth2callback
    query_params = URI.parse(request.url).query
    params = URI.decode_www_form(query_params).to_h
    authorization_code = params['code']
    target_url = Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(request)
    client = Signet::OAuth2::Client.new({
      client_id: ENV.fetch('GOOGLE_CLIENT_ID'),
      client_secret: ENV.fetch('GOOGLE_CLIENT_SECRET'),
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: 'http://localhost:3000/google/oauth2callback',
      code: authorization_code
    })

    response = client.fetch_access_token!

    if response['access_token']
      Token.create!(
        expires_in: response['expires_in'],
        granted_scopes: response['granted_scopes'],
        refresh_token: response['refresh_token'],
        token_type: response['token_type'],
        token: response['access_token'],
        user_id: current_user.id,
      )
    else
      flash[:error] = 'Something went wrong, please try again'
    end

    redirect_to target_url
  end

  private

  def set_auth_uri
    client_id = Google::Auth::ClientId.from_file('client_secrets.json')
    scope = [
              'https://www.googleapis.com/auth/calendar.events.owned',
              'https://www.googleapis.com/auth/calendar.events.owned.readonly',
            ]
    token_store = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
    authorizer = Google::Auth::WebUserAuthorizer.new(client_id, scope, token_store, '/google/oauth2callback')
    user_id = 'default'

    @auth_uri = authorizer.get_authorization_url(login_hint: user_id, request: request)
  end
end

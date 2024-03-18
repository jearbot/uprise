class RefreshTokenJob
  include Sidekiq::Worker

  def perform
    CalendarService.refresh_token
  end
end

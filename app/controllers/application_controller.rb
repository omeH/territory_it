class ApplicationController < ActionController::API

  rescue_from StandardError do |exception|
    render json: { errors: [exception] }, status: :internal_server_error
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: [exception] }, status: :unprocessable_entity
  end

  around_action :time_track

  private

  def time_track
    time_tracker = Actions::TimeTracker.instance
    time_tracker.track(request: request) { yield }
  end

end

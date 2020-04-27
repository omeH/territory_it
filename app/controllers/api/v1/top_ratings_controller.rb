module Api
  module V1
    class TopRatingsController < ApplicationController

      def index
        presenter = TopRatings::Presenter.new(limit: params[:limit])
        render json: presenter.gather, status: :ok
      end

    end
  end
end

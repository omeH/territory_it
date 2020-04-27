module Api
  module V1
    class RatingsController < ApplicationController

      def update
        updater = Ratings::Updater.new(post_id: params[:id], value: params[:value]).update

        updater.on_success do
          presenter = Ratings::Presenter.new(post: updater.post)
          render json: presenter.gather, status: :ok
        end

        updater.on_fail do
          render json: { errors: updater.errors }, status: :not_found
        end
      end

    end
  end
end

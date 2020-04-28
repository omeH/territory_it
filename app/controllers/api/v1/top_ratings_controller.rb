require 'will_paginate/array'

module Api
  module V1
    class TopRatingsController < ApplicationController

      def index
        presenter = TopRatings::Presenter.new(limit: params[:limit])
        paginate json: presenter.gather, status: :ok
      end

    end
  end
end

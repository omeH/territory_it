require 'will_paginate/array'

module Api
  module V1
    class TopRatingsController < ApplicationController

      def index
        presenter = TopRatings::Finder.new(limit: params[:limit])
        paginate json: presenter.find, status: :ok
      end

    end
  end
end

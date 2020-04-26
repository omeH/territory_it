module Api
  module V1
    class PostsController < ApplicationController

      def create
        creator = Posts::Creator.new(attributes: permitted_attributes).create

        creator.on_success do
          render json: creator.post, status: :ok
        end

        creator.on_fail do
          render json: { errors: creator.errors }, status: :unprocessable_entity
        end
      end

      private

      def permitted_attributes
        params.require(:attributes).permit(:title, :content, :login, :ip)
      end

    end
  end
end

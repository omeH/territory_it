module Api
  module V1
    class AuthorsController < ApplicationController

      def index
        presenter = Authors::Presenter.new(logins: logins)
        paginate json: presenter.gather, except: :id, status: :ok
      end

      private

      def logins
        Array(params.require(:logins))
      end

    end
  end
end

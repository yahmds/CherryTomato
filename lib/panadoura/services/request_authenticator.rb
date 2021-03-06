module Panadoura
  module Services
    class RequestAuthenticator
      def initialize(request, user_repository)
        @request         = request
        @user_repository = user_repository
      end

      def call
        valid_header? && valid_payload?
      end

      def current_user
        @current_user ||= find_current_user
      end

      private

      def valid_header?
        !!@request.env.fetch('HTTP_AUTHORIZATION', '').scan(/Bearer/).flatten.first
      end

      def valid_payload?
        payload && !JWTEncoderDecoder.expired?(payload) && valid_user?
      end

      def valid_user?
        !!find_current_user
      end

      def find_current_user
        @user_repository.find_by_uid(payload['uid'])
      end

      def payload
        @payload ||= JWTEncoderDecoder.decode(access_token)
      end

      def access_token
        @request.env.fetch('HTTP_AUTHORIZATION', '').scan(/Bearer (.*)$/).flatten.last
      end
    end
  end
end

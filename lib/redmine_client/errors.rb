module RedmineClient
  module Errors
    class AccessDeniedException < StandardError
      def to_s
        'Access denied.'
      end
    end

    class ResourceNotFoundException < StandardError
      def to_s
        'Resource not found.'
      end
    end

    class UnprocessableEntityException < StandardError
      def initialize(response)
        @errors = response.parsed_response['errors']
      end

      def to_s
        @errors.join(', ')
      end
    end

    class InternalErrorException < StandardError
      def to_s
        'Internal error'
      end
    end
  end
end

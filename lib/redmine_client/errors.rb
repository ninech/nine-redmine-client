module RedmineClient
  module Errors
    class BaseError < Exception; end
    class MissingParameter < BaseError
      def initialize(parameter)
        super("You need to provide a parameter #{parameter}")
      end
    end
  end
end

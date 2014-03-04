
require "faraday"
require "rack"
require "json"
require "shipping_easy/authenticator"
require "shipping_easy/configuration"
require "shipping_easy/signature"
require "shipping_easy/http"
require "shipping_easy/http/faraday_adapter"
require "shipping_easy/http/request"
require "shipping_easy/http/response_handler"
require "shipping_easy/resources"
require "shipping_easy/resources/base"
require "shipping_easy/resources/order"
require "shipping_easy/resources/cancellation"
require "shipping_easy/version"

module ShippingEasy

  class << self

    attr_accessor :configuration

    def configure
      configuration = ShippingEasy::Configuration.new
      yield(configuration)
      self.configuration = configuration
    end

    def api_secret
      configuration.api_secret
    end

    def api_key
      configuration.api_key
    end

    def base_url
      configuration.base_url
    end
  end

  class Error < StandardError; end
  class ResourceNotFoundError < Error; end
  class InvalidRequestError < Error; end
  class RequestExpiredError < Error
    def initialize(msg = "The request has expired.")
      super(msg)
    end
  end

  class AccessDeniedError < Error
    def initialize(msg = "Access denied.")
      super(msg)
    end
  end

  class TimestampFormatError < Error
    def initialize(msg = "The API timestamp could not be parsed.")
      super(msg)
    end
  end
end

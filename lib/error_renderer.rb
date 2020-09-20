# frozen_string_literal: true

module ErrorRenderer
  extend ActiveSupport::Concern
  included do
    def render_error(obj, status)
      render(**get_error(obj, status))
    end

    def get_error(obj, status)
      prefix = "#{controller_name}.#{action_name}"
      if obj.is_a? Exception
        details = obj.class.to_s.gsub(/[^\w]/, '_').downcase
        extra = obj.to_s
        details = "#{details}.#{extra[1..-1]}" if extra[0] == '~'
        { json: { error: "#{prefix}.#{details}", details: [], description: extra }, status: status }
      elsif obj.is_a?(ApplicationRecord) || obj.respond_to?(:get_simple_errors)
        { json: { error: "#{prefix}.#{obj.class.name.underscore}.invalid", details: obj.get_simple_errors, description: nil }, status: status }
      else
        { json: { error: "#{prefix}.#{obj}", details: [], description: nil }, status: status }
      end
    end

    def render_exception(error)
      raise ArgumentError('not an instance of OTError') unless error.is_a?(ErrorRenderer::OTException)

      render_error error.model, error.type
    end

    def get_exception(error)
      raise ArgumentError('not an instance of OTError') unless error.is_a?(ErrorRenderer::OTException)

      get_error error.model, error.type
    end
  end

  class OTException < RuntimeError
    attr_reader :model, :type

    def initialize(model, type)
      super(model)
      @model = model
      @type = type
    end
  end
end

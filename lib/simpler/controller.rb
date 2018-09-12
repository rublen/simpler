require_relative 'view'

module Simpler
  class Controller
    IMAGES_PATH = 'app/images'

    attr_reader :name, :request, :response
    attr_accessor :headers, :params

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @headers = @response.headers
      @params = set_params
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response if @response.empty?

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def text_plain_response(body)
      @response['Content-Type'] = 'text/plain'
      @response.write(body)
    end

    def write_response(body = nil)
      body = body ? File.read(body) : render_body
      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def set_params
      @params = @request.params
      @params.merge! @request.env['simpler.route_params']
    end

    def render(template)
      return @request.env['simpler.template'] = template unless template.is_a? Hash

      case template.keys[0].to_s
      when 'plain'
        text_plain_response(template[:plain])
      when 'text/html'
        @response.write(template['text/html'])
      else
        @response['Content-Type'] = template.keys[0].to_s
        write_response(Simpler.root.join(IMAGES_PATH, template.values[0].to_s))
      end
    end

    def status(number)
      @response.status = number
    end
  end
end

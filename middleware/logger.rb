require 'logger'
class AppLogger
  def initialize(app, **options)
    @app = app
    @logger = Logger.new(options[:logenv] || STDOUT)
  end

  def call(env)
    @response = @app.call(env)
    log_data(env)
    @response
  end

  private

  def log_data(env)
    request = Rack::Request.new(env)
    data ="Request: #{request.request_method} #{request.path}\n" +
      "Handler: #{request.env['simpler.controller'].name.capitalize}Controller##{request.env['simpler.action']}\n" +
      "Parameters: #{request.params.merge(request.env['simpler.route_params'])}\n" +
      "Response: #{@response[0]} #{@response[1]['Content-type']} #{request.env['simpler.template']}.html.erb\n"
    @logger.info(data)
  end

end

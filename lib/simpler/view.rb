require 'erb'

module Simpler
  class View
    VIEW_BASE_PATH = 'app/views'.freeze
    def initialize(env)
      @env = env
    end

    def render(binding)
      ERB.new(File.read(template_path)).result(binding)
    end

    private

    def template_path
      path = template || [controller.name, action].join('/')
      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html")
    end

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end
  end
end

module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && route_match_path?(@path, path)
      end

      def route_match_path?(route, path)
        route = route.split('/')
        path = path.split('/')
        len = path.size
        return false unless route.size == len
        (0...len).each do |i|
          next if path[i] == route[i]
          if route[i][0] == ':'
            param_key = route[i][1..-1].to_sym
            @params[param_key] = path[i]
            next
          end
          return false
        end
        true
      end

    end
  end
end

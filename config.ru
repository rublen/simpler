require_relative 'middleware/logger'
require_relative 'config/environment'

use AppLogger, logenv: File.expand_path('log/app.log', __dir__)
run Simpler.application

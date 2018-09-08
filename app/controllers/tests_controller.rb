class TestsController < Simpler::Controller
  def index
    @tests = Test.all
    @time = Time.now
    # render 'tests/list'
  end

  def create
  end
end

class TestsController < Simpler::Controller

  def index
    @time = Time.now
    # render plain: "Hello from Simpler!!"
    render 'text/html' => '<h1> Hi there!</h1>'
    # render 'image/png' => 'picture.png'
    # render 'tests/list'
    status 201
    headers['Content-Type'] = 'text/plain'
  end

  def create

  end

  def show
    @test = Test.find(id: params[:id].to_i)
  end

end

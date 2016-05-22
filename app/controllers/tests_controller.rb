class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_filter :find_test_set

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  def show_tests_for_set
    @tests = Test.where(test_set_id: params[:test_set_id])
    render  template: "tests/index"
  end

  # GET /tests/new
  def new
    @a = params
    @test = Test.new

    @test.test_set_id = nil || @a['params_test_set_id'] || @a['test_set_id']

  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to "/test_sets/#{@test.test_set_id}" , notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to :back, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      id = params[:id] || params[:test_id]
      @test = Test.find(id)
    end

    def find_test_set
      return unless params[:test_set_id]
      @test_set = TestSet.find(params[:test_set_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:description, :question, :alternative1, :alternative2, :alternative3, :alternative4, :answer, :time, :test_set_id)
    end
end

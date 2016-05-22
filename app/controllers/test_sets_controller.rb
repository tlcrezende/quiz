class TestSetsController < ApplicationController
  before_action :set_test_set, only: [:show, :edit, :update, :destroy]

  # GET /test_sets
  # GET /test_sets.json
  def index
    @test_sets = TestSet.all
  end

  # GET /test_sets/1
  # GET /test_sets/1.json
  def show
  end

  # GET /test_sets/new
  def new
    @test_set = TestSet.new
  end

  # GET /test_sets/1/edit
  def edit
  end

  # POST /test_sets
  # POST /test_sets.json
  def create
    @test_set = TestSet.new(test_set_params)

    respond_to do |format|
      if @test_set.save
        format.html { redirect_to @test_set, notice: 'Test set was successfully created.' }
        format.json { render :show, status: :created, location: @test_set }
      else
        format.html { render :new }
        format.json { render json: @test_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /test_sets/1
  # PATCH/PUT /test_sets/1.json
  def update
    respond_to do |format|
      if @test_set.update(test_set_params)
        format.html { redirect_to @test_set, notice: 'Test set was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_set }
      else
        format.html { render :edit }
        format.json { render json: @test_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_sets/1
  # DELETE /test_sets/1.json
  def destroy
    @test_set.destroy
    respond_to do |format|
      format.html { redirect_to test_sets_url, notice: 'Test set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test_set
      @test_set = TestSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_set_params
      params.require(:test_set).permit(:description, :video_url, :score)
    end
end

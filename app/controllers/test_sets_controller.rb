class TestSetsController < ApplicationController
  before_action :set_test_set, only: [:new2, :show, :edit, :update, :destroy]

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
    
    tam = test_set_params["video_url"].size
    params_int = test_set_params
    params_int["video_url"] = test_set_params["video_url"][32..tam]
    params_int["score"] = 0
    @test_set = TestSet.new(params_int)

    respond_to do |format|
      if @test_set.save
        format.html { redirect_to @test_set, notice: 'O Quiz foi adicionado com sucesso.' }
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

    tam = test_set_params["video_url"].size
    params_int = test_set_params
    params_int["video_url"] = test_set_params["video_url"][32..tam]
    respond_to do |format|
      if @test_set.update(params_int)
        format.html { redirect_to @test_set, notice: 'O Quiz foi atualizado com sucesso.' }
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
      format.html { redirect_to test_sets_url, notice: 'O Quiz foi removido com sucesso.' }
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

class ApiController < ApplicationController
  def find_test_set_from_video
    test_set = TestSet.where(video_url: params[:video_url])
    render json: test_set.to_json(include: :tests)
  end
end

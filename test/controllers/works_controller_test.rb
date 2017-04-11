require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path
    must_respond_with :success
  end

  it "should get show page" do
    get work_path(works(:work_one).id)
    must_respond_with :success
  end
end

require "test_helper"

describe VotesController do
  it "will redirect to login page if user is not logged in to vote" do
    post new_vote_path votes(:vote_one)
    must_respond_with :redirect
    must_redirect_to login_path
  end

  # it "will redirect to show page if user is logged in and votes" do
  #   post login_path users(:lynn)
  #   post new_vote_path votes(:vote_one)
  #   must_respond_with :redirect
  #   must_redirect_to work_path
  # end

end

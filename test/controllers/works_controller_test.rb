require "test_helper"

describe WorksController do
  describe "#index" do
     #pos index
    it "should get index" do
      get works_path
      must_respond_with :success
    end

    it "still works with multiple works" do
      Work.count.must_be :>, 0
      get works_path
      must_respond_with :success
    end

    it "works with no works" do
      Work.destroy_all
      get works_path
      must_respond_with :success
    end
  end

  describe "index_books" do
    #pos index_books
    it "should get index_books page" do
      get books_path
      must_respond_with :success
    end

    it "still works with multiple works" do
      Work.count.must_be :>, 0
      get books_path
      must_respond_with :success
    end

    it "works with no works" do
      Work.destroy_all
      get books_path
      must_respond_with :success
    end
  end

  describe "index_albums" do
    #pos index_albums
    it "should get index_albums page" do
      get albums_path
      must_respond_with :success
    end

    it "still works with multiple works" do
      Work.count.must_be :>, 0
      get albums_path
      must_respond_with :success
    end

    it "works with no works" do
      Work.destroy_all
      get albums_path
      must_respond_with :success
    end
  end

  describe "index_movies" do
    #pos index_movies
    it "should get index_movies page" do
      get movies_path
      must_respond_with :success
    end

    it "still works with multiple works" do
      Work.count.must_be :>, 0
      get movies_path
      must_respond_with :success
    end

    it "works with no works" do
      Work.destroy_all
      get movies_path
      must_respond_with :success
    end
  end

  describe "#show" do
    #pos show test
    it "should get show page for a work that exists" do
      get work_path(works(:work_one).id)
      must_respond_with :success
    end

    #neg show test
    it "should show a 404 if work not found" do
      get work_path(1)
      must_respond_with :missing
    end
  end

  describe "#new" do
    #pos new
    it "should get form for new work" do
      get new_work_path
      must_respond_with :success
    end
  end

  describe "#create" do
    #pos create redirect
    it "should redirect to index after adding a work" do
      post works_path params: { work:
              { title: "Title",
                category: "book",
                creator: "creator",
                pub_yr: 1970,
                desc: "Desc" }
            }
      must_respond_with :redirect
      must_redirect_to works_path
    end

    #neg create route - testing that it will go to new page.
    it "should respond w/bad_request if not saved" do
      post works_path params: { work:
              { title: "",
                category: "book",
                creator: "creator",
                pub_yr: 1970,
                desc: "Desc" }
            }
        must_respond_with :bad_request
    end

    #pos create affect database test
    it "should affect the model when updating a book" do
      proc {
        post works_path, params: { work:
            { title: "Title",
              category: "book",
              creator: "creator",
              pub_yr: 1970,
              desc: "Desc" }
            }
        }.must_change 'Work.count', 1
    end

    #neg create test - Not sure if this is actually testing
    #What I want it to test.
    it "should not affect the model when book is invalid" do
      proc {
        post works_path, params: { work:
            { title: "",
              category: "book",
              creator: "creator",
              pub_yr: 1970,
              desc: "Desc" }
            }
        }.must_change 'Work.count', 0
    end
  end

  describe "#edit" do
    #pos edit test
    it "should get form to edit work" do
      get edit_work_path(works(:work_one).id)
      must_respond_with :success
    end

    #neg edit test
    it "should show a 404 if work not found to edit" do
      get edit_work_path(1)
      must_respond_with :missing
    end
  end

  describe "update" do
    #pos update test
    it "should update a work and redirect to works index" do
      put work_path(works(:work_one).id), params: {work: {title: "New Title", desc: "la la la"} }
      work = Work.find(works(:work_one).id)
      work.title.must_equal "New Title"
      work.desc.must_equal "la la la"
      must_respond_with :redirect
      must_redirect_to work_path(works(:work_one).id)
    end

    #neg update test - is this overkill b/c of Model testing??
    it "should not update a work if entry is invalid" do
      put work_path(works(:work_one).id), params: {work: {title: ""} }
      work = Work.find(works(:work_one).id)
      work.title.must_equal "My Work"
      must_respond_with :bad_request
    end

    it "should show a 404 if work not found to update" do
      bad_work_id = Work.last.id + 1
      put work_path(bad_work_id), params: {work: {title: "New Title", desc: "la la la"} }
      must_respond_with :missing
    end
  end

  describe "#destroy" do
    #pos destroy test redirect
    it "should redirect to work list" do
      delete work_path(works(:work_one).id)
      must_redirect_to works_path
    end

    #pos destroy test affect DB
    it "should affect database if work found" do
      proc { delete work_path(works(:work_one).id) }.must_change 'Work.count', -1
    end

    #neg destroy test?
    it "should not affect database if work not found" do
      delete work_path(works(:work_one).id)
      must_redirect_to works_path
    end

    it "should show a 404 if work not found to destroy" do
      bad_work_id = Work.last.id + 1
      delete work_path(bad_work_id)
      must_respond_with :missing
    end
  end
end

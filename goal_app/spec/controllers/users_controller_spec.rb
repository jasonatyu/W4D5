require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "Get #new" do 
    it "should render the new template" do 
      get :new 
      expect(response).to render_template(:new)
    end
  end

  describe "Get #show" do 
     it "should render the show template" # do 
    #   get :show, params: { id: User.last.id }
    #   expect(response).to render_template(:show)
    # end
  end

  describe "Get #index" do 
    it "should render the index template" do 
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "Post #create" do 
    it "should create a new user" do
      post :create, params: { user: { username: "Mike", password: "password123" } }
      expect(response).to redirect_to(user_url(User.last))
    end
  end

end

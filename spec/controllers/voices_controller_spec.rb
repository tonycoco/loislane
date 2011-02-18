require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe VoicesController do
  before :each do
    @user = mock_model(User)
    controller.should_receive(:current_user).at_least(:once).and_return(@user)

    @commit = mock_model(Commit, :user => @user, :voices => [])
    Commit.stub(:find).and_return(@commit)
  end

  def mock_voice(stubs={})
    @mock_voice ||= mock_model(Voice, stubs).as_null_object
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created voice as @voice" do
        Voice.stub(:new).with({'comment' => 'Test comment', 'type' => 'comment'}) { mock_voice(:save => true) }
        post :create, :voice => {'comment' => 'Test comment', 'type' => 'comment'}, 'commit_id' => @commit.id, :format => :js
        assigns(:voice).should be(mock_voice)
      end

      it "renders the created voice" do
        Voice.stub(:new) { mock_voice(:save => true) }
        post :create, :voice => {'comment' => 'Test comment', 'type' => 'comment'}, 'commit_id' => @commit.id, :format => :js
        response.should render_template("create")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved voice as @voice" do
        Voice.stub(:new).with({}) { mock_voice(:save => false) }
        post :create, :voice => {}, 'commit_id' => @commit, :format => :js
        assigns(:voice).should be(mock_voice)
      end

      it "renders an error" do
        Voice.stub(:new) { mock_voice(:save => false) }
        post :create, :voice => {}, 'commit_id' => @commit, :format => :js
        response.should render_template("create")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested approval" do
      Voice.stub(:find).with("37") { mock_voice }
      mock_voice.should_receive(:destroy)
      delete :destroy, :id => "37", 'commit_id' => @commit, :format => :js
    end

    it "redirects to the approvals list" do
      Voice.stub(:find) { mock_voice }
      delete :destroy, :id => "1", 'commit_id' => @commit, :format => :js
      response.should render_template("destroy")
    end
  end
end

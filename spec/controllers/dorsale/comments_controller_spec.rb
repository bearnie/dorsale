require "rails_helper"

describe Dorsale::CommentsController, type: :controller do
  routes { Dorsale::Engine.routes }

  let(:user) { create(:user) }

  before(:each) { sign_in(user) }

  let(:commentable) { create(:customer_vault_corporation) }
  let(:valid_params) {
    {
      :comment => {
        :commentable_id   => commentable.id,
        :commentable_type => commentable.class.to_s,
        :text => "Hello",
      },
      :back_url => "/",
    }
  }

  describe "create" do
    it "should create comment" do
      post :create, params: valid_params
      expect(assigns(:comment)).to be_persisted
    end

    it "should redirect to back_url" do
      post :create, params: valid_params
      expect(response).to redirect_to("/")
    end
  end

  describe "update" do
    it "should update comment text" do
      comment = create(:dorsale_comment)
      patch :update, params: {id: comment, comment: {text: "New-comment-text"}, back_url: "/"}
      expect(response).to redirect_to("/")
      expect(comment.reload.text).to eq "New-comment-text"
    end
  end

  describe "destroy" do
    it "should destroy comment" do
      comment = create(:dorsale_comment)
      delete :destroy, params: {id: comment, back_url: "/"}
      expect(response).to redirect_to("/")
    end
  end
end

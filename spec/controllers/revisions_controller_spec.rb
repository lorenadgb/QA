require 'rails_helper'

RSpec.describe RevisionsController, type: :controller do

  login_admin

  let(:user) { User.first }

  let(:question) { FactoryGirl.create(:question_1, user: User.first) }

  let(:valid_attributes) {
    { comment: 'There are some mistakes in the question. Please fix and submit again.', status: QuestionStatus::REPROVED,
      reviewer: question.user, question: question, question_id: question.id }
  }

  let(:invalid_attributes) {
    { comment: nil, status: ' ', question_id: question.id }
  }

  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new revision as @revision" do
      get :new, { question_id: question.id }, valid_session
      expect(assigns(:revision)).to be_a_new(Revision)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Revision" do
        expect {
          post :create, {:revision => valid_attributes}, valid_session
        }.to change(Revision, :count).by(1)
      end

      it "assigns a newly created revision as @revision" do
        post :create, {:revision => valid_attributes}, valid_session
        expect(assigns(:revision)).to be_a(Revision)
        expect(assigns(:revision)).to be_persisted
      end

      it "redirects to the created revision" do
        post :create, {:revision => valid_attributes}, valid_session
        expect(response).to redirect_to(new_revision_path(question_id: question.id))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved revision as @revision" do
        post :create, {:revision => invalid_attributes}, valid_session
        expect(assigns(:revision)).to be_a_new(Revision)
      end

      it "re-renders the 'new' template" do
        post :create, {:revision => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end
end

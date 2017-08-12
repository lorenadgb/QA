require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  login_admin

  let(:user) { User.first }
  let(:visitor) { FactoryGirl.create(:visitor) }
  let(:answers) { [FactoryGirl.attributes_for(:answer_1), FactoryGirl.attributes_for(:answer_2), FactoryGirl.attributes_for(:answer_3),
                   FactoryGirl.attributes_for(:answer_4), FactoryGirl.attributes_for(:answer_5)] }

  let(:valid_attributes) {
    { content: 'Content of question number 1', year: 2017, source: 'wikipedia.com', status: QuestionStatus::PENDING,
      answers_attributes: answers, user: user }
  }

  let(:valid_session) { {} }

  describe 'GET #home' do
    it 'responds successfully with an HTTP 200 status code' do
      get :home
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the home template' do
      get :home
      expect(response).to render_template('home')
    end

    it "assigns all questions as @questions" do
      question = Question.create! valid_attributes
      get :home, {}, valid_session
      expect(assigns(:questions)).to eq([question])
    end

    it "Only admin-user can see questions created by another non-admin users" do
      Question.create! valid_attributes
      sign_out user
      sign_in visitor
      get :home, {}, valid_session
      expect(assigns(:questions)).to eq([])
    end
  end
end

require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    answers = [FactoryGirl.create(:answer_1), FactoryGirl.create(:answer_2), FactoryGirl.create(:answer_3),
               FactoryGirl.create(:answer_4), FactoryGirl.create(:answer_5)]

    assign(:questions, [
      Question.create!(
        :content => "Content",
        :source => "Source",
        :year => 2017,
        :answers => answers,
        :status => QuestionStatus::PENDING,
        :user => FactoryGirl.create(:admin)
      ),
      Question.create!(
        :content => "Content",
        :source => "Source",
        :year => 2017,
        :answers => answers,
        :status => QuestionStatus::PENDING,
        :user => FactoryGirl.create(:visitor)
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 2017.to_s, :count => 2
    assert_select "tr>td", :text => "pending".to_s, :count => 2
  end
end

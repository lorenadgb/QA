require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    answers = [FactoryGirl.create(:answer_1), FactoryGirl.create(:answer_2), FactoryGirl.create(:answer_3),
               FactoryGirl.create(:answer_4), FactoryGirl.create(:answer_5)]

    @question = assign(:question, Question.create!(
      :content => "MyString",
      :source => "MyString",
      :year => 2017,
      :answers => answers,
      :user => FactoryGirl.create(:admin)
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

      assert_select "textarea#question_content[name=?]", "question[content]"

      assert_select "input#question_source[name=?]", "question[source]"

      assert_select "input#question_year[name=?]", "question[year]"
    end
  end
end

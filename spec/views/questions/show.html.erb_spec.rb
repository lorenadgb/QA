require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    answers = [FactoryGirl.create(:answer_1), FactoryGirl.create(:answer_2), FactoryGirl.create(:answer_3),
                FactoryGirl.create(:answer_4), FactoryGirl.create(:answer_5)]

    @question = assign(:question, Question.create!(
      :content => "Content",
      :source => "Source",
      :year => "Year",
      :status => QuestionStatus::PENDING,
      :answers => answers,
      :user => FactoryGirl.create(:admin)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Conteúdo/)
    expect(rendered).to match(/Fonte/)
    expect(rendered).to match(/Ano/)
    expect(rendered).to match(/Status/)
  end
end

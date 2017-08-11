require 'rails_helper'

RSpec.describe "questions/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :content => "Content",
      :source => "Source",
      :year => "Year",
      :status => QuestionStatus::PENDING,
      :user => FactoryGirl.create(:admin)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Source/)
    expect(rendered).to match(/Year/)
    expect(rendered).to match(/Status/)
  end
end

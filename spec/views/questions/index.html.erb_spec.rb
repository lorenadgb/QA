require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :content => "Content",
        :source => "Source",
        :year => 2017,
        :user => FactoryGirl.create(:admin)
      ),
      Question.create!(
        :content => "Content",
        :source => "Source",
        :year => 2017,
        :user => FactoryGirl.create(:visitor)
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Source".to_s, :count => 2
    assert_select "tr>td", :text => 2017.to_s, :count => 2
  end
end

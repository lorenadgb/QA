require 'rails_helper'

RSpec.describe "revisions/new", type: :view do
  before(:each) do
    RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

    @question = question = FactoryGirl.create(:question_1)
    reviewer = User.first

    assign(:revision, Revision.create(
      :comment => "MyText",
      :reviewer_id => reviewer.id,
      :question => question
    ))

    allow(@question).to receive(:there_is_at_least_one_revision).and_return(true)
    allow(@question).to receive(:revisions).and_return([])
  end

  it "renders new revision form" do
    render

    assert_select "form[action=?][method=?]", revisions_path, "post" do

      assert_select "textarea#revision_comment[name=?]", "revision[comment]"
    end
  end
end

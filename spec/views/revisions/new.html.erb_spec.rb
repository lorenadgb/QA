require 'rails_helper'

RSpec.describe "revisions/new", type: :view do
  before(:each) do
    assign(:revision, Revision.new(
      :comment => "MyText",
      :reviewer_id => nil,
      :question => nil
    ))
  end

  it "renders new revision form" do
    render

    assert_select "form[action=?][method=?]", revisions_path, "post" do

      assert_select "textarea#revision_comment[name=?]", "revision[comment]"

      assert_select "input#revision_reviewer_id[name=?]", "revision[reviewer_id]"

      assert_select "input#revision_question_id[name=?]", "revision[question_id]"
    end
  end
end

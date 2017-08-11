require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "Relationships" do
    it { should belong_to :question }
  end

  context "Validations" do
    it { should validate_presence_of :content }
  end
end

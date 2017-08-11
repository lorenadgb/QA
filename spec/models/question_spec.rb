require 'rails_helper'

describe Question do
  context "Relationships" do
    it { should belong_to :user }
  end

  context "Validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :source }
    it { should validate_presence_of :year }
  end
end

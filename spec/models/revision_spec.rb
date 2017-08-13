require 'rails_helper'

RSpec.describe Revision, type: :model do

  context "Relationships" do
    it { should belong_to :reviewer }
    it { should belong_to :question }
  end

  context "Validations" do
    it { should validate_presence_of :status }
  end

  context "Delegations" do
    it { should delegate_method(:user).to(:question) }
  end

end

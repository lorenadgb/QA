require 'rails_helper'

describe User do
  context "Relationships" do
    it { should have_many :questions }
  end
end

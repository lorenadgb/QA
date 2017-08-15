require 'rails_helper'

RSpec.describe Revision, type: :model do
  subject { described_class.new }

  context "Relationships" do
    it { should belong_to :reviewer }
    it { should belong_to :question }
  end

  context "Validations" do
    before do
      allow(subject).to receive(:reviewer).and_return admin
    end

    let :admin do
      double(:reviewer, admin?: true)
    end

    let :visitor do
      double(:reviewer, admin?: false)
    end

    it 'admin-users can create a revision' do
      allow(subject).to receive(:reviewer).and_return admin

      subject.valid?

      expect(subject.errors[:base]).to_not include 'Only admin-user can create a revision.'
    end

    it 'admin-users can create a revision' do
      allow(subject).to receive(:reviewer).and_return visitor

      subject.valid?

      expect(subject.errors[:base]).to include 'Only admin-user can create a revision.'
    end

    it { should validate_presence_of :status }
  end

  context "Delegations" do
    it { should delegate_method(:user).to(:question) }
  end

end

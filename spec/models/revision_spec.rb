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
      allow(subject).to receive(:can_change_the_status?).and_return true
    end

    let :admin do
      double(:reviewer, admin?: true)
    end

    let :visitor do
      double(:reviewer, admin?: false)
    end

    let :approved_question do
      double(:question, status: QuestionStatus::APPROVED)
    end

    let :reproved_question do
      double(:question, status: QuestionStatus::REPROVED)
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

    it 'comment can not be blank if revision status is reproved' do
      subject.status = RevisionStatus::REPROVED

      subject.save

      expect(subject.errors.full_messages).to eq ["Comment can't be blank"]
    end

    it 'comment can be blank if revision status is approved' do
      subject.status = RevisionStatus::APPROVED

      subject.save

      expect(subject.errors.full_messages).to eq []
    end

    it 'Can not change the status of an approved question' do
      allow(subject).to receive(:can_change_the_status?).and_call_original
      allow(subject).to receive(:question).and_return approved_question

      subject.comment = 'Fix the question!'

      subject.send(:can_change_the_status?)

      subject.save

      expect(subject.errors[:base]).to eq ['Can not change status of an approved question']
    end

    it 'Can change the status of a not approved question' do
      allow(subject).to receive(:can_change_the_status?).and_call_original
      allow(subject).to receive(:question).and_return reproved_question

      subject.comment = 'Fix the question!'
      subject.status = QuestionStatus::APPROVED

      subject.send(:can_change_the_status?)

      subject.save

      expect(subject.errors.full_messages).to eq []
    end

    it { should validate_presence_of :status }
  end

  context "Delegations" do
    it { should delegate_method(:user).to(:question) }
  end

end

require 'rails_helper'

describe Question do
  subject { described_class.new }

  context "Relationships" do
    it { should belong_to :user }
  end

  context "Validations" do
    it { should validate_presence_of :content }
    it { should validate_presence_of :source }
    it { should validate_presence_of :year }
  end

  context "Callbacks" do
    it "before_create: set status to pending" do
      subject.run_callbacks(:create) { true }

      expect(subject.status).to eq QuestionStatus::PENDING
    end
  end

  context "#status" do
    before do
      subject.content = 'Content #1'
      subject.source  = 'wikipedia'
      subject.year    = 2017

      subject.save
    end

    it 'update status to approved' do
      subject.send(:approved!)

      expect(subject.status).to eq QuestionStatus::APPROVED
    end

    it 'update status to reproved' do
      subject.send(:reproved!)

      expect(subject.status).to eq QuestionStatus::REPROVED
    end

    it 'update status to pending' do
      subject.send(:pending!)

      expect(subject.status).to eq QuestionStatus::PENDING
    end
  end
end

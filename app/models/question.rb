class Question < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  has_many :answers, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :answers

  has_enumeration_for :status, with: QuestionStatus, create_scopes: true

  before_create :set_default_status

  validate  :must_have_one_correct_answer
  validates :answers, length: { is: 5 }
  validates :content, :source, :year, presence: true

  def self.number_of_answers
    5
  end

  private

  def must_have_one_correct_answer
    errors.add(:base, 'Must have one correct answer') unless self.answers.select { |answer| answer.correct }.count == 1
  end

  def set_default_status
    self.status = QuestionStatus::PENDING
  end

  def update_status(new_status)
    if new_status    == QuestionStatus::APPROVED
      approved!
    elsif new_status == QuestionStatus::REPROVED
      reproved!
    elsif new_status == QuestionStatus::PENDING
      pending!
    end
  end

  def approved!
    update_column :status, QuestionStatus::APPROVED
  end

  def reproved!
    update_column :status, QuestionStatus::REPROVED
  end

  def pending!
    update_column :status, QuestionStatus::PENDING
  end
end

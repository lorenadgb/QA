class Question < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user

  validates :content, :source, :year, presence: true

  has_enumeration_for :status, with: QuestionStatus, create_scopes: true

  before_create :set_default_status

  private

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

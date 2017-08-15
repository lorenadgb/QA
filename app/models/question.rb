class Question < ActiveRecord::Base

  belongs_to :user
  has_many :answers, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :answers
  has_many :revisions, inverse_of: :question, dependent: :destroy

  has_enumeration_for :status, with: QuestionStatus, create_scopes: true

  before_create :set_default_status

  validate :can_only_edit_a_reproved_question
  validate  :must_have_one_correct_answer
  validates :answers, length: { is: 5 }
  validates :content, :source, :year, presence: true

  scope :by_user_id, -> (user_id){ where(user_id: user_id) }

  default_scope { order(created_at: :desc) }

  def self.number_of_answers
    5
  end

  def there_is_at_least_one_revision
    revisions.count > 0
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

  private

  def must_have_one_correct_answer
    errors.add(:base, I18n.translate('activerecord.errors.messages.must_have_one_correct_answer')) unless self.answers.select { |answer| answer.correct }.count == 1
  end

  def set_default_status
    self.status = QuestionStatus::PENDING
  end

  def can_only_edit_a_reproved_question
    errors.add(:base, I18n.translate('activerecord.errors.messages.can_only_edit_a_reproved_question')) if (self.persisted? && self.changed? && self.status_was != QuestionStatus::REPROVED)
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

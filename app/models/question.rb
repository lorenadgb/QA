class Question < ActiveRecord::Base
  NUMBER_OF_ANSWERS = 5

  belongs_to :user
  has_many :answers, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :answers
  has_many :revisions, inverse_of: :question, dependent: :destroy

  has_enumeration_for :status, with: QuestionStatus, create_scopes: true

  before_save :set_status

  validate :can_only_edit_a_reproved_question
  validate  :at_least_one_correct_answer
  validates :answers, length: { is: 5 }
  validates :content, :source, :year, presence: true

  scope :by_user_id, -> (user_id){ where(user_id: user_id) }

  default_scope { order(created_at: :desc) }

  def there_is_at_least_one_revision
    revisions.count > 0
  end

  def update_status(new_status)
    update_column :status, new_status
  end

  private

  def at_least_one_correct_answer
    if self.answers.select { |answer| answer.correct }.count == 0
      errors.add(:base, I18n.translate('activerecord.errors.messages.at_least_one_correct_answer'))
    end
  end

  def set_status
    self.status = QuestionStatus::PENDING
  end

  def can_only_edit_a_reproved_question
    if self.persisted? && self.changed? && self.status_was != QuestionStatus::REPROVED
      errors.add(:base, I18n.translate('activerecord.errors.messages.can_only_edit_a_reproved_question'))
    end
  end
end

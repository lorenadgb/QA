class Revision < ActiveRecord::Base

  belongs_to :reviewer, class_name: 'User'
  belongs_to :question

  has_enumeration_for :status, with: RevisionStatus, create_scopes: true

  validates :status, presence: true
  validates :comment, presence: true, if: Proc.new { |r| r.status == RevisionStatus::REPROVED }
  validate  :user_has_permission?
  validate  :can_change_the_status?

  delegate :user, to: :question

  scope :by_question_id, -> (question_id){ where(question_id: question_id) }

  private

  def user_has_permission?
    unless reviewer.admin?
      errors.add(:base, I18n.translate('activerecord.errors.messages.user_has_permission'))
    end
  end

  def can_change_the_status?
    unless pending_question?
      errors.add(:base, I18n.translate('activerecord.errors.messages.can_change_the_status'))
    else
      self.question.update_status(self.status)
    end
  end

  def pending_question?
    self.question.status == QuestionStatus::PENDING
  end
end

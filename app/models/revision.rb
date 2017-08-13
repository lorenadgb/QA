class Revision < ActiveRecord::Base

  belongs_to :reviewer, class_name: 'User'
  belongs_to :question

  has_enumeration_for :status, with: RevisionStatus, create_scopes: true

  validates :status, presence: true

  delegate :user, to: :question

  scope :by_question_id, -> (question_id){ where(question_id: question_id) }
end

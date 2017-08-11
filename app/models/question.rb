class Question < ActiveRecord::Base

  belongs_to :user

  validates :content, :source, :year, presence: true
end

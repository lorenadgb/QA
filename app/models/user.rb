class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, inverse_of: :user, dependent: :destroy
  has_many :revisions, inverse_of: :user, dependent: :destroy, foreign_key: :reviewer_id
end

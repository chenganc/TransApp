class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  validates :body, presence: true, length: { maximum: 140 }
end

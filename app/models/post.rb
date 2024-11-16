class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  validates_presence_of :body, :title, :author_id
end

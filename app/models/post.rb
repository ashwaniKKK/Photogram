class Post < ApplicationRecord
     belongs_to :user
     validates :user_id, presence: true
     validates :image, presence: true
     has_attached_file :image, styles: { :medium => "430x" }
     validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

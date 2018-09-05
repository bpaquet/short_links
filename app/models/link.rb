class Link < ApplicationRecord

  validates :name, uniqueness: true
  validates :name, format: { with: /\A[a-z0-9-]+\z/, message: 'can contains only [a-z0-9-]' }
  validates :name, :target, :owners, presence: true
  validates :target, format: { with: /\Ahttps?:\/\//, message: 'must start with https?://'  }

end

class BeerClub < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  validates :name, length: { minimum: 1 }

  def to_s
    self.name + " - " + self.founded.to_s + " - " + self.city
  end

end

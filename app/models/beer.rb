class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> {uniq}, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }
  validates :style_id, numericality: { only_integer: true }
  validates :brewery_id, numericality: { only_integer: true }

  def to_s
    self.name + " - " + self.style.name + " - " + self.brewery.name
  end

end

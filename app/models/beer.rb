class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :style
  belongs_to :brewery, touch: true
  has_many :ratings, dependent: :destroy
  has_many :raters, -> {uniq}, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }
  validates :style_id, numericality: { only_integer: true }
  validates :brewery_id, numericality: { only_integer: true }

  def to_s
    self.name + " - " + self.style.name + " - " + self.brewery.name
  end

  def self.top(n)
    sorted_by_rating = Beer.all.sort_by{ |b| -(b.average_rating||0) }

    i = 0
    arr = []
    
    sorted_by_rating.each do |beer|
      if i < n
        arr << beer
        i = i + 1
      end
    end
    
    arr
  end

end

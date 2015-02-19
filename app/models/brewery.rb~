class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1024,
                                 less_than_or_equal_to: ->(_){Time.now.year} }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil,false] }

  def self.top(n)
    sorted_by_rating = Brewery.all.sort_by{ |b| -(b.average_rating||0) }

    i = 0
    arr = []
    
    sorted_by_rating.each do |brewery|
      if i < n
        arr << brewery
        i = i + 1
      end
    end
    
    arr
  end
end

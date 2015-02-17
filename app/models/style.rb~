class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: { minimum: 1 }
  validates :description, length: { minimum: 1 }

  def self.top(n)
    sorted_by_rating = Style.all.sort_by{ |s| -(s.average_rating||0) }

    i = 0
    arr = []
    
    sorted_by_rating.each do |user|
      if i < n
        arr << user
        i = i + 1
      end
    end
    
    arr
  end


end

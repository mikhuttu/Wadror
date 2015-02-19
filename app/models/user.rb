class User < ActiveRecord::Base
  include RatingAverage

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  validates :password, format: {with: /(?=.*\d)(?=.*[A-Z]).{4,}/,
                                message: "has to contain one number and one upper case letter" }

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy

  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  has_secure_password

  def self.top(n)
    sorted_by_rating = User.all.sort_by{ |u| -(u.ratings.count||0) }

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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite(category)
    return nil if ratings.empty?

    category_ratings = rated(category).inject([]) do |set, item|
      set << {
        item: item,
        rating: rating_of(category, item) }
    end

    category_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    1.0 * ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

end

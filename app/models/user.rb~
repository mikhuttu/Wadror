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

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    styles = beers.map { |beer| beer.style }.uniq        
    return nil if styles.empty?
   
     best_average = 0.0
     best_style = styles.first

     styles.each do |style|
       style_ratings = ratings.select { |rating| rating.beer.style == style }
       sum = style_ratings.inject(0) { |s, rating| s + rating.score }
       avg = 1.0 * sum / style_ratings.count

       if (avg > best_average)
         best_average = avg
         best_style = style
       end
     end

     best_style
  end

  def favorite_brewery
     breweries = beers.map { |beer| beer.brewery }.uniq
     return nil if breweries.empty?
     
     best_average = 0.0
     best_brewery = breweries.first

     breweries.each do |brewery|
       brewery_ratings = ratings.select { |rating| rating.beer.brewery == brewery }
       sum = brewery_ratings.inject(0) { |s, rating| s + rating.score }
       avg = 1.0 * sum / brewery_ratings.count

       if (avg > best_average)
         best_average = avg
         best_brewery = brewery
       end
     end

     best_brewery
  end


end

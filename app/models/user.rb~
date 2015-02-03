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

#  def favorite_style
#    return nil if beers.empty?
#    
#    beers.order(style: :desc)
#    style = beers.first.style
#    best_average = beers.first.average_rating;
#    self_average;
#
#    beers.each |beer| do
#      if beer.style == style
#        if self_average.nil?
#          self_average = beer.average_rating
#        else
#          self_average = 
#        
#      end
#    end
#  end

# def beers_styles
 #   styles
    
 #   beers.map do |beer|
    #  styles << beer.style

     # if styles.nil? or not styles.include?(beer.style)
        
     # end
#    end
    
  #  styles
#end

end

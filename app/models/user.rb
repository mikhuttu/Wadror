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

end

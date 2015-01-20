class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = self.ratings.inject(0) { |s, rating| s + rating.score }
    1.0 * sum / self.ratings.count
  end

  def to_s
    self.name + " - " + self.brewery.name
  end

end

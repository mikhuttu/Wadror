module RatingAverage  
  extend ActiveSupport::Concern

  def average_rating
    if self.ratings.empty?
      0
    else
      sum = self.ratings.inject(0) { |s, rating| s + rating.score }   
      1.0 * sum / self.ratings.count
    end
  end
end

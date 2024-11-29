module SimpsonsHelper
  def simpsons_name
    Faker::TvShows::Simpsons.character
  end

  def simpsons_quote
    Faker::TvShows::Simpsons.quote
  end
end

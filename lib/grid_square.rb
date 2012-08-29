require_relative 'location'

class GridSquare
  attr_reader :grid_reference, :origin

  # location can be a string containing a GS reference or a pair
  # containing longitude and latitude.
  def initialize(location)
    @grid_reference = location
    calculate!
  end

  def field
    raise IndexError.new("GridSquare.square: insufficient precision to index to field") unless grid_reference.length >= 2
    grid_reference[0..1]
  end

  def square
    raise IndexError.new("GridSquare.square: insufficient precision to index to square") unless grid_reference.length >= 4
    grid_reference[0..3]
  end

  def subsquare
    raise IndexError.new("GridSquare.square: insufficient precision to index to square") unless grid_reference.length >= 6
    grid_reference[0..5]
  end

  def calculate!
    @origin = Location.new -180.0, -90.0
    @size = Location.new 360.0, 180.0

    bases = [[?A.ord,18], ["0".ord,10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10], [?A.ord,24], ["0".ord, 10]]
    loc = @grid_reference.dup.upcase
    while loc.length > 0
      lng, lat, loc = loc.split(//, 3)
      base, size = *bases.shift

      @size /= size
      @origin += Location.new(@size.longitude * (lng.ord - base), @size.latitude * (lat.ord - base))
    end
  end

  def width
    @size.longitude
  end

  def height
    @size.latitude
  end

  def center
    Location.new @origin.longitude + width/2.0, @origin.latitude + height/2.0
  end
end


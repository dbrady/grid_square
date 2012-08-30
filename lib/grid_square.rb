require_relative 'location'
require_relative 'radix_enumerator'

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
    radixes = RadixEnumerator.new
    @origin, @size = Location.new(-180.0, -90.0), Location.new(360.0, 180.0)

    @grid_reference.upcase.chars.each_slice(2) do |lng, lat|
      zero, radix = *radixes.next
      @size /= radix
      @origin += Location.new(@size.longitude * (lng.ord - zero), @size.latitude * (lat.ord - zero))
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


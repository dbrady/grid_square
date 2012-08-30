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

  # Maidenhead locator names
  def field; precision 1; end
  def square; precision 2; end
  def subsquare; precision 3; end
  def extended_subsquare; precision 4; end

  # Return code to a given number of 2-digit fields
  def precision(fields)
    raise IndexError.new "GridSquare.square: insufficient precision to index #{fields} fields" unless grid_reference.length >= fields * 2
    downcase_last grid_reference[0...fields*2]
  end

  def downcase_last(string)
    if string.length > 4
      string[0...-4].upcase + string[-4..-1].downcase
    else
      string.upcase
    end
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


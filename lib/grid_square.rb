require_relative 'location'
require_relative 'radix_enumerator'
require_relative 'string_ext'

class GridSquare
  attr_reader :grid_reference, :origin

  # location can be a string containing a GS reference or a pair
  # containing longitude and latitude.
  def initialize(grid_reference)
    @grid_reference = grid_reference
    decode!
  end

  def self.encode(longitude, latitude, precision=4 )
    longitude += 180
    latitude += 90
    radixes = RadixEnumerator.new
    grid_reference = ''
    size = Location.new(360.0, 180.0)
    precision.times do
      zero,radix = *radixes.next

      lng = (radix * longitude / size.longitude).floor
      lat = (radix * latitude / size.latitude).floor

      grid_reference += "%s%s" % [(zero + lng).chr, (zero + lat).chr]
      size /= radix
      longitude -= lng * size.longitude
      latitude -= lat * size.latitude
    end

    new grid_reference.downcase_last
  end

  # Maidenhead locator names
  def field; precision 1; end
  def square; precision 2; end
  def subsquare; precision 3; end
  def extended_subsquare; precision 4; end

  # Return code to a given number of 2-digit fields
  def precision(fields)
    raise IndexError.new "GridSquare.square: insufficient precision to index #{fields} fields" unless grid_reference.length >= fields * 2
    grid_reference[0...fields*2].downcase_last
  end

  def decode!
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


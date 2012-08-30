# GridSquare

Calculate between GridSquare references and latitude/longitude.

```
grid = GridSquare.new "DN40bi"

grid.center
# => #<Location:0x000001008514d8 @longitude=-109.20833333333333, @latitude=41.6875>

grid.width
# => 0.08333333333333333

grid.height
# => 0.041666666666666664
```


# How the US GridSquare System Works

Okay in theory the GridSquare system is really complicated. But here's
how it works:

The first two letters A-R divide up the whole planet into 18 equal
fields, each field being 10 degrees high (latitude) and 20 degrees
wide (longitude).

The next two digits are decimals that divide up each field into 10x10
squares (that's they're name; they're obviously not square or even
rectangular). Squares are 2 degrees wide and 1 degree tall.

The next two letters A-X divide each square into 24x24 subsquares that
are 5 minutes wide and 2.5 minutes tall.

The next two digits are decimals.

Officially the locator system stops at 8 digits but unofficially it
can be extended by repeating the 3rd and 4th pairs (an A-X pair, then
a 0-9 pair, then an A-X pair, etc) to give precision to the subatomic
level and beyond. This is of course quite silly as the whole system is
based on the notion of a spherical earth and the point of the system
is to tell a complete stranger approximately where in the world the
person they are talking to is located.

# Who Uses this Crap?

Ham Radio operators use them to quickly give one another their
approximate location. By convention, shortwave operators give their
location in squares while VHF and UHF operators give their location in
subsquares. A square has a precision of about 280km; subsquare gives a
location to within 12km.

# Really?

Yes. It even has an amusing name, the Maidenhead Locator System: http://en.wikipedia.org/wiki/Maidenhead_Locator_System


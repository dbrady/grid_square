require 'spec_helper'
require_relative "../../lib/grid_square"

describe GridSquare do
  context "created from subsquare" do
    Given(:grid_square) { GridSquare.new "DN41bi" }

    Then { grid_square.field.should == "DN" }
    Then { grid_square.square.should == "DN41" }
    Then { grid_square.subsquare.should == "DN41bi" }

    Then { grid_square.origin.longitude.should be_within(0.00001).of -109.25 }
    Then { grid_square.origin.latitude.should be_within(0.00001).of 42.66666 }

    Then { grid_square.width.should be_within(0.00001).of 0.083333 }
    Then { grid_square.height.should be_within(0.00001).of 0.041666 }

    Then { grid_square.center.longitude.should be_within(0.00001).of -109.208333 }
    Then { grid_square.center.latitude.should be_within(0.00001).of 42.687500 }
  end

  context "created from square" do
    Given(:grid_square) { GridSquare.new "DN41" }

    Then { grid_square.field.should == "DN" }
    Then { grid_square.square.should == "DN41" }
    Then { lambda { grid_square.subsquare.should == "DN41bi" }.should raise_error(IndexError) }

    Then { grid_square.origin.longitude.should be_within(0.00001).of -112.0 }
    Then { grid_square.origin.latitude.should be_within(0.00001).of 41.0 }

    Then { grid_square.width.should be_within(0.00001).of 2.0 }
    Then { grid_square.height.should be_within(0.00001).of 1.0 }

    Then { grid_square.center.longitude.should be_within(0.00001).of -111.0 }
    Then { grid_square.center.latitude.should be_within(0.00001).of 41.5 }
  end

  context "created from field" do
    Given(:grid_square) { GridSquare.new "DN" }

    Then { grid_square.field.should == "DN" }
    Then { lambda { grid_square.square }.should raise_error(IndexError) }
    Then { lambda { grid_square.subsquare.should == "DN41bi" }.should raise_error(IndexError) }

    Then { grid_square.origin.longitude.should be_within(0.00001).of -120.0 }
    Then { grid_square.origin.latitude.should be_within(0.00001).of 40.0 }

    Then { grid_square.width.should be_within(0.00001).of 20.0 }
    Then { grid_square.height.should be_within(0.00001).of 10.0 }

    Then { grid_square.center.longitude.should be_within(0.00001).of -110.0 }
    Then { grid_square.center.latitude.should be_within(0.00001).of 45.0 }
  end
end

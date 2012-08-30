require 'spec_helper'
require_relative "../../lib/grid_square"

describe GridSquare do
  context "created from subsquare" do
    Given(:grid_square) { GridSquare.new "DN41bi" }

    Then { grid_square.field.should == "DN" }
    Then { grid_square.square.should == "DN41" }
    Then { grid_square.subsquare.should == "DN41bi" }

    Then { grid_square.origin.longitude.should be_within(0.00001).of -111.91666 }
    Then { grid_square.origin.latitude.should be_within(0.00001).of 41.33333 }

    Then { grid_square.width.should be_within(0.00001).of 0.083333 }
    Then { grid_square.height.should be_within(0.00001).of 0.041666 }

    Then { grid_square.center.longitude.should be_within(0.00001).of -111.875 }
    Then { grid_square.center.latitude.should be_within(0.00001).of 41.35416 }
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

  describe GridSquare::RadixEnumerator do
    Given(:radix) { GridSquare::RadixEnumerator.new }

    Then {
      radix.next[0].should == ?A.ord
      radix.next[0].should == "0".ord
      radix.next[0].should == ?A.ord
      radix.next[0].should == "0".ord
      radix.next[0].should == ?A.ord
      radix.next[0].should == "0".ord
      radix.next[0].should == ?A.ord
      radix.next[0].should == "0".ord
      radix.next[0].should == ?A.ord
    }

    Then {
      radix.next[1].should == 18
      radix.next[1].should == 10
      radix.next[1].should == 24
      radix.next[1].should == 10
      radix.next[1].should == 24
      radix.next[1].should == 10
      radix.next[1].should == 24
      radix.next[1].should == 10
      radix.next[1].should == 24
    }
  end

  context "created from a ridiculously long GridSquare code" do
    Given(:ludicrous) { GridSquare.new "RN91SK59MC07FQ84VK31SM03PF57XS16DU32MS24LX34EI48RQ28CS09MA87VO18GS16WK64JL24XF21KJ12FO37RJ73QL28IU39AS55HC86SW74JD70VQ61SF52QA21SD28GB60HT40SN34VG10NP11TP27CR36OA76LD28TI36JE73TF03OT41UH60IX96IH80HX45KC53SJ57AF07HQ38NI74WT84LP33UQ34OP06TV69IA96LB80VW57MV04SJ88AV74GO73JW26BF53DE74BH31EV57WP25WO98IL47BT13AD44WC66BL08IA01KN55FV05EI50KM77HV72LF21NG51XI69QW28PO80FW77AI36BE19ID25JR96KA39DA28LK83PL86TP85AH21LB31NF52BQ06WJ64AQ05XK16RJ16SP96KE85BU61BS68OK10HC39QH86XB51PO62RA27JH93PM08NF46XS98HN76LJ55KQ68AQ34JR96OF09DJ13NP76BP09AP83MK60SE83FX63OS03AG31HA46KB00QF06LU66DX71PH65WU26IF88AO21LE62DI34GF23HC34bi" }
    Then { ludicrous.subsquare.should == "RN91SK" }
  end
end

require 'spec_helper'

describe Leaflet do

  describe '.positify' do
    it 'makes negative numbers positive' do
      Leaflet.positify(-5).should == 5
    end

    it 'turns 0 to 1' do
      Leaflet.positify(0).should == 1
    end

    it 'returns 1 on non Fixnumerable objects' do
      Leaflet.positify(OpenStruct.new).should == 1
    end

    it 'chops Floats to Fixnums' do
      Leaflet.positify(5.9).should == 5
    end

    it 'sets a ceiling' do
      Leaflet.positify(30, max: 22).should == 22
    end

    it 'ignores the ceiling if the value is below it ' do
      Leaflet.positify(30, max: 35).should == 30
    end

    context 'block mode' do
      it 'makes negative numbers positive' do
        Leaflet.positify { -5 }.should == 5
      end

      it 'sets a ceiling' do
        Leaflet.positify(max: 25) { 30 }.should == 25
      end

      it 'ignores the ceiling if the value is below it ' do
        Leaflet.positify(max: 35) { 30 }.should == 30
      end
    end
  end

end

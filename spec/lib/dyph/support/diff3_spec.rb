require 'spec_helper'

describe Dyph::Support::Diff3 do
  [ Dyph::TwoWayDiffers::HeckelDiff].each do |diff2|
    let(:diff3)  { Dyph::Support::Diff3 }

    [ lambda { |x| x.to_s } , lambda { |x| x.to_sym }, lambda { |x| Fish.new(x) } ].each do |f|
      describe ".execute_diff" do
        it "should do nothing" do
          expect(diff3.execute_diff([f.call("a")], [f.call("a")], [f.call("a")], diff2)).to eq []
        end

        it "should show no conflict" do
          result = [[:no_conflict_found, 1, 1, 1, 1, 1, 1]]
          expect(diff3.execute_diff([f.call("a")], [f.call("b")], [f.call("a")], diff2)).to eq result
        end

        it "should show choose right" do
          result = [[:choose_right, 1, 1, 1, 1, 1, 1]]
          expect(diff3.execute_diff([f.call("a")], [f.call("a")], [f.call("b")], diff2)).to eq result
        end

        it "should show choose left" do
          result = [[:choose_left, 1, 1, 1, 1, 1, 1]]
          expect(diff3.execute_diff([f.call("a")], [f.call("b")], [f.call("b")], diff2)).to eq result
        end

        it "should show a conflict" do
          result = [[:possible_conflict, 1, 1, 1, 1, 1, 1]]
          expect(diff3.execute_diff([f.call("a")], [f.call("b")], [f.call("c")], diff2)).to eq result
        end
      end
    end
  end
end
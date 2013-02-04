require 'spec_helper'

module NNCore
  describe "nn_term" do

    context "given an initialized library and" do
      before(:each) { LibNanomsg.nn_init }
      after(:each) { LibNanomsg.nn_term }

      it "returns 0 for successful library termination" do
        LibNanomsg.nn_term.should be_zero
      end

    end

  end
end

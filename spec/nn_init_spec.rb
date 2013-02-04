require 'spec_helper'

module NNCore
  describe "nn_init" do

    it "returns 0 for successful library initialization" do
      LibNanomsg.nn_init.should be_zero
    end

  end
end

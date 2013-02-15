require 'spec_helper'

module NNCore
  describe "nn_close" do

    context "given an initialized library and" do

      context "given a valid socket" do
        before(:each) { @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB) }

        it "returns 0" do
          LibNanomsg.nn_close(@socket).should be_zero
        end

      end

      context "given an invalid file descriptor" do

        it "returns -1 and sets nn_errno to EBADF" do
          LibNanomsg.nn_close(0).should == -1
          LibNanomsg.nn_errno.should == EBADF
        end

      end

    end
  end
end

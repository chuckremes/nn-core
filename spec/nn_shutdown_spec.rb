require 'spec_helper'

module NNCore
  describe "nn_shutdown" do

    context "given an initialized library and" do

      context "given a valid socket and" do
        before(:each) do
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB)
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
        end

        context "given a valid endpoint" do
          before(:each) do
            @endpoint = LibNanomsg.nn_bind(@socket, "inproc://some_endpoint")
          end

          it "returns 0" do
            rc = LibNanomsg.nn_shutdown(@socket, @endpoint)
            rc.should == 0
          end
        end

        context "given an invalid endpoint" do
          it "returns -1 and set nn_errno to EINVAL" do
            rc = LibNanomsg.nn_shutdown(@socket, 0)
            rc.should == -1
            LibNanomsg.nn_errno.should == EINVAL
          end
        end
      end

      context "given an invalid socket" do

        it "returns -1 and sets nn_errno to EBADF" do
          rc = LibNanomsg.nn_shutdown(0, 0)
          rc.should == -1
          LibNanomsg.nn_errno.should == EBADF
        end

      end

    end
  end
end

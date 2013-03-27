require 'spec_helper'

module NNCore
  describe "nn_term" do

    context "given an initialized library and" do

      context "given a valid socket" do
        before(:each) do
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB)
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
        end

        it "makes subsequent calls to nn_send fail with ETERM" do
          LibNanomsg.nn_term
          rc = LibNanomsg.nn_send(0, "ABC", 3, 0)
          rc.should == -1
          LibNanomsg.nn_errno.should == ETERM
        end

#        it "makes subsequent calls to nn_recv fail with ETERM" do
#          LibNanomsg.nn_term
#          buffer = FFI::MemoryPointer.new(:pointer)
#          rc = LibNanomsg.nn_recv(@socket, buffer, NN_MSG, 0)
#          rc.should == -1
#          LibNanomsg.nn_errno.should == ETERM
#        end
      end

    end
  end
end

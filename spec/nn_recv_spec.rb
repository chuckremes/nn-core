require 'spec_helper'

module NNCore
  describe "nn_recv" do

    context "given an initialized library and" do
      before(:each) { LibNanomsg.nn_init }
      after(:each) { LibNanomsg.nn_term }


      context "given a valid connected sender and receiver socket pair" do
        before(:each) do
          LibNanomsg.nn_init
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PAIR)
          @sender = LibNanomsg.nn_socket(AF_SP, NN_PAIR)
          @endpoint = LibNanomsg.nn_bind(@socket, "inproc://some_endpoint")
          LibNanomsg.nn_connect(@sender, "inproc://some_endpoint")
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
          LibNanomsg.nn_close(@sender)
          LibNanomsg.nn_term
        end

        context "given a pre-allocated buffer" do

          it "returns the number of bytes received" do
            string = "ABC"
            LibNanomsg.nn_send(@sender, string, string.size, 0)
            
            buffer = FFI::MemoryPointer.new(5)
            nbytes = LibNanomsg.nn_recv(@socket, buffer, 5, 0)
            nbytes.should == 3
            buffer.read_string.should == string
          end
        end
        
        context "given no pre-allocated buffer" do
          

          it "returns the number of bytes received and returns the buffer" do
            string = "ABC"
            LibNanomsg.nn_send(@sender, string, string.size, 0)
            
            buffer = FFI::MemoryPointer.new(:pointer)
            nbytes = LibNanomsg.nn_recv(@socket, buffer, NN_MSG, 0)
            nbytes.should == 3
            buffer.get_pointer(0).read_string.should == string
          end
        end
      end

      context "given an invalid socket" do

        it "returns -1 and sets nn_errno to EBADF" do
          rc = LibNanomsg.nn_send(0, "ABC", 3, 0)
          rc.should == -1
          LibNanomsg.nn_errno.should == EBADF
        end

      end

    end
  end
end

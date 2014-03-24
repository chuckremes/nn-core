require 'spec_helper'

module NNCore
  describe "nn_poll" do

    context "given an initialized library and" do

      context "given a valid socket" do
        before(:each) do
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB)
          @endpoint = LibNanomsg.nn_bind(@socket, "inproc://some_endpoint")
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
        end

        it "returns a non-zero number of signaled events" do
          pointer = FFI::MemoryPointer.new(NNCore::LibNanomsg::NNPollFd, 1)
          struct = NNCore::LibNanomsg::NNPollFd.new(pointer)
          struct.fd = @socket
          struct.events = 2
          result = LibNanomsg.nn_poll(pointer, 1, 1000)

          expect(result).to be > 0
        end

      end

    end
  end
end

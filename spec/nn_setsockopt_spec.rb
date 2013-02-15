require 'spec_helper'

module NNCore
  describe "nn_setsockopt" do

    context "given an initialized library and" do

      context "given a valid socket" do
        before(:each) do
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB)
          @option = FFI::MemoryPointer.new(:int32)
          @size = FFI::MemoryPointer.new :size_t
          @size.write_int(4)
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
        end

        SOCKET_OPTIONS.keys.each do |socket_option|

          it "#{socket_option} overrides the default" do
            @option.write_int(10)
            rc = LibNanomsg.nn_setsockopt(@socket, NN_SOL_SOCKET, SOCKET_OPTIONS[socket_option], @option, 4)
            rc.should == 0
            rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, SOCKET_OPTIONS[socket_option], @option, @size)
            rc.should == 0

            @option.read_int.should == 10
          end
        end


        context "given an unsupported socket level" do

          SOCKET_OPTIONS.keys.each do |socket_option|
            it "socket option #{socket_option} returns -1 and set nn_errno to EBADF" do
              option = FFI::MemoryPointer.new(:int32)

              rc = LibNanomsg.nn_setsockopt(@socket, 100, SOCKET_OPTIONS[socket_option], option, 4)
              rc.should == -1
              LibNanomsg.nn_errno.should == ENOPROTOOPT
            end
          end

        end

      end

      context "given a bad socket file descriptor" do

        SOCKET_OPTIONS.keys.each do |socket_option|
          it "socket option #{socket_option} returns -1 and set nn_errno to EBADF" do
            option = FFI::MemoryPointer.new(:int32)
            size = FFI::MemoryPointer.new :size_t
            size.write_int(4)

            rc = LibNanomsg.nn_getsockopt(0, NN_SOL_SOCKET, SOCKET_OPTIONS[socket_option], option, size)
            rc.should == -1
            LibNanomsg.nn_errno.should == EBADF
          end
        end
      end

    end
  end
end

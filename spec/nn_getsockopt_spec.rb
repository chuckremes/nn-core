require 'spec_helper'

module NNCore
  describe "nn_getsockopt" do

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

        it "NN_LINGER returns a default of 1000" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_LINGER, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(1000)
        end

        it "NN_SNDBUF returns a default of 128KB" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_SNDBUF, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(131072)
        end

        it "NN_RCVBUF returns a default of 128KB" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_RCVBUF, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(131072)
        end

        it "NN_SNDTIMEO returns a default of -1" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_SNDTIMEO, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(-1)
        end

        it "NN_RCVTIMEO returns a default of -1" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_RCVTIMEO, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(-1)
        end

        it "NN_RECONNECT_IVL returns a default of 100 (units are milliseconds)" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_RECONNECT_IVL, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(100)
        end

        it "NN_RECONNECT_IVL_MAX returns a default of 0 (units are milliseconds)" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_RECONNECT_IVL_MAX, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(0)
        end

        it "NN_SNDPRIO returns a default of 8" do
          rc = LibNanomsg.nn_getsockopt(@socket, NN_SOL_SOCKET, NN_SNDPRIO, @option, @size)
          expect(rc).to eq(0)
          expect(@option.read_int).to eq(8)
        end


        context "given an unsupported socket level" do

          SOCKET_OPTIONS.keys.each do |socket_option|
            it "socket option #{socket_option} returns -1 and set nn_errno to EBADF" do
              option = FFI::MemoryPointer.new(:int32)
              size = FFI::MemoryPointer.new :size_t
              size.write_int(4)

              rc = LibNanomsg.nn_getsockopt(@socket, 100, SOCKET_OPTIONS[socket_option], option, size)
              expect(rc).to eq(-1)
              expect(LibNanomsg.nn_errno).to eq(ENOPROTOOPT)
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
            expect(rc).to eq(-1)
            expect(LibNanomsg.nn_errno).to eq(EBADF)
          end
        end
      end

    end
  end
end

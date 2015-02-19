require 'spec_helper'

module NNCore
  describe "nn_bind" do

    context "given an initialized library and" do

      context "given a valid socket" do
        before(:each) do
          @socket = LibNanomsg.nn_socket(AF_SP, NN_PUB)
        end

        after(:each) do
          LibNanomsg.nn_close(@socket)
        end

        it "returns a non-zero endpoint number for a valid INPROC address" do
          rc = LibNanomsg.nn_bind(@socket, "inproc://some_address")
          expect(rc).to be > 0
        end

        it "returns a non-zero endpoint number for a valid IPC address" do
          rc = LibNanomsg.nn_bind(@socket, "ipc:///tmp/some_address")
          expect(rc).to be > 0
        end

        it "returns a non-zero endpoint number for a valid TCP address" do
          rc = LibNanomsg.nn_bind(@socket, "tcp://127.0.0.1:5555")
          expect(rc).to be > 0
        end

        it "returns -1 for an invalid INPROC address" do
          rc = LibNanomsg.nn_bind(@socket, "inproc:/missing_first_slash")
          errno = LibNanomsg.nn_errno
          expect(rc).to eq(-1)
          expect(errno).to eq(EINVAL)
        end

        it "returns -1 for an invalid INPROC address (too long)" do
          rc = LibNanomsg.nn_bind(@socket, "inproc://#{'a' * (NN_SOCKADDR_MAX + 1)}")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(ENAMETOOLONG)
        end

        it "returns -1 for an invalid IPC address" do
          rc = LibNanomsg.nn_bind(@socket, "ipc:/missing_slashes)")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EINVAL)
        end

        it "returns -1 for an invalid TCP address (missing address)" do
          rc = LibNanomsg.nn_bind(@socket, "tcp://")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EINVAL)
        end

        it "returns -1 for an invalid TCP address (non-numeric port)" do
          rc = LibNanomsg.nn_bind(@socket, "tcp://192.168.0.1:port")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EINVAL)
        end

        it "returns -1 for an invalid TCP address (port number is out of range)" do
          rc = LibNanomsg.nn_bind(@socket, "tcp://192.168.0.1:65536")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EINVAL)
        end

        it "returns -1 for an unsupported transport protocol" do
          rc = LibNanomsg.nn_bind(@socket, "zmq://192.168.0.1:65536")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EPROTONOSUPPORT)
        end

        it "returns -1 for specifying a non-existent device using TCP transport" do
          rc = LibNanomsg.nn_bind(@socket, "tcp://eth5:5555")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(ENODEV)
        end

        it "returns -1 when binding to an existing endpoint" do
          rc = LibNanomsg.nn_bind(@socket, "inproc://some_endpoint")
          rc = LibNanomsg.nn_bind(@socket, "inproc://some_endpoint")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EADDRINUSE)
        end

      end

      context "given an invalid file descriptor" do

        it "returns -1 and sets nn_errno to EBADF" do
          rc = LibNanomsg.nn_bind(0, "inproc://some_endpoint")
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EBADF)
        end

      end

    end
  end
end

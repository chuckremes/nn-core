require 'spec_helper'

module NNCore
  describe "nn_send" do

    context "given an initialized library and" do

      context "given a valid socket" do
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

          it "returns the number of bytes sent" do
            nbytes = LibNanomsg.nn_send(@socket, "ABC", 3, 0)
            expect(nbytes).to eq(3)
          end
        end

        context "disconnected from all endpoints" do
          it "returns the number of bytes queued" do
            nbytes = LibNanomsg.nn_send(@socket, "ABC", 3, 0)
            expect(nbytes).to eq(3)
          end
        end
      end

      context "given an invalid socket" do

        it "returns -1 and sets nn_errno to EBADF" do
          rc = LibNanomsg.nn_send(0, "ABC", 3, 0)
          expect(rc).to eq(-1)
          expect(LibNanomsg.nn_errno).to eq(EBADF)
        end

      end

    end
  end
end

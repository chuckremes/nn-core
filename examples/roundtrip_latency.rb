begin
  require 'nn-core'
rescue LoadError
  $: << File.join(File.dirname(__FILE__), '..', 'lib')
  retry
end


# Within a single process, we start up two threads. One thread has a REQ (request)
# socket and the second thread has a REP (reply) socket. We measure the
# *round-trip* latency between these sockets. Only *one* message is in flight at
# any given moment.
#
#  % ruby roundtrip_latency.rb tcp://127.0.0.1:5555 1024 1_000_000
#
#  % ruby roundtrip_latency.rb inproc://lm_sock 1024 1_000_000
#

if ARGV.length < 3
  puts "usage: ruby roundtrip_latency.rb <connect-to> <message-size> <roundtrip-count>"
  exit
end

link = ARGV[0]
message_size = ARGV[1].to_i
roundtrip_count = ARGV[2].to_i

def set_signal_handler(receiver, transmitter)
  trap(:INT) do
    puts "got ctrl-c"
    receiver.terminate
    transmitter.terminate
  end
end

class Node
  def initialize(endpoint, size, count)
    @endpoint = endpoint
    @size = size
    @count = count
    @msg = 'a' * @size

    @rcv_buffer = FFI::MemoryPointer.new(@size)

    allocate_socket
    setup_socket
    set_endpoint
  end

  def setup_socket
    option = FFI::MemoryPointer.new(:int32)

    # LINGER
    option.write_int(100)
    rc = NNCore::LibNanomsg.nn_setsockopt(@socket, NNCore::NN_SOL_SOCKET, NNCore::NN_LINGER, option, 4)
    assert(rc)

    # SNDBUF
    option.write_int(131072)
    rc = NNCore::LibNanomsg.nn_setsockopt(@socket, NNCore::NN_SOL_SOCKET, NNCore::NN_SNDBUF, option, 4)
    assert(rc)

    # RCVBUF
    option.write_int(131072)
    rc = NNCore::LibNanomsg.nn_setsockopt(@socket, NNCore::NN_SOL_SOCKET, NNCore::NN_RCVBUF, option, 4)
    assert(rc)
  end

  def send_msg
    nbytes = NNCore::LibNanomsg.nn_send(@socket, @msg, @size, 0)
    assert(nbytes)
    nbytes
  end

  def recv_msg
    nbytes = NNCore::LibNanomsg.nn_recv(@socket, @rcv_buffer, @size, 0)
    assert(nbytes)
    nbytes
  end

  def terminate
    assert(NNCore::LibNanomsg.nn_close(@socket))
  end

  def assert(rc)
    raise "Last API call failed at #{caller(1)}" unless rc >= 0
  end
end

class Receiver < Node
  def allocate_socket
    @socket = NNCore::LibNanomsg.nn_socket(NNCore::AF_SP, NNCore::NN_REP)
    assert(@socket)
  end

  def set_endpoint
    assert(NNCore::LibNanomsg.nn_bind(@socket, @endpoint))
  end

  def run
    @count.times do
      nbytes = recv_msg

      raise "Message size doesn't match, expected [#{@size}] but received [#{string.size}]" if @size != nbytes

      send_msg
    end

    terminate
  end
end

class Transmitter < Node
  def allocate_socket
    @socket = NNCore::LibNanomsg.nn_socket(NNCore::AF_SP, NNCore::NN_REQ)
    assert(@socket)
  end

  def set_endpoint
    assert(NNCore::LibNanomsg.nn_connect(@socket, @endpoint))
  end

  def run
    elapsed = elapsed_microseconds do
      @count.times do
        send_msg

        nbytes = recv_msg

        raise "Message size doesn't match, expected [#{@size}] but received [#{nbytes}]" if @size != nbytes
      end
    end

    latency = elapsed / @count / 2

    puts "message size: %i [B]" % @size
    puts "roundtrip count: %i" % @count
    puts "throughput (msgs/s): %i" % (@count / (elapsed / 1_000_000))
    puts "mean latency: %.3f [us]" % latency
    terminate
  end

  def elapsed_microseconds(&blk)
    start = Time.now
    yield
    value = ((Time.now - start) * 1_000_000)
  end
end

threads = []
receiver = transmitter = nil

threads << Thread.new do
  receiver = Receiver.new(link, message_size, roundtrip_count)
  receiver.run
end

sleep 1

threads << Thread.new do
  transmitter = Transmitter.new(link, message_size, roundtrip_count)
  transmitter.run
end

set_signal_handler(receiver, transmitter)

threads.each {|t| t.join}

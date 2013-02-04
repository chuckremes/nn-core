require 'bundler/setup'
require 'nn-core'

module NNCore
  SOCKET_OPTIONS = {
    :NN_LINGER => NN_LINGER,
    :NN_SNDBUF => NN_SNDBUF,
    :NN_RCVBUF => NN_RCVBUF,
    :NN_SENDTIMEO => NN_SNDTIMEO,
    :NN_RCVTIMEO => NN_RCVTIMEO,
    :NN_RECONNECT_IVL => NN_RECONNECT_IVL,
    :NN_RECONNECT_IVL_MAX => NN_RECONNECT_IVL_MAX,
    :NN_SNDPRIO => NN_SNDPRIO
  }
  
  PROTOCOLS = {
    :NN_PUB => NN_PUB,
    :NN_SUB => NN_SUB
  }
  
  ADDRESS_FAMILIES = {
    :AF_SP => AF_SP,
    :AF_SP_RAW => AF_SP_RAW
  }
end

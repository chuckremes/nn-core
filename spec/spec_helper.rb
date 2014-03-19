require 'bundler/setup'
require 'nn-core'

module NNCore
  SOCKET_OPTIONS = {
    :NN_LINGER => NN_LINGER,
    :NN_SNDBUF => NN_SNDBUF,
    :NN_RCVBUF => NN_RCVBUF,
    :NN_SNDTIMEO => NN_SNDTIMEO,
    :NN_RCVTIMEO => NN_RCVTIMEO,
    :NN_RECONNECT_IVL => NN_RECONNECT_IVL,
    :NN_RECONNECT_IVL_MAX => NN_RECONNECT_IVL_MAX,
    :NN_SNDPRIO => NN_SNDPRIO
  }
  
  PROTOCOLS = {
    :NN_PUB => NN_PUB,
    :NN_SUB => NN_SUB,
    :NN_BUS => NN_BUS,
    :NN_PAIR => NN_PAIR,
    :NN_REQ => NN_REQ,
    :NN_REP => NN_REP,
    :NN_PUSH => NN_PUSH,
    :NN_PULL => NN_PULL,
    :NN_SURVEYOR => NN_SURVEYOR,
    :NN_RESPONDENT => NN_RESPONDENT
  }
  
  ADDRESS_FAMILIES = {
    :AF_SP => AF_SP,
    :AF_SP_RAW => AF_SP_RAW
  }
  
  # Some protocols support the AF_SP_RAW address family, so we need to skip those
  # tests that are expecting a failure.
  RAW_UNSUPPORTED = []
end

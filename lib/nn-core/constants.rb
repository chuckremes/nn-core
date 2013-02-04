module NNCore
  NN_HAUSNUMERO = 156384712

  # SP address families
  AF_SP = 1
  AF_SP_RAW = 2

  # Transport types
  NN_INPROC = -1
  NN_IPC = -2
  NN_TCP = -3

  # Protocols
  NN_PAIR_ID = 1
  NN_PAIR = (NN_PAIR_ID * 16 + 0)

  NN_PUBSUB_ID = 2
  NN_PUB = (NN_PUBSUB_ID * 16 + 0)
  NN_SUB = (NN_PUBSUB_ID * 16 + 1)

  NN_REQREP_ID = 3
  NN_REQ = (NN_REQREP_ID * 16 + 0)
  NN_REP = (NN_REQREP_ID * 16 + 1)

  NN_FANIN_ID = 4
  NN_SOURCE = (NN_FANIN_ID * 16 + 0)
  NN_SINK = (NN_FANIN_ID * 16 + 1)
  NN_FANOUT_ID = 5
  NN_PUSH = (NN_FANOUT_ID * 16 + 0)
  NN_PULL = (NN_FANOUT_ID * 16 + 1)

  NN_SURVEY_ID = 6
  NN_SURVEYOR = (NN_SURVEY_ID * 16 + 0)
  NN_RESPONDENT = (NN_SURVEY_ID * 16 + 1)

  # Socket Option Levels (SOL)
  NN_SOL_SOCKET = 0

  # Socket options
  NN_LINGER = 1
  NN_SNDBUF = 2
  NN_RCVBUF = 3
  NN_SNDTIMEO = 4
  NN_RCVTIMEO = 5
  NN_RECONNECT_IVL = 6
  NN_RECONNECT_IVL_MAX = 7
  NN_SNDPRIO = 8
  #NN_SNDFD = 10
  #NN_RCVFD = 11

  # Send/recv options
  NN_DONTWAIT = 1
  NN_MSG = -1

  # Socket errors
  ENOTSUP = Errno::ENOTSUP::Errno rescue NN_HAUSNUMERO + 1
  EPROTONOSUPPORT = Errno::EPROTONOSUPPORT::Errno rescue NN_HAUSNUMERO + 2
  ENOBUFS = Errno::ENOBUFS::Errno rescue NN_HAUSNUMERO + 3
  ENETDOWN = Errno::ENETDOWN::Errnow rescue NN_HAUSNUMERO + 4
  EADDRINUSE = Errno::EADDRINUSE::Errno rescue NN_HAUSNUMERO + 5
  EADDRNOTAVAIL = Errno::EADDRNOTAVAIL::Errno rescue NN_HAUSNUMERO + 6
  ECONNREFUSED = Errno::ECONNREFUSED::Errno rescue NN_HAUSNUMERO + 7
  EINPROGRESS = Errno::EINPROGRESS::Errno rescue NN_HAUSNUMERO + 8
  ENOTSOCK = Errno::ENOTSOCK::Errno rescue NN_HAUSNUMERO + 9
  EAFNOSUPPORT = Errno::EAFNOSUPPORT::Errno rescue NN_HAUSNUMERO + 10
  EPROTO = Errno::EPROTO::Errno rescue NN_HAUSNUMERO + 11
  
  ETIMEDOUT = Errno::ETIMEDOUT::Errno
  EAGAIN = Errno::EAGAIN::Errno
  EINVAL = Errno::EINVAL::Errno
  ENOMEM = Errno::ENOMEM::Errno
  ENODEV = Errno::ENODEV::Errno
  EFAULT = Errno::EFAULT::Errno
  #  EINTR  = Errno::EINTR::Errno
  EBADF = Errno::EBADF::Errno
  ENOPROTOOPT = Errno::ENOPROTOOPT::Errno
  ENAMETOOLONG = Errno::ENAMETOOLONG::Errno

  # Library errors
  ETERM = Errno::ETERM::Errno rescue NN_HAUSNUMERO + 53
  EFSM = Errno::EFSM::Errno rescue NN_HAUSNUMERO + 54

  # Miscellaneous
  NN_INPROCB_NAMELEN_MAX = 64
end

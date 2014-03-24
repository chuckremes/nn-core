module NNCore
  module LibNanomsg

    # Structs for working with raw buffers (not recommended)
    module NNIOVecLayout
      def self.included(base)
        base.class_eval do
          layout :iov_base,  :pointer,
            :iov_len,    :size_t
        end
      end
    end

    class NNIOVec < FFI::Struct
      include NNIOVecLayout

      def iov_base
        self[:iov_base]
      end

      def iov_base=(pointer)
        self[:iov_base] = pointer
      end

      def iov_len
        self[:iov_len]
      end

      def iov_len=(length)
        self[:iov_len] = length
      end
    end

    module NNMsgHdrLayout
      def self.included(base)
        base.class_eval do
          layout :msg_iov, NNIOVec.ptr,
          :msg_iovlen, :int,
          :msg_control, :pointer,
          :msg_controllen, :size_t
        end
      end
    end

    class NNMsgHdr < FFI::Struct
      include NNMsgHdrLayout

      def msg_iov
        self[:msg_iov]
      end

      def msg_iov=(structure)
        self[:msg_iov] = structure
      end

      def msg_iovlen
        self[:msg_iovlen]
      end

      def msg_iovlen=(length)
        self[:msg_iovlen] = length
      end

      def msg_control
        self[:msg_control]
      end

      def msg_control=(pointer)
        self[:msg_control] = pointer
      end

      def msg_controllen
        self[:msg_controllen]
      end

      def msg_controllen=(value)
        self[:msg_controllen] = value
      end
    end
    
    module NNCMsgHdrLayout
      def self.included(base)
        base.class_eval do
          layout :cmsg_len, :size_t,
          :cmsg_level, :int,
          :cmsg_type, :int
        end
      end
    end

    class NNCMsgHdr < FFI::Struct
      include NNCMsgHdrLayout

      def cmsg_len
        self[:cmsg_len]
      end

      def cmsg_len=(length)
        self[:csmg_len] = length
      end

      def cmsg_level
        self[:cmsg_level]
      end

      def cmsg_level=(level)
        self[:cmsg_level] = level
      end

      def cmsg_type
        self[:cmsg_type]
      end

      def cmsg_type=(type)
        self[:cmsg_type] = type
      end
    end

  end
end

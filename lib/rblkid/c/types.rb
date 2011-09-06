#--
# Copyleft shura. [ shura1991@gmail.com ]
#
# This file is part of rblkid.
#
# rblkid is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# rblkid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with rblkid. If not, see <http://www.gnu.org/licenses/>.
#++

require 'rblkid/c'

module BlkID
  module C
    module Bool
      extend FFI::DataConverter
      native_type FFI::Type::INT

      def self.to_native(value, ctx)
        [0, false, nil].include?(value) ? 0 : 1
      end

      def self.from_native(value, ctx)
        !value.zero?
      end
    end

    module BlkIDBool
      extend FFI::DataConverter
      native_type FFI::Type::INT

      def self.to_native (value, ctx)
        [0, false, nil].include?(value) ? 1 : 0
      end

      def self.from_native (value, ctx)
        value.zero?
      end
    end

    FFI.typedef(Bool, :bool)
    FFI.typedef(BlkIDBool, :blkid_bool)
    FFI.typedef(:int64, :blkid_loff_t)

    class ListHead < FFI::Struct
      layout \
        :next,  :pointer,
        :prev,  :pointer
    end

    class BlkIDCache < FFI::Struct
      layout \
        :bic_devs,      ListHead,
        :bic_tags,      ListHead,
        :bic_time,      :time_t,
        :bic_ftime,     :time_t,
        :bic_flags,     :uint,
        :bic_filename,  :pointer
    end

    class BlkIDDev < FFI::Struct
      layout \
        :bid_devs,  ListHead,
        :bid_tags,  ListHead,
        :bid_cache, BlkIDCache,
        :bid_name,  :pointer,
        :bid_type,  :pointer,
        :bid_pri,   :int,
        :bid_devno, :dev_t,
        :bid_time,  :time_t,
        :bid_flags, :uint,
        :bid_label, :pointer,
        :bid_uuid,  :pointer
    end

    class BlkIDTag < FFI::Struct
      layout \
        :bit_tags,  ListHead,
        :bit_names, ListHead,
        :bit_name,  :pointer,
        :bit_val,   :pointer,
        :bit_dev,   BlkIDDev
    end

    class BlkIDDevIterate < FFI::Struct
      layout \
        :magic,         :int,
        :cache,         BlkIDCache,
        :search_type,   :pointer,
        :search_value,  :pointer,
        :p,             :pointer
    end

    class BlkIDTagIterate < FFI::Struct
      layout \
        :magic, :int,
        :dev,   BlkIDDev,
        :p,     :pointer
    end

    class BlkIDIdMag < FFI::Struct
      layout \
        :magic, :pointer,
        :len,   :uint,
        :kboff, :long,
        :sboff, :uint
    end

    class BlkIDPrVal < FFI::Struct
      layout \
        :name,  :pointer,
        :data,  :pointer,
        :len,   :uint,
        :chain, :pointer
    end

    class BlkIDProbe < FFI::Struct
    end

    callback :probefunccb, [BlkIDProbe, BlkIDIdMag], :int

    class BlkIDIdInfo < FFI::Struct
      layout \
        :name,      :pointer,
        :usage,     :int,
        :flags,     :int,
        :minsz,     :int,
        :probefunc, :probefunccb,
        :magics,    :pointer
    end

    callback :probecb, [BlkIDProbe, :pointer], :int
    callback :safeprobecb, [BlkIDProbe, :pointer], :int
    callback :free_datacb, [BlkIDProbe, :pointer], :void

    class BlkIDChainDrv < FFI::Struct
      layout \
        :id,            :int,
        :name,          :string,
        :dflt_flags,    :int,
        :dflt_enabled,  :int,
        :has_fltr,      :int,
        :idinfos,       :pointer,
        :nidinfos,      :uint,
        :probe,         :probecb,
        :safeprobe,     :safeprobecb,
        :free_data,     :free_datacb
    end

    class BlkIDChain < FFI::Struct
      layout \
        :driver,  :pointer,
        :enabled, :int,
        :flags,   :int,
        :binary,  :int,
        :idx,     :int,
        :fltr,    :ulong,
        :data,    :pointer
    end

    class BlkIDProbe
      layout \
        :fd,          :int,
        :off,         :blkid_loff_t,
        :size,        :blkid_loff_t,
        :devno,       :dev_t,
        :disk_devno,  :dev_t,
        :blkssz,      :uint,
        :mode,        :mode_t,
        :flags,       :int,
        :prob_flags,  :int,
        :wipe_off,    :blkid_loff_t,
        :wipe_size,   :blkid_loff_t,
        :wipe_chain,  :pointer,
        :buffers,     ListHead,
        :chains,      [BlkIDChain, BlkID::BLKID_NCHAINS],
        :cur_chain,   :pointer,
        :vals,        [BlkIDPrVal, BlkID::BLKID_NVALS],
        :nvals,       :int
    end

    class BlkIDPartition < FFI::Struct
      layout \
        :start,   :blkid_loff_t,
        :size,    :blkid_loff_t,
        :type,    :int,
        :typestr, [:char, 37],
        :flags,   :ulong_long,
        :partno,  :int,
        :uuid,    [:char, 37],
        :name,    [:uchar, 128]
    end

    class BlkIDPartTable < FFI::Struct
      layout \
        :type,    :pointer,
        :offset,  :blkid_loff_t,
        :nparts,  :int,
        :parent,  BlkIDPartition,
        :t_tabs,  ListHead
    end

    class BlkIDPartList < FFI::Struct
      layout \
        :next_partno, :int,
        :next_parent, BlkIDPartition,
        :nparts,      :int,
        :nparts_max,  :int,
        :parts,       BlkIDPartition,
        :l_tabs,      ListHead
    end

    class BlkIDTopology < FFI::Struct
      layout \
        :alignment_offset,      :ulong,
        :minimum_io_size,       :ulong,
        :optimal_io_size,       :ulong,
        :logical_sector_size,   :ulong,
        :physical_sector_size,  :ulong
    end
  end
end

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

require 'rblkid/constants'
require 'rblkid/c'

require 'rblkid/dev'
require 'rblkid/cache'
require 'rblkid/dev_iterate'
require 'rblkid/partition'
require 'rblkid/partlist'
require 'rblkid/parttable'
require 'rblkid/probe'
require 'rblkid/tag_iterate'
require 'rblkid/topology'

module BlkID
  class << self
    def evaluate_tag (token, value, cache=nil)
      cache = cache.ptr if cache.is_a?(BlkID::Cache)

      BlkID::C.blkid_evaluate_tag(token, value, cache)
    end

    def evaluate_spec(spec, cache=nil)
      cache = cache.ptr if cache.is_a?(BlkID::Cache)

      BlkID::C.evaluate_spec(spec, cache)
    end

    def known_fstype? (fstype)
      BlkID::C.blkid_known_fstype(fstype)
    end

    def name (idx)
      name = FFI::MemoryPointer.new(:string)
      usage = FFI::MemoryPointer.new(:int)

      BlkID::C.blkid_superblocks_get_name(idx, FFI::MemoryPointer.new(:pointer).write_pointer(name), usage).tap {|res|
        break [name.read_string, usage.read_int] if res
      }
    end

    def filter_superblocks_type (flag, names)
      n = FFI::MemoryPointer.new(:pointer, names.size + 1)
      names.each_with_index {|s, i|
        n[i].put_pointer(0, FFI::MemoryPointer.from_string(s))
      }
      n[names.size].put_pointer(0, nil)

      BlkID::C.blkid_probe_filter_superblocks_type(@struct, flag, n)
    end

    def filter_superblocks_usage (flag, usage)
      BlkID::C.blkid_probe_filter_superblocks_usage(@struct, flag, usage)
    end

    def invert_superblocks_filter
      BlkID::C.blkid_probe_invert_superblocks_filter(@struct)
    end

    def reset_superblocks_filter
      BlkID::C.blkid_probe_reset_superblocks_filter(@struct)
    end

    def superblocks_flags= (flags)
      BlkID::C.blkid_probe_set_superblocks_flags(@struct, flags)
    end

    def partitions= (bool)
      BlkID::C.blkid_probe_enable_partitions(@struct, bool)
    end

    def partitions_flags= (flags)
      BlkID::C.blkid_probe_set_partitions_flags(@struct, flags)
    end

    def filter_partitions_type (flag, names)
      n = FFI::MemoryPointer.new(:pointer, names.size + 1)
      names.each_with_index {|s, i|
        n[i].put_pointer(0, FFI::MemoryPointer.from_string(s))
      }
      n[names.size].put_pointer(0, nil)

      BlkID::C.blkid_probe_filter_partitions_type(@struct, flag, n)
    end

    def invert_partitions_filter
      BlkID::C.blkid_probe_invert_partitions_filter(@struct)
    end

    def reset_partitions_filter
      BlkID::C.blkid_probe_reset_partitions_filter(@struct)
    end

    def known_pttype? (pttype)
      BlkID::C.blkid_known_pttype(pttype)
    end

    def devno_to_devname (devno)
      BlkID::C.blkid_devno_to_devname(devno)
    end

    def devno_to_wholedisk (dev)
      diskdevno = FFI::MemoryPointer.new(:ulong, 1)
      BlkID::C.blkid_devno_to_wholedisk(dev, nil, 0, diskdevno)
      diskdevno.read_ulong
    end

    def dev_size (fd)
      BlkID::C.blkid_get_dev_size(fd)
    end

    def send_uevent (devname, action)
      BlkID::C.blkid_send_uevent(devname, action)
    end
  end
end

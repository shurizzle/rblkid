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
require 'rblkid/partlist'
require 'rblkid/topology'

module BlkID
  class Probe
    def self.from_filename (filename)
      allocate.tap {|o| o.instance_eval {
        @struct = BlkID::C.blkid_new_probe_from_filename(filename)
        ObjectSpace.define_finalizer(self, method(:finalize))
      }}
    end

    def initialize
      @struct = BlkID::C.blkid_new_probe

      ObjectSpace.define_finalizer(self, method(:finalize))
    end

    def finalize
      BlkID::C.blkid_free_probe(@struct)
    end

    def devno
      BlkID::C.blkid_probe_get_devno(@struct)
    end

    def fd
      BlkID::C.blkid_probe_get_fd(@struct)
    end
    alias to_i fd

    def sector_size
      BlkID::C.blkid_probe_get_sectorsize(@struct)
    end

    def sectors
      BlkID::C.blkid_probe_get_sectors(@struct)
    end

    def size
      BlkID::C.blkid_probe_get_size(@struct)
    end

    def offset
      BlkID::C.blkid_probe_get_offset(@struct)
    end

    def wholedisk_devno
      BlkID::C.blkid_probe_get_wholedisk_devno(@struct)
    end

    def set_device (fd, off, size)
      BlkID::C.blkid_probe_set_device(@struct, fd, off, size)
    end

    def wholedisk?
      BlkID::C.blkid_probe_is_wholedisk(@struct)
    end

    def reset
      BlkID::C.blkid_reset_probe(@struct)
      self
    end

    def fullprobe
      BlkID::C.blkid_do_fullprobe(@struct)
    end

    def probe
      BlkID::C.blkid_do_probe(@struct)
    end

    def safeprobe
      BlkID::C.blkid_do_safeprobe(@struct)
    end

    def value (num)
      name = FFI::MemoryPointer.new(:string)
      data = FFI::MemoryPointer.new(:string)

      BlkID::C.blkid_probe_get_value(@struct, num,
                                     FFI::MemoryPointer.new(:pointer).write_pointer(name),
                                     FFI::MemoryPointer.new(:pointer).write_pointer(data),
                                     nil)
      [name.read_string, data.read_string]
    end

    def has_value? (name)
      BlkID::C.blkid_probe_has_value(@struct, name)
    end
    alias value? has_value?

    def lookup_value (name)
      data = FFI::MemoryPointer.new(:string)
      BlkID::C.blkid_probe_lookup_value(@struct, name,
                                        FFI::MemoryPointer.new(:pointer).write_pointer(data),
                                        nil)
      data.read_string
    end

    def numof_values
      BlkID::C.blkid_probe_numof_values(@struct)
    end

    def superblocks= (bool)
      BlkID::C.blkid_probe_enable_superblocks(@struct, bool)
    end

    def partitions
      PartList.new(BlkID::C.blkid_probe_get_partitions(@struct))
    end

    def topology= (bool)
      BlkID::C.blkid_probe_enable_topology(@struct, bool)
    end

    def topology
      Topology.new(BlkID::C.blkid_probe_get_topology(@struct))
    end

    def to_ffi
      @struct
    end
  end
end

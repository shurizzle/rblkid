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
require 'rblkid/parttable'

module BlkID
  class Partition
    def initialize (struct)
      @struct = struct
    end

    def name
      BlkID::C.blkid_partition_get_name(@struct)
    end

    def flags
      BlkID::C.blkid_partition_get_flags(@struct)
    end

    def partno
      BlkID::C.blkid_partition_get_partno(@struct)
    end

    def size
      BlkID::C.blkid_partition_get_size(@struct)
    end

    def start
      BlkID::C.blkid_partition_get_start(@struct)
    end

    def table
      PartTable.new(BlkID::C.blkid_partition_get_table(@struct))
    end

    def type
      BlkID::C.blkid_partition_get_type(@struct)
    end

    def type_string
      BlkID::C.blkid_partition_get_type_string(@struct)
    end

    def uuid
      BlkID::C.blkid_partition_get_uuid(@struct)
    end

    def extended?
      BlkID::C.blkid_partition_is_extended(@struct)
    end

    def logical?
      BlkID::C.blkid_partition_is_logical(@struct)
    end

    def primary?
      BlkID::C.blkid_partition_is_primary(@struct)
    end

    def to_ffi
      @struct
    end
  end
end

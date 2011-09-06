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
require 'rblkid/partition'
require 'rblkid/parttable'

module BlkID
  class PartList
    def initialize (struct)
      @struct = struct
    end

    def partition (n)
      BlkID::C.blkid_partlist_get_partition(@struct, n)
    end
    alias [] partition

    def numof_partitions
      BlkID::C.blkid_partlist_numof_partitions(@struct)
    end
    alias size numof_partitions

    def devno_to_partition (devno)
      Partition.new(BlkID::C.blkid_partlist_devno_to_partition(@struct, devno))
    end

    def table
      PartTable.new(BlkID::C.blkid_partlist_get_table(@struct))
    end

    def to_ffi
      @struct
    end

  end
end

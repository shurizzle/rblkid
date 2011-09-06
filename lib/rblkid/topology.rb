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
  class Topology
    def initialize (struct)
      @struct = struct
    end

    def alignment_offset
      BlkID::C.blkid_topology_get_alignment_offset(@struct)
    end

    def logical_sector_size
      BlkID::C.blkid_topology_get_logical_sector_size(@struct)
    end

    def minimum_io_size
      BlkID::C.blkid_topology_get_minimum_io_size(@struct)
    end

    def optimal_io_size
      BlkID::C.blkid_topology_get_optimal_io_size(@struct)
    end

    def physical_sector_size
      BlkID::C.blkid_topology_get_physical_sector_size(@struct)
    end

    def to_ffi
      @struct
    end
  end
end

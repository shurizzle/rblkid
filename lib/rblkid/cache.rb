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
require 'rblkid/dev'

module BlkID
  class Cache
    def initialize (filename=nil)
      @struct = BlkID::C::BlkIDCache.new

      raise "Error while getting cache" unless BlkID::C.blkid_get_cache(@struct.pointer, filename)
    end

    def save
      BlkID::C.blkid_put_cache(@struct)
      self
    end

    def probe_all
      BlkID::C.blkid_probe_all(@struct)
    end

    def probe_all_removable
      BlkID::C.blkid_probe_all_removable(@struct)
    end

    def probe_all_new
      BlkID::C.blkid_probe_all_new(@struct)
    end

    def verify (dev)
      BlkID::C.blkid_verify(@struct, dev.to_ffi)
    end

    def find_dev_with_tag (type, value)
      Dev.new(BlkID::C.blkid_find_dev_with_tag(@struct, type, value))
    end

    def dev (devname, flags)
      Dev.new(BlkID::C.blkid_get_dev(@struct, devname, flags))
    end

    def devname (token, value)
      BlkID::C.blkid_get_tag_value(@struct, tagname, devname)
    end

    def to_ffi
      @struct
    end

    def ptr
      to_ffi.ptr
    end
  end
end

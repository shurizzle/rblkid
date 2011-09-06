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
  class DevIterate
    include Enumerable

    def initialize (cache)
      @struct = BlkID::C.blkid_dev_iterate_begin(cache.to_ffi)

      ObjectSpace.define_finalizer(self, method(:finalize))
    end

    def search (type, value)
      BlkID::C.blkid_dev_set_search(@struct, type, value)
      self
    end

    def next
      Dev.new(BlkID::C::BlkIDDev.new.tap {|res|
        break nil unless BlkID::C.blkid_dev_next(@struct, res.pointer)
      })
    end

    def each
      [].tap {|a|
        while (dev = self.next)
          a << dev
          yield dev if block_given?
        end
      }
    end

    def finalize
      BlkID::C.blkid_dev_iterate_end(@struct)
    end

    def to_ffi
      @struct
    end

    private :next
  end
end

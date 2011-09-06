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
  class TagIterate
    include Enumerable

    def initialize (dev)
      @struct = BlkID::C.blkid_tag_iterate_begin(dev.to_ffi)

      ObjectSpace.define_finalizer(self, method(:finalize))
    end

    def next
      type = FFI::MemoryPointer.new(:string)
      value = FFI::MemoryPointer.new(:string)
      BlkID::C.blkid_tag_next(@struct, type, value)

      [type, value]
    end

    def each
      Hash[[].tap {|a|
        while (tag = self.next)
          a << tag
          yield *tag if block_given?
        end
      }]
    end

    def finalize
      BlkID::C.blkid_tag_iterate_end(@struct)
    end

    def to_ffi
      @struct
    end

    private :next
  end
end

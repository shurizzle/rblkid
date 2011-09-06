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
require 'rblkid/tag_iterate'

module BlkID
  class Dev
    def initialize (struct)
      @struct = struct
    end

    def devname
      BlkID::C.blkid_dev_devname(@struct)
    end

    def tag? (type, value)
      BlkID::C.blkid_dev_has_tag(@struct, type, value)
    end
    alias has_tag? tag?

    def tags
      TagIterate.new(self)
    end

    def to_ffi
      @struct
    end
  end
end

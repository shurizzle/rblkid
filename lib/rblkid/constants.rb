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

module BlkID
  BLKID_PROBVAL_BUFSIZ      = 64
  BLKID_NVALS_SUBLKS        = 14
  BLKID_NVALS_TOPLGY        = 5
  BLKID_NVALS_PARTS         = 10
  BLKID_NVALS               = BLKID_NVALS_SUBLKS + BLKID_NVALS_TOPLGY + BLKID_NVALS_PARTS
	BLKID_CHAIN_SUBLKS        = 0
	BLKID_CHAIN_TOPLGY        = 1
	BLKID_CHAIN_PARTS         = 2
	BLKID_NCHAINS             = 3
  BLKID_FLTR_NOTIN          = 1
  BLKID_FLTR_ONLYIN         = 2
  BLKID_DEV_CREATE          = 0x0001
  BLKID_DEV_FIND            = 0x0000
  BLKID_DEV_VERIFY          = 0x0002
  BLKID_DEV_NORMAL          = BLKID_DEV_CREATE | BLKID_DEV_VERIFY
  BLKID_PARTS_ENTRY_DETAILS = 1 << 2
  BLKID_PARTS_FORCE_GPT     = (1 << 1)
  BLKID_SUBLKS_DEFAULT      = 0
  BLKID_SUBLKS_LABEL        = (1 << 1)
  BLKID_SUBLKS_LABELRAW     = (1 << 2)
  BLKID_SUBLKS_MAGIC        = (1 << 9)
  BLKID_SUBLKS_SECTYPE      = (1 << 6)
  BLKID_SUBLKS_TYPE         = (1 << 5)
  BLKID_SUBLKS_USAGE        = (1 << 7)
  BLKID_SUBLKS_UUID         = (1 << 3)
  BLKID_SUBLKS_UUIDRAW      = (1 << 4)
  BLKID_SUBLKS_VERSION      = (1 << 8)
  BLKID_USAGE_CRYPTO        = (1 << 3)
  BLKID_USAGE_FILESYSTEM    = (1 << 1)
  BLKID_USAGE_OTHER         = (1 << 4)
  BLKID_USAGE_RAID          = (1 << 2)
end

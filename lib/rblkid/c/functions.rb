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

require 'rblkid/c/types'

module BlkID
  module C
    # evaluate {{{
    attach_function :blkid_evaluate_tag, [:string, :string, :pointer], :string
    attach_function :blkid_send_uevent, [:string, :string], :blkid_bool
    #attach_function :blkid_evaluate_spec, [:string, :pointer], :string
    # }}}

    # cache {{{
    attach_function :blkid_gc_cache,  [BlkIDCache], :void
    attach_function :blkid_get_cache, [:pointer, :string], :blkid_bool
    attach_function :blkid_put_cache, [BlkIDCache], :void
    attach_function :blkid_probe_all, [BlkIDCache], :blkid_bool
    attach_function :blkid_probe_all_removable, [BlkIDCache], :blkid_bool
    attach_function :blkid_probe_all_new, [BlkIDCache], :blkid_bool
    attach_function :blkid_verify, [BlkIDCache, BlkIDDev], BlkIDDev
    # }}}

    # search and iterate {{{
    attach_function :blkid_dev_devname, [BlkIDDev], :string
    attach_function :blkid_dev_has_tag, [BlkIDDev, :string, :string], :bool
    attach_function :blkid_dev_iterate_begin, [BlkIDCache], BlkIDDevIterate
    attach_function :blkid_dev_iterate_end, [BlkIDDevIterate], :void
    attach_function :blkid_dev_next, [BlkIDDevIterate, :pointer], :blkid_bool
    attach_function :blkid_dev_set_search, [BlkIDDevIterate, :string, :string], :blkid_bool
    attach_function :blkid_find_dev_with_tag, [BlkIDCache, :string, :string], BlkIDDev
    attach_function :blkid_get_dev, [BlkIDCache, :string, :int], BlkIDDev
    attach_function :blkid_get_devname, [BlkIDCache, :string, :string], :string
    attach_function :blkid_tag_iterate_begin, [BlkIDDev], BlkIDTagIterate
    attach_function :blkid_tag_iterate_end, [BlkIDTagIterate], :void
    attach_function :blkid_tag_next, [BlkIDTagIterate, :pointer, :pointer], :blkid_bool
    # }}}

    # low-level probing {{{
    attach_function :blkid_free_probe, [BlkIDProbe], :void
    attach_function :blkid_new_probe, [], BlkIDProbe
    attach_function :blkid_new_probe_from_filename, [:string], BlkIDProbe
    attach_function :blkid_probe_get_devno, [BlkIDProbe], :dev_t
    attach_function :blkid_probe_get_fd, [BlkIDProbe], :int
    attach_function :blkid_probe_get_sectorsize, [BlkIDProbe], :uint
    attach_function :blkid_probe_get_sectors, [BlkIDProbe], :blkid_loff_t
    attach_function :blkid_probe_get_size, [BlkIDProbe], :blkid_loff_t
    attach_function :blkid_probe_get_offset, [BlkIDProbe], :blkid_loff_t
    attach_function :blkid_probe_get_wholedisk_devno, [BlkIDProbe], :dev_t
    attach_function :blkid_probe_set_device, [BlkIDProbe, :int, :blkid_loff_t, :blkid_loff_t], :int
    attach_function :blkid_probe_is_wholedisk, [BlkIDProbe], :bool
    attach_function :blkid_reset_probe, [BlkIDProbe], :void
    # }}}

    # low-level tags {{{
    attach_function :blkid_do_fullprobe, [BlkIDProbe], :blkid_bool
    attach_function :blkid_do_probe, [BlkIDProbe], :blkid_bool
    attach_function :blkid_do_safeprobe, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_get_value, [BlkIDProbe, :int, :pointer, :pointer, :pointer], :int
    attach_function :blkid_probe_has_value, [BlkIDProbe, :string], :bool
    attach_function :blkid_probe_lookup_value, [BlkIDProbe, :string, :pointer, :pointer], :blkid_bool
    attach_function :blkid_probe_numof_values, [BlkIDProbe], :int
    # }}}

    # superblocks probing {{{
    attach_function :blkid_probe_enable_superblocks, [BlkIDProbe, :bool], :blkid_bool
    attach_function :blkid_known_fstype, [:string], :bool
    attach_function :blkid_superblocks_get_name, [:uint, :pointer, :pointer], :blkid_bool
    attach_function :blkid_probe_filter_superblocks_type, [BlkIDProbe, :int, :pointer], :blkid_bool
    attach_function :blkid_probe_filter_superblocks_usage, [BlkIDProbe, :int, :int], :blkid_bool
    attach_function :blkid_probe_invert_superblocks_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_reset_superblocks_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_set_superblocks_flags, [BlkIDProbe, :int], :blkid_bool
    attach_function :blkid_probe_reset_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_filter_types, [BlkIDProbe, :int, :pointer], :blkid_bool
    attach_function :blkid_probe_filter_usage, [BlkIDProbe, :int, :int], :blkid_bool
    attach_function :blkid_probe_invert_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_set_request, [BlkIDProbe, :int], :blkid_bool
    # }}}

    # partitions probing {{{
    attach_function :blkid_probe_enable_partitions, [BlkIDProbe, :bool], :blkid_bool
    attach_function :blkid_probe_set_partitions_flags, [BlkIDProbe, :int], :blkid_bool
    attach_function :blkid_probe_filter_partitions_type, [BlkIDProbe, :int, :pointer], :blkid_bool
    attach_function :blkid_probe_invert_partitions_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_probe_reset_partitions_filter, [BlkIDProbe], :blkid_bool
    attach_function :blkid_known_pttype, [:string], :bool
    attach_function :blkid_partition_get_name, [BlkIDPartition], :string
    attach_function :blkid_partition_get_flags, [BlkIDPartition], :ulong_long
    attach_function :blkid_partition_get_partno, [BlkIDPartition], :int
    attach_function :blkid_partition_get_size, [BlkIDPartition], :blkid_loff_t
    attach_function :blkid_partition_get_start, [BlkIDPartition], :blkid_loff_t
    attach_function :blkid_partition_get_table, [BlkIDPartition], BlkIDPartTable
    attach_function :blkid_partition_get_type, [BlkIDPartition], :int
    attach_function :blkid_partition_get_type_string, [BlkIDPartition], :string
    attach_function :blkid_partition_get_uuid, [BlkIDPartition], :string
    attach_function :blkid_partition_is_extended, [BlkIDPartition], :bool
    attach_function :blkid_partition_is_logical, [BlkIDPartition], :bool
    attach_function :blkid_partition_is_primary, [BlkIDPartition], :bool
    attach_function :blkid_partlist_get_partition, [BlkIDPartList, :int], BlkIDPartition
    attach_function :blkid_partlist_numof_partitions, [BlkIDPartList], :int
    attach_function :blkid_partlist_devno_to_partition, [BlkIDPartList, :dev_t], BlkIDPartition
    attach_function :blkid_partlist_get_table, [BlkIDPartList], BlkIDPartTable
    attach_function :blkid_parttable_get_offset, [BlkIDPartTable], :blkid_loff_t
    attach_function :blkid_parttable_get_parent, [BlkIDPartTable], BlkIDPartition
    attach_function :blkid_parttable_get_type, [BlkIDPartTable], :string
    attach_function :blkid_probe_get_partitions, [BlkIDProbe], BlkIDPartList
    # }}}

    # Topology information {{{
    attach_function :blkid_probe_enable_topology, [BlkIDProbe, :bool], :blkid_bool
    attach_function :blkid_probe_get_topology, [BlkIDProbe], BlkIDTopology
    attach_function :blkid_topology_get_alignment_offset, [BlkIDTopology], :ulong
    attach_function :blkid_topology_get_logical_sector_size, [BlkIDTopology], :ulong
    attach_function :blkid_topology_get_minimum_io_size, [BlkIDTopology], :ulong
    attach_function :blkid_topology_get_optimal_io_size, [BlkIDTopology], :ulong
    attach_function :blkid_topology_get_physical_sector_size, [BlkIDTopology], :ulong
    # }}}

    # Miscellaneous utils {{{
    attach_function :blkid_devno_to_devname, [:dev_t], :string
    attach_function :blkid_devno_to_wholedisk, [:dev_t, :string, :size_t, :pointer], :blkid_bool
    attach_function :blkid_get_dev_size, [:int], :blkid_loff_t
    attach_function :blkid_get_library_version, [:pointer, :pointer], :int
    attach_function :blkid_parse_tag_string, [:string, :pointer, :pointer], :int
    attach_function :blkid_parse_version_string, [:string], :int
    attach_function :blkid_send_uevent, [:string, :string], :blkid_bool
    # }}}
  end
end

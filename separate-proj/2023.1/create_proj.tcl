# Set the project name
set _xil_proj_name_ "dmac_example"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "dmac_udp_2023.1.tcl"

# Help information for this script
proc print_help {} {
  variable script_file
  puts "\nDescription:"
  puts "Recreate a Vivado project from this script. The created project will be"
  puts "functionally equivalent to the original project for which this script was"
  puts "generated. The script contains commands for creating a project, filesets,"
  puts "runs, adding/importing sources and setting properties on various objects.\n"
  puts "Syntax:"
  puts "$script_file"
  puts "$script_file -tclargs \[--origin_dir <path>\]"
  puts "$script_file -tclargs \[--project_name <name>\]"
  puts "$script_file -tclargs \[--help\]\n"
  puts "Usage:"
  puts "Name                   Description"
  puts "-------------------------------------------------------------------------"
  puts "\[--origin_dir <path>\]  Determine source file paths wrt this path. Default"
  puts "                       origin_dir path value is \".\", otherwise, the value"
  puts "                       that was set with the \"-paths_relative_to\" switch"
  puts "                       when this script was generated.\n"
  puts "\[--project_name <name>\] Create project with the specified name. Default"
  puts "                       name is the name of the project from where this"
  puts "                       script was generated.\n"
  puts "\[--help\]               Print help information for this script"
  puts "-------------------------------------------------------------------------\n"
  exit 0
}

if { $::argc > 0 } {
  for {set i 0} {$i < $::argc} {incr i} {
    set option [string trim [lindex $::argv $i]]
    switch -regexp -- $option {
      "--origin_dir"   { incr i; set origin_dir [lindex $::argv $i] }
      "--project_name" { incr i; set _xil_proj_name_ [lindex $::argv $i] }
      "--help"         { print_help }
      default {
        if { [regexp {^-} $option] } {
          puts "ERROR: Unknown option '$option' specified, please type '$script_file -tclargs --help' for usage info.\n"
          return 1
        }
      }
    }
  }
}

# Create project
create_project ${_xil_proj_name_} ./${_xil_proj_name_} -part xcvp1802-lsvc4072-2MP-e-S

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Reconstruct message rules
# None

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "xilinx.com:vpk180:part0:1.1" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
set_property -name "enable_resource_estimation" -value "0" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "vpk180" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "sim_compile_state" -value "1" -objects $obj
set_property -name "webtalk.activehdl_export_sim" -value "82" -objects $obj
set_property -name "webtalk.modelsim_export_sim" -value "82" -objects $obj
set_property -name "webtalk.questa_export_sim" -value "82" -objects $obj
set_property -name "webtalk.riviera_export_sim" -value "82" -objects $obj
set_property -name "webtalk.vcs_export_sim" -value "82" -objects $obj
set_property -name "webtalk.xsim_export_sim" -value "82" -objects $obj
set_property -name "webtalk.xsim_launch_sim" -value "37" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_FIFO XPM_MEMORY" -objects $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/fourhundred_gbe/axi_regs.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/axis_data_gen.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/macphy/dcmactop.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/reg_delay.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/arpcache.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/arpramadpwr.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/arpramadpwrr.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/axioffseter400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/axis_data_fifo_400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/axisfabricmultiplexer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/axistwoportfabricmultiplexer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/casper400gethernetblock_no_cpu.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/cpudualportpacketringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/cpuethernetmacif400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/cpuifreceiverpacketringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/cpuifsenderpacketringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/cpuinterface/cpumacifethernetreceiver400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/cpuinterface/cpumacifudpreceiver400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/cpuinterface/cpumacifudpsender400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/dualportpacketringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/lbustoaxis/lbustxaxisrx400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/macphy/mac400gphy.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/macphy/macaxisdecoupler400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/macphy/macaxisreceiver400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/macphy/macaxissender400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/macifudpreceiver400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/macifudpsender400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/macinterface/macifudpserver400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/lbustoaxis/mapaxisdatatolbus400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/lbustoaxis/maptkeeptomty.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/packetramdp.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/packetramsp.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/packetringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/packetstatusram.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/ramdpwr.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/ramdpwrr.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/ringbuffer/truedualportpacketringbuffer.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/udpdatapacker400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/udpdatastripper400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/udpipinterfacepr400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/udpstreamingapp400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/udp/udpstreamingapps400g.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/dcmac_udp_demo.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/arpmodule.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/kutleng_skarab2_bsp_firmware/casperbsp/sources/vhdl/rtl/arp/arpreceiver.vhd"] \
 [file normalize "${origin_dir}/fourhundred_gbe/delay.v"] \
 [file normalize "${origin_dir}/fourhundred_gbe/addr_shift.v"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset properties
set obj [get_filesets sources_1]
set_property -name "dataflow_viewer_settings" -value "min_width=16" -objects $obj
set_property -name "top" -value "dcmac_udp_demo" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj


# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the original project
set files [list \
 [file normalize "ips/dcmac_0_clk_wiz_0.xci"]\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "dcmac_0_clk_wiz_0/dcmac_0_clk_wiz_0.xci"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
# Import local files from the original project
set files [list \
 [file normalize "ips/dcmac_0_clk_wiz_0.xci"]\
]
set imported_files [import_files -fileset sources_1 $files]

# Set 'sources_1' fileset file properties for remote files
# None

# Set 'sources_1' fileset file properties for local files
set file "dcmac_0_clk_wiz_0/dcmac_0_clk_wiz_0.xci"
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "generate_files_for_reference" -value "0" -objects $file_obj
set_property -name "registered_with_manager" -value "1" -objects $file_obj
if { ![get_property "is_locked" $file_obj] } {
  set_property -name "synth_checkpoint_mode" -value "Singular" -objects $file_obj
}

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "./constrs/pinout.xdc"]"
set file_imported [import_files -fileset constrs_1 [list $file]]
set file "constrs/pinout.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Add/Import constrs file and set constrs file properties
set file "[file normalize "./constrs/timing.xdc"]"
set file_imported [import_files -fileset constrs_1 [list $file]]
set file "constrs/timing.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj

# Add/Import constrs file and set constrs file properties
set file "[file normalize "./constrs/vpk180_lpddr4.xdc"]"
set file_imported [import_files -fileset constrs_1 [list $file]]
set file "constrs/vpk180_lpddr4.xdc"
set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property -name "file_type" -value "XDC" -objects $file_obj


# Create bd
source scripts/versal_cips_2023.1.tcl
make_wrapper -files [get_files ${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/dcmac_0_cips/dcmac_0_cips.bd] -top
add_files -norecurse ${_xil_proj_name_}/${_xil_proj_name_}.gen/sources_1/bd/dcmac_0_cips/hdl/dcmac_0_cips_wrapper.v

source scripts/dcmac_gt_2023.1.tcl
make_wrapper -files [get_files ${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/dcmac_0_exdes_support/dcmac_0_exdes_support.bd] -top
add_files -norecurse ${_xil_proj_name_}/${_xil_proj_name_}.gen/sources_1/bd/dcmac_0_exdes_support/hdl/dcmac_0_exdes_support_wrapper.v


source scripts/axispacketbufferfifo.tcl

source scripts/dest_address_fifo.tcl

update_compile_order -fileset sources_1

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
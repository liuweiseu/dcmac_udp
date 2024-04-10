# Set the project name
set _xil_proj_name_ "dcmac_udp"

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set _xil_proj_name_ $::user_project_name
}

variable script_file
set script_file "create_proj.tcl"

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
set_property -name "feature_set" -value "FeatureSet_Classic" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "vpk180" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "sim_compile_state" -value "1" -objects $obj
set_property -name "webtalk.activehdl_export_sim" -value "9" -objects $obj
set_property -name "webtalk.modelsim_export_sim" -value "9" -objects $obj
set_property -name "webtalk.questa_export_sim" -value "9" -objects $obj
set_property -name "webtalk.riviera_export_sim" -value "9" -objects $obj
set_property -name "webtalk.vcs_export_sim" -value "9" -objects $obj
set_property -name "webtalk.xcelium_export_sim" -value "4" -objects $obj
set_property -name "webtalk.xsim_export_sim" -value "9" -objects $obj
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


# Proc to create BD axispacketbufferfifo400g
proc cr_bd_axispacketbufferfifo400g { parentCell } {

  # CHANGE DESIGN NAME HERE
  set design_name axispacketbufferfifo400g

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:axis_data_fifo:2.0\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set s_aresetn [ create_bd_port -dir I -type rst s_aresetn ]
  set s_aclk [ create_bd_port -dir I -type clk s_aclk ]
  set s_axis_tdata [ create_bd_port -dir I -from 1023 -to 0 s_axis_tdata ]
  set s_axis_tkeep [ create_bd_port -dir I -from 127 -to 0 s_axis_tkeep ]
  set s_axis_tlast [ create_bd_port -dir I s_axis_tlast ]
  set s_axis_tready [ create_bd_port -dir O s_axis_tready ]
  set s_axis_tuser [ create_bd_port -dir I -from 0 -to 0 s_axis_tuser ]
  set s_axis_tvalid [ create_bd_port -dir I s_axis_tvalid ]
  set m_axis_tlast [ create_bd_port -dir O m_axis_tlast ]
  set m_axis_tready [ create_bd_port -dir I m_axis_tready ]
  set m_axis_tuser [ create_bd_port -dir O -from 0 -to 0 m_axis_tuser ]
  set m_axis_tvalid [ create_bd_port -dir O m_axis_tvalid ]
  set m_axis_tdata [ create_bd_port -dir O -from 1023 -to 0 m_axis_tdata ]
  set m_axis_tkeep [ create_bd_port -dir O -from 127 -to 0 m_axis_tkeep ]
  set axis_prog_full [ create_bd_port -dir O axis_prog_full ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [list \
    CONFIG.FIFO_DEPTH {128} \
    CONFIG.HAS_PROG_FULL {1} \
    CONFIG.HAS_TKEEP {1} \
    CONFIG.HAS_TLAST {1} \
    CONFIG.TDATA_NUM_BYTES {128} \
    CONFIG.TUSER_WIDTH {1} \
  ] $axis_data_fifo_0


  # Create port connections
  connect_bd_net -net axis_data_fifo_0_m_axis_tdata [get_bd_pins axis_data_fifo_0/m_axis_tdata] [get_bd_ports m_axis_tdata]
  connect_bd_net -net axis_data_fifo_0_m_axis_tkeep [get_bd_pins axis_data_fifo_0/m_axis_tkeep] [get_bd_ports m_axis_tkeep]
  connect_bd_net -net axis_data_fifo_0_m_axis_tlast [get_bd_pins axis_data_fifo_0/m_axis_tlast] [get_bd_ports m_axis_tlast]
  connect_bd_net -net axis_data_fifo_0_m_axis_tuser [get_bd_pins axis_data_fifo_0/m_axis_tuser] [get_bd_ports m_axis_tuser]
  connect_bd_net -net axis_data_fifo_0_m_axis_tvalid [get_bd_pins axis_data_fifo_0/m_axis_tvalid] [get_bd_ports m_axis_tvalid]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_ports axis_prog_full]
  connect_bd_net -net axis_data_fifo_0_s_axis_tready [get_bd_pins axis_data_fifo_0/s_axis_tready] [get_bd_ports s_axis_tready]
  connect_bd_net -net m_axis_tready_0_1 [get_bd_ports m_axis_tready] [get_bd_pins axis_data_fifo_0/m_axis_tready]
  connect_bd_net -net s_axis_aclk_0_1 [get_bd_ports s_aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk]
  connect_bd_net -net s_axis_aresetn_0_1 [get_bd_ports s_aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn]
  connect_bd_net -net s_axis_tdata_0_1 [get_bd_ports s_axis_tdata] [get_bd_pins axis_data_fifo_0/s_axis_tdata]
  connect_bd_net -net s_axis_tkeep_0_1 [get_bd_ports s_axis_tkeep] [get_bd_pins axis_data_fifo_0/s_axis_tkeep]
  connect_bd_net -net s_axis_tlast_0_1 [get_bd_ports s_axis_tlast] [get_bd_pins axis_data_fifo_0/s_axis_tlast]
  connect_bd_net -net s_axis_tuser_0_1 [get_bd_ports s_axis_tuser] [get_bd_pins axis_data_fifo_0/s_axis_tuser]
  connect_bd_net -net s_axis_tvalid_0_1 [get_bd_ports s_axis_tvalid] [get_bd_pins axis_data_fifo_0/s_axis_tvalid]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_axispacketbufferfifo400g()
cr_bd_axispacketbufferfifo400g ""
set_property REGISTERED_WITH_MANAGER "1" [get_files axispacketbufferfifo400g.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files axispacketbufferfifo400g.bd ] 

# Proc to create BD dest_address_fifo_400g
proc cr_bd_dest_address_fifo_400g { parentCell } {

  # CHANGE DESIGN NAME HERE
  set design_name dest_address_fifo_400g

  common::send_gid_msg -ssname BD::TCL -id 2010 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

  create_bd_design $design_name

  set bCheckIPsPassed 1
  ##################################################################
  # CHECK IPs
  ##################################################################
  set bCheckIPs 1
  if { $bCheckIPs == 1 } {
     set list_check_ips "\ 
  xilinx.com:ip:emb_fifo_gen:1.0\
  "

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

  }

  if { $bCheckIPsPassed != 1 } {
    common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
    return 3
  }

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set din [ create_bd_port -dir I -from 47 -to 0 din ]
  set dout [ create_bd_port -dir O -from 47 -to 0 dout ]
  set empty [ create_bd_port -dir O empty ]
  set full [ create_bd_port -dir O full ]
  set rd_clk [ create_bd_port -dir I -type clk rd_clk ]
  set rd_en [ create_bd_port -dir I rd_en ]
  set rd_rst_busy [ create_bd_port -dir O rd_rst_busy ]
  set rst [ create_bd_port -dir I rst ]
  set wr_clk [ create_bd_port -dir I -type clk wr_clk ]
  set wr_en [ create_bd_port -dir I wr_en ]
  set wr_rst_busy [ create_bd_port -dir O wr_rst_busy ]

  # Create instance: emb_fifo_gen_0, and set properties
  set emb_fifo_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:emb_fifo_gen:1.0 emb_fifo_gen_0 ]
  set_property -dict [list \
    CONFIG.CLOCK_DOMAIN {Independent_Clock} \
    CONFIG.ENABLE_ALMOST_EMPTY {false} \
    CONFIG.ENABLE_ALMOST_FULL {false} \
    CONFIG.ENABLE_DATA_COUNT {false} \
    CONFIG.ENABLE_OVERFLOW {false} \
    CONFIG.ENABLE_PROGRAMMABLE_EMPTY {false} \
    CONFIG.ENABLE_PROGRAMMABLE_FULL {false} \
    CONFIG.ENABLE_READ_DATA_COUNT {false} \
    CONFIG.ENABLE_READ_DATA_VALID {false} \
    CONFIG.ENABLE_UNDERFLOW {false} \
    CONFIG.ENABLE_WRITE_ACK {false} \
    CONFIG.ENABLE_WRITE_DATA_COUNT {false} \
    CONFIG.FIFO_WRITE_DEPTH {16} \
    CONFIG.READ_MODE {FWFT} \
    CONFIG.WRITE_DATA_WIDTH {48} \
  ] $emb_fifo_gen_0


  # Create port connections
  connect_bd_net -net din_0_1 [get_bd_ports din] [get_bd_pins emb_fifo_gen_0/din]
  connect_bd_net -net emb_fifo_gen_0_dout [get_bd_pins emb_fifo_gen_0/dout] [get_bd_ports dout]
  connect_bd_net -net emb_fifo_gen_0_empty [get_bd_pins emb_fifo_gen_0/empty] [get_bd_ports empty]
  connect_bd_net -net emb_fifo_gen_0_full [get_bd_pins emb_fifo_gen_0/full] [get_bd_ports full]
  connect_bd_net -net emb_fifo_gen_0_rd_rst_busy [get_bd_pins emb_fifo_gen_0/rd_rst_busy] [get_bd_ports rd_rst_busy]
  connect_bd_net -net emb_fifo_gen_0_wr_rst_busy [get_bd_pins emb_fifo_gen_0/wr_rst_busy] [get_bd_ports wr_rst_busy]
  connect_bd_net -net rd_clk_0_1 [get_bd_ports rd_clk] [get_bd_pins emb_fifo_gen_0/rd_clk]
  connect_bd_net -net rd_en_0_1 [get_bd_ports rd_en] [get_bd_pins emb_fifo_gen_0/rd_en]
  connect_bd_net -net rst_0_1 [get_bd_ports rst] [get_bd_pins emb_fifo_gen_0/rst]
  connect_bd_net -net wr_clk_0_1 [get_bd_ports wr_clk] [get_bd_pins emb_fifo_gen_0/wr_clk]
  connect_bd_net -net wr_en_0_1 [get_bd_ports wr_en] [get_bd_pins emb_fifo_gen_0/wr_en]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
  close_bd_design $design_name 
}
# End of cr_bd_dest_address_fifo_400g()
cr_bd_dest_address_fifo_400g ""
set_property REGISTERED_WITH_MANAGER "1" [get_files dest_address_fifo_400g.bd ] 
set_property SYNTH_CHECKPOINT_MODE "Hierarchical" [get_files dest_address_fifo_400g.bd ] 

set cur_path [exec pwd]
puts "Current path: $cur_path"

source versal_cips_2023.2.tcl
make_wrapper -files [get_files ${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/dcmac_0_cips/dcmac_0_cips.bd] -top
add_files -norecurse ${_xil_proj_name_}/${_xil_proj_name_}.gen/sources_1/bd/dcmac_0_cips/hdl/dcmac_0_cips_wrapper.v

source dcmac_gt_2023.2.tcl
make_wrapper -files [get_files ${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/dcmac_0_exdes_support/dcmac_0_exdes_support.bd] -top
add_files -norecurse ${_xil_proj_name_}/${_xil_proj_name_}.gen/sources_1/bd/dcmac_0_exdes_support/hdl/dcmac_0_exdes_support_wrapper.v

update_compile_order -fileset sources_1

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
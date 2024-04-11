
################################################################
# This is a generated script based on design: axispacketbufferfifo400g
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2023.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source axispacketbufferfifo400g_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvp1802-lsvc4072-2MP-e-S
   set_property BOARD_PART xilinx.com:vpk180:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name axispacketbufferfifo400g

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

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

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

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
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



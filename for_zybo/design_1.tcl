
################################################################
# This is a generated script based on design: design_1
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
set scripts_vivado_version 2018.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# BidirectionalSinglePortIO, do_mnist7_mem

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
   set_property BOARD_PART digilentinc.com:zybo:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

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
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

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

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:xlconstant:1.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
BidirectionalSinglePortIO\
do_mnist7_mem\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
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
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set sys_clock [ create_bd_port -dir I -type clk sys_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125000000} \
   CONFIG.PHASE {0.000} \
 ] $sys_clock

  # Create instance: BidirectionalSingleP_0, and set properties
  set block_name BidirectionalSinglePortIO
  set block_cell_name BidirectionalSingleP_0
  if { [catch {set BidirectionalSingleP_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $BidirectionalSingleP_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.ADDR_WIDTH {5} \
   CONFIG.DATA_WIDTH {16} \
   CONFIG.RAM_DEPTH {16} \
   CONFIG.RAM_LENGTH {10} \
 ] $BidirectionalSingleP_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.Coe_File {../../../../../../../ipcores/coe/img7.coe} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Load_Init_File {true} \
   CONFIG.Read_Width_A {16} \
   CONFIG.Read_Width_B {16} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {1024} \
   CONFIG.Write_Width_A {16} \
   CONFIG.Write_Width_B {16} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_JITTER {312.659} \
   CONFIG.CLKOUT1_PHASE_ERROR {245.713} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25.000} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {36.500} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {36.500} \
   CONFIG.MMCM_DIVCLK_DIVIDE {5} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_LOCKED {false} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_0

  # Create instance: do_mnist7_mem_0, and set properties
  set block_name do_mnist7_mem
  set block_cell_name do_mnist7_mem_0
  if { [catch {set do_mnist7_mem_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $do_mnist7_mem_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {11} \
   CONFIG.C_NUM_PROBE_OUT {3} \
 ] $vio_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {784} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {784} \
   CONFIG.CONST_WIDTH {11} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {10} \
   CONFIG.CONST_WIDTH {6} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {16} \
 ] $xlconstant_3

  # Create interface connections
  connect_bd_intf_net -intf_net do_mnist7_mem_0_bram_in [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA] [get_bd_intf_pins do_mnist7_mem_0/bram_in]

  # Create port connections
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports0 [get_bd_pins BidirectionalSingleP_0/out_io_ports0] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports1 [get_bd_pins BidirectionalSingleP_0/out_io_ports1] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports2 [get_bd_pins BidirectionalSingleP_0/out_io_ports2] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports3 [get_bd_pins BidirectionalSingleP_0/out_io_ports3] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports4 [get_bd_pins BidirectionalSingleP_0/out_io_ports4] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports5 [get_bd_pins BidirectionalSingleP_0/out_io_ports5] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports6 [get_bd_pins BidirectionalSingleP_0/out_io_ports6] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports7 [get_bd_pins BidirectionalSingleP_0/out_io_ports7] [get_bd_pins vio_0/probe_in8]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports8 [get_bd_pins BidirectionalSingleP_0/out_io_ports8] [get_bd_pins vio_0/probe_in9]
  connect_bd_net -net BidirectionalSingleP_0_out_io_ports9 [get_bd_pins BidirectionalSingleP_0/out_io_ports9] [get_bd_pins vio_0/probe_in10]
  connect_bd_net -net BidirectionalSingleP_0_ram_q [get_bd_pins BidirectionalSingleP_0/ram_q] [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_q]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins BidirectionalSingleP_0/clk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins do_mnist7_mem_0/clk] [get_bd_pins vio_0/clk]
  connect_bd_net -net do_mnist7_mem_0_do_mnist7_mem_in__mem_addr [get_bd_pins BidirectionalSingleP_0/ram_addr] [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_addr]
  connect_bd_net -net do_mnist7_mem_0_do_mnist7_mem_in__mem_d [get_bd_pins BidirectionalSingleP_0/ram_d] [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_d]
  connect_bd_net -net do_mnist7_mem_0_do_mnist7_mem_in__mem_req [get_bd_pins BidirectionalSingleP_0/ram_req] [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_req]
  connect_bd_net -net do_mnist7_mem_0_do_mnist7_mem_in__mem_we [get_bd_pins BidirectionalSingleP_0/ram_we] [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_we]
  connect_bd_net -net do_mnist7_mem_0_do_mnist7_mem_valid [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_valid] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_wiz_0/clk_in1]
  connect_bd_net -net vio_0_probe_out0 [get_bd_pins BidirectionalSingleP_0/rst] [get_bd_pins do_mnist7_mem_0/rst] [get_bd_pins vio_0/probe_out0]
  connect_bd_net -net vio_0_probe_out1 [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_ready] [get_bd_pins vio_0/probe_out1]
  connect_bd_net -net vio_0_probe_out2 [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_accept] [get_bd_pins vio_0/probe_out2]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in_lst_len] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in_a_len] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins do_mnist7_mem_0/do_mnist7_mem_in__mem_len] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins BidirectionalSingleP_0/in_io_ports0] [get_bd_pins BidirectionalSingleP_0/in_io_ports1] [get_bd_pins BidirectionalSingleP_0/in_io_ports2] [get_bd_pins BidirectionalSingleP_0/in_io_ports3] [get_bd_pins BidirectionalSingleP_0/in_io_ports4] [get_bd_pins BidirectionalSingleP_0/in_io_ports5] [get_bd_pins BidirectionalSingleP_0/in_io_ports6] [get_bd_pins BidirectionalSingleP_0/in_io_ports7] [get_bd_pins BidirectionalSingleP_0/in_io_ports8] [get_bd_pins BidirectionalSingleP_0/in_io_ports9] [get_bd_pins xlconstant_3/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



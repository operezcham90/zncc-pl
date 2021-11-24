
################################################################
# This is a generated script based on design: top
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
set scripts_vivado_version 2017.3
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
# source top_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# input_adapter

# Please add the sources of those modules before sourcing this Tcl script.

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:c_accum:12.0\
xilinx.com:ip:c_addsub:12.0\
xilinx.com:ip:div_gen:5.1\
xilinx.com:ip:xlslice:1.0\
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
input_adapter\
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


# Hierarchical cell: avg_block
proc create_hier_cell_avg_block { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_avg_block() - Empty argument(s)!"}
     return
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

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -type clk CLK
  create_bd_pin -dir I acc
  create_bd_pin -dir O -from 31 -to 0 avg
  create_bd_pin -dir I div
  create_bd_pin -dir O done
  create_bd_pin -dir I -from 31 -to 0 input_bus
  create_bd_pin -dir I -from 31 -to 0 num_elem

  # Create instance: c_accum_0, and set properties
  set c_accum_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_accum:12.0 c_accum_0 ]
  set_property -dict [ list \
   CONFIG.Bypass {false} \
   CONFIG.CE {true} \
   CONFIG.Input_Type {Unsigned} \
   CONFIG.Input_Width {18} \
   CONFIG.Latency {1} \
   CONFIG.Latency_Configuration {Manual} \
   CONFIG.Output_Width {32} \
 ] $c_accum_0

  # Create instance: c_addsub_0, and set properties
  set c_addsub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_0 ]
  set_property -dict [ list \
   CONFIG.A_Type {Unsigned} \
   CONFIG.A_Width {16} \
   CONFIG.B_Type {Unsigned} \
   CONFIG.B_Value {0000000000000000} \
   CONFIG.B_Width {16} \
   CONFIG.CE {false} \
   CONFIG.Latency {0} \
   CONFIG.Out_Width {17} \
 ] $c_addsub_0

  # Create instance: c_addsub_1, and set properties
  set c_addsub_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_1 ]
  set_property -dict [ list \
   CONFIG.A_Type {Unsigned} \
   CONFIG.A_Width {16} \
   CONFIG.B_Type {Unsigned} \
   CONFIG.B_Value {0000000000000000} \
   CONFIG.B_Width {16} \
   CONFIG.CE {false} \
   CONFIG.Latency {0} \
   CONFIG.Out_Width {17} \
 ] $c_addsub_1

  # Create instance: c_addsub_2, and set properties
  set c_addsub_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_addsub:12.0 c_addsub_2 ]
  set_property -dict [ list \
   CONFIG.A_Type {Unsigned} \
   CONFIG.A_Width {17} \
   CONFIG.B_Type {Unsigned} \
   CONFIG.B_Value {00000000000000000} \
   CONFIG.B_Width {17} \
   CONFIG.CE {false} \
   CONFIG.Latency {0} \
   CONFIG.Out_Width {18} \
 ] $c_addsub_2

  # Create instance: div_gen_avg, and set properties
  set div_gen_avg [ create_bd_cell -type ip -vlnv xilinx.com:ip:div_gen:5.1 div_gen_avg ]
  set_property -dict [ list \
   CONFIG.dividend_and_quotient_width {32} \
   CONFIG.divisor_width {16} \
   CONFIG.fractional_width {16} \
   CONFIG.latency {36} \
 ] $div_gen_avg

  # Create instance: input_adapter_0, and set properties
  set block_name input_adapter
  set block_cell_name input_adapter_0
  if { [catch {set input_adapter_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $input_adapter_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: num_elem, and set properties
  set num_elem [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 num_elem ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DOUT_WIDTH {16} \
 ] $num_elem

  # Create instance: quotient, and set properties
  set quotient [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 quotient ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {47} \
   CONFIG.DIN_TO {16} \
   CONFIG.DIN_WIDTH {48} \
   CONFIG.DOUT_WIDTH {1} \
 ] $quotient

  # Create port connections
  connect_bd_net -net acc_1 [get_bd_pins acc] [get_bd_pins c_accum_0/CE]
  connect_bd_net -net axi_gpio_num_elem_gpio_io_o [get_bd_pins num_elem] [get_bd_pins num_elem/Din]
  connect_bd_net -net c_accum_0_Q [get_bd_pins c_accum_0/Q] [get_bd_pins div_gen_avg/s_axis_dividend_tdata]
  connect_bd_net -net c_addsub_0_S [get_bd_pins c_addsub_0/S] [get_bd_pins c_addsub_2/A]
  connect_bd_net -net c_addsub_1_S [get_bd_pins c_addsub_1/S] [get_bd_pins c_addsub_2/B]
  connect_bd_net -net c_addsub_2_S [get_bd_pins c_accum_0/B] [get_bd_pins c_addsub_2/S]
  connect_bd_net -net div_1 [get_bd_pins div] [get_bd_pins div_gen_avg/s_axis_dividend_tvalid] [get_bd_pins div_gen_avg/s_axis_divisor_tvalid]
  connect_bd_net -net div_gen_avg_m_axis_dout_tdata [get_bd_pins div_gen_avg/m_axis_dout_tdata] [get_bd_pins quotient/Din]
  connect_bd_net -net div_gen_avg_m_axis_dout_tvalid [get_bd_pins done] [get_bd_pins div_gen_avg/m_axis_dout_tvalid]
  connect_bd_net -net input_adapter_0_byte_0 [get_bd_pins c_addsub_0/A] [get_bd_pins input_adapter_0/byte_0]
  connect_bd_net -net input_adapter_0_byte_1 [get_bd_pins c_addsub_0/B] [get_bd_pins input_adapter_0/byte_1]
  connect_bd_net -net input_adapter_0_byte_2 [get_bd_pins c_addsub_1/A] [get_bd_pins input_adapter_0/byte_2]
  connect_bd_net -net input_adapter_0_byte_3 [get_bd_pins c_addsub_1/B] [get_bd_pins input_adapter_0/byte_3]
  connect_bd_net -net input_bus_1 [get_bd_pins input_bus] [get_bd_pins input_adapter_0/input_bus]
  connect_bd_net -net num_elem_Dout [get_bd_pins div_gen_avg/s_axis_divisor_tdata] [get_bd_pins num_elem/Dout]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins CLK] [get_bd_pins c_accum_0/CLK] [get_bd_pins div_gen_avg/aclk]
  connect_bd_net -net quotient_Dout [get_bd_pins avg] [get_bd_pins quotient/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


proc available_tcl_procs { } {
   puts "##################################################################"
   puts "# Available Tcl procedures to recreate hierarchical blocks:"
   puts "#"
   puts "#    create_hier_cell_avg_block parentCell nameHier"
   puts "#"
   puts "##################################################################"
}

available_tcl_procs

# Source
To learn more of this project read [Development of Heterogeneous Systems Based on the Honeybee Search Algorithm for Video Tracking](https://www.researchgate.net/publication/355093993_Development_of_Heterogeneous_Systems_Based_on_the_Honeybee_Search_Algorithm_for_Video_Tracking), specifically Chapter 5 - Development of a SoC-FPGA Heterogeneous System.

# Add Average block to project
* Create a new Vivado project.
* Create a new Block Design.
* Add [input_adapter.vhd](https://raw.githubusercontent.com/operezcham90/zncc-pl/main/vhdl/input_adapter.vhd) as a source file.
* Run the [avg_block.tcl](https://raw.githubusercontent.com/operezcham90/zncc-pl/main/tcl/avg_block.tcl) script, paste the contents into the console
* Run the following command.
```
create_hier_cell_avg_block . avg_block_0
```

# Appendix - Hierarchy to TCL script
To generate a TCL script from a hierachy, open de TCL Console and type the following command.
```
write_bd_tcl -force -hier_blks [get_bd_cells /hierarchy_name] /out/path/hierarchy_name.tcl
```

# Add Average block to project
* Create a new Vivado project.
* Create a new Block Design.
* Run the [avg_block.tcl](https://github.com/operezcham90/zncc-pl) script, paste the contents into the console
* Run the following command.
```create_hier_cell_avg_block . avg_block_0```

# Appendix - Hierarchy to TCL script
To generate a TCL script from a hierachy, open de TCL Console and type the following command.
```write_bd_tcl -force -hier_blks [get_bd_cells /hierarchy_name] /out/path/hierarchy_name.tcl```

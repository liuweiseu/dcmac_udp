create_clock -period 6.400 -name gt_ref_clk0_p -waveform {0.000 3.200} [get_ports gt_ref_clk0_p]
create_clock -period 6.400 -name gt_ref_clk1_p -waveform {0.000 3.200} [get_ports gt_ref_clk1_p]

set_false_path -from [get_clocks -of_objects [get_pins i_dcmac_0_cips_wrapper/dcmac_0_cips_i/versal_cips_0/inst/pspmc_0/inst/PS9_inst/PMCRCLKCLK[0]]] -to [get_clocks -of_objects [get_pins casper400gethernetblock_no_cpu_inst/DCMAC_i/DCMAC0_i/i_dcmac_0_clk_wiz_0/inst/clock_primitive_inst/DPLL_inst/CLKOUT1]]
set_false_path -from [get_clocks -of_objects [get_pins casper400gethernetblock_no_cpu_inst/DCMAC_i/DCMAC0_i/i_dcmac_0_clk_wiz_0/inst/clock_primitive_inst/DPLL_inst/CLKOUT1]] -to [get_clocks -of_objects [get_pins i_dcmac_0_cips_wrapper/dcmac_0_cips_i/versal_cips_0/inst/pspmc_0/inst/PS9_inst/PMCRCLKCLK[0]]]
                    
set_false_path -from [get_clocks -of_objects [get_pins i_dcmac_0_cips_wrapper/dcmac_0_cips_i/versal_cips_0/inst/pspmc_0/inst/PS9_inst/PMCRCLKCLK[0]]] -to [get_clocks -of_objects [get_pins casper400gethernetblock_no_cpu_inst/DCMAC_i/DCMAC0_i/i_dcmac_0_clk_wiz_0/inst/clock_primitive_inst/DPLL_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins casper400gethernetblock_no_cpu_inst/DCMAC_i/DCMAC0_i/i_dcmac_0_clk_wiz_0/inst/clock_primitive_inst/DPLL_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins i_dcmac_0_cips_wrapper/dcmac_0_cips_i/versal_cips_0/inst/pspmc_0/inst/PS9_inst/PMCRCLKCLK[0]]]

set_property LOC DPLL_X3Y23 [get_cells casper400gethernetblock_no_cpu_inst/DCMAC_i/DCMAC0_i/i_dcmac_0_clk_wiz_0/inst/clock_primitive_inst/DPLL_inst]
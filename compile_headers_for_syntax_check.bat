echo off

call source/hVHDL_floating_point/ghdl_compile_vhdl_float.bat source/hVHDL_floating_point/
call source/hVHDL_math_library/ghdl_compile_math_library.bat source/hVHDL_math_library/

ghdl -a --ieee=synopsys --std=08 source/hVHDL_analog_to_digital_drivers/sigma_delta/sigma_delta_cic_filter_pkg.vhd

ghdl -a --ieee=synopsys --std=08 testbenches/i2s/i2s_pkg.vhd

ghdl -a --ieee=synopsys --std=08 other_sources/i2c_pkg.vhd

ghdl -a --ieee=synopsys --std=08 example_project_addresses_pkg.vhd

ghdl -a --ieee=synopsys --std=08 source/hVHDL_fpga_interconnect/interconnect_configuration/data_15_address_15_bit_pkg.vhd
ghdl -a --ieee=synopsys --std=08 source/hVHDL_fpga_interconnect/fpga_interconnect_pkg.vhd

ghdl -a --ieee=synopsys --std=08 source/hvhdl_example_interconnect/example_filter_entity.vhd

ghdl -a --ieee=synopsys --std=08 source/hVHDL_uart/uart_tx/uart_tx_pkg.vhd
ghdl -a --ieee=synopsys --std=08 source/hVHDL_uart/uart_rx/uart_rx_pkg.vhd
ghdl -a --ieee=synopsys --std=08 source/hVHDL_uart/uart_protocol/uart_protocol_pkg.vhd

ghdl -a --ieee=synopsys --std=08 source/hvhdl_example_interconnect/sigma_delta_module/sigma_delta_filter_pkg.vhd

ghdl -a --ieee=synopsys --std=08 source/hvhdl_example_interconnect/communication/communications.vhd
ghdl -a --ieee=synopsys --std=08 source/hvhdl_example_interconnect/hvhdl_example_interconnect_pkg.vhd


ghdl -a --ieee=synopsys --std=08 source/efinix_top.vhd


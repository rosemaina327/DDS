##${BASE}/tb_adc/adc_analog_spice.scs
${SPICE_CONTROL}

#${BASE}/tb_adc/adc_analog_tt.scs
${BASE}/tb_adc/supply.vams
${BASE}/tb_adc/adc_mixed_tb_top.sv
${BASE}/rtl/adc/adc_top.sv
${BASE}/rtl/adc/adc_digital_sar.sv

-spectre_args "++aps +mt=8"
-amsformat psfxl_all
-fast_recompilation
-dms_perf
-top cds_globals

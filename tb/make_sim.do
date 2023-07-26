vlib work

vlog -sv debouncer.sv
vlog -sv tb_debouncer.sv

vsim tb_debouncer

add log -r /*
add wave -r *
run -all

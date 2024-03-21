transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/ff_logic.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/decoder_2_to_4.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/ror.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/shiftrightari32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/shiftright32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/shiftleft32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/not32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/negate32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/and32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/register64.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/mul32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/div32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/rol.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/register0.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/conff_logic.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/IR.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/select_encode.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/or32.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/sub32.v}

vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/datapath_ld_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  datapath_ld_tb

add wave *
view structure
view signals
run 1000 ns

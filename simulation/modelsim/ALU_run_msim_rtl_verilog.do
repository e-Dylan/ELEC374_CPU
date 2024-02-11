transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/register64.v}

vlog -vlog01compat -work work +incdir+C:/Users/jimmy/Desktop/ELEC374_CPU {C:/Users/jimmy/Desktop/ELEC374_CPU/datapath_add_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  datapath_add_tb

add wave *
view structure
view signals
run 500 ns

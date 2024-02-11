transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/20dds5/Desktop/374_CPU_Project {C:/Users/20dds5/Desktop/374_CPU_Project/bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/20dds5/Desktop/374_CPU_Project {C:/Users/20dds5/Desktop/374_CPU_Project/datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/20dds5/Desktop/374_CPU_Project {C:/Users/20dds5/Desktop/374_CPU_Project/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/20dds5/Desktop/374_CPU_Project {C:/Users/20dds5/Desktop/374_CPU_Project/adder.v}

vlog -vlog01compat -work work +incdir+C:/Users/20dds5/Desktop/374_CPU_Project {C:/Users/20dds5/Desktop/374_CPU_Project/datapath_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run 500 ns

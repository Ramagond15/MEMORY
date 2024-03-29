

//---------------------------

`include "interface.sv"
`include "random_test.sv"

module testbench();

	// clock and reset signal declaration
	bit clk;
	bit reset;

	// clock generation
	always #5 clk=~clk;

	// reset generation
	initial begin
	reset=1;
	#5 reset=0;
	end

	// creating instance of interface, inorder to connect DUT and testcase

	mem_intf intf(clk,reset);

	// Testcase instance, interface handle is passed to test as an argument
	test t1(intf);

	//DUT instance, interface signals are connected to the DUT ports
        memory DUT(
	.clk(intf.clk),
	.reset(intf.reset),
	.addr(intf.addr),
	.wr_en(intf.wr_en),
	.rd_en(intf.rd_en),
	.wdata(intf.wdata),
	.rdata(intf.rdata));

	//   enabling the wave dump
	initial begin
		//$dumpfile("dump.vcd"); $dumpvars;
	end
endmodule

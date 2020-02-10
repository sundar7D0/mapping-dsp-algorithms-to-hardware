`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT Madras
// Engineer: Sundar Raman P
// 
// Create Date: 04.02.2020 22:37:45
// Design Name: Sequential_Multiplier
// Module Name: sequential_multiplier
// Project Name: Assignment_1-EE5332
// Target Devices: Basys-3: xc7a35tcpg236
// Tool Versions: Vivado v2018.2 
// Description: Test bench for checking the reliability of 'sequential_multiplier.v' code with varied input values. 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////
// Uses tasks to keep test code clean

`timescale 1ns/1ns
`define width 8
`define TIMEOUT 100

module seq_mult_tb() ;
   reg signed [`width-1:0] a, b;
   reg 		   clk, reset;
   integer     tot, err;
   integer     timer;
   reg         timedout;

   wire  signed [2*`width-1:0] p, expected_p;
   wire 	      rdy;

   //Calculation of expected output.
   assign expected_p = a * b;
   seq_mult dut( .clk(clk),
		 .reset(reset),
		 .a(a),
		 .b(b),
		 .p(p),
		 .rdy(rdy));

   // Generate a 10ns clock 
   always #5 clk = !clk;
   
   task reset_and_crank_dut;
      begin
         timer = 0;   
	      // Reset the DUT for one clock cycle
	      reset = 1;
	      @(posedge clk);
	      // Remove reset 
	      #1 reset = 0;
	 
	      // Loop until the DUT indicates 'rdy'
	      while ((rdy == 0) && (timer < `TIMEOUT)) begin
	         @(posedge clk); // Wait for one clock cycle
            timer = timer + 1;
	      end
         if (timer == `TIMEOUT) begin
            $display("Timed out");
            timedout = 1;
         end
      end
   endtask // reset_and_crank_dut
   
   initial begin
      // Initialize the clock
      clk = 1;
      tot = 0;
      err = 0;
      timedout = 0;

      // Sequences of values pumped through DUT 
      
      // It is not necessary to place a #1 before the $display,
      // because the reset_and_crank_dut task will only exit after the
      // value is correctly computed.
      a = 10;
      b = 1;
      reset_and_crank_dut;
      tot = tot + 1;
      if (p != expected_p) begin
         err = err + 1;
         $display($time, " a = %d, b = %d, p = %d, expected p = %d", a, b, p, expected_p);
      end
      
      a = 10;
      b = 2;
      reset_and_crank_dut;
      tot = tot + 1;
      if (p != expected_p) begin
         err = err + 1;
         $display($time, " a = %d, b = %d, p = %d, expected p = %d", a, b, p, expected_p);
      end

      // Product will not fit in 8 bits.      
      a = 20;
      b = 20;
      reset_and_crank_dut;
      tot = tot + 1;
      if (p != expected_p) begin
         err = err + 1;
         $display($time, " a = %d, b = %d, p = %d, expected p = %d", a, b, p, expected_p);
      end

      // One operand negative
      a = -10;
      b = 2;
      reset_and_crank_dut;
      tot = tot + 1;
      if (p != expected_p) begin
         err = err + 1;
         $display($time, " a = %d, b = %d, p = %d, expected p = %d", a, b, p, expected_p);
      end
      
      // One operand negative
      a = 10;
      b = -2;
      reset_and_crank_dut;
      tot = tot + 1;
      if (p != expected_p) begin
         err = err + 1;
         $display($time, " a = %d, b = %d, p = %d, expected p = %d", a, b, p, expected_p);
      end
      
      // Add more test cases:
      // - other input negative
      // - each input 0
      // - max/min values etc.
      // - random numbers if necessary?

      if (err > 0) begin
         $display("FAILED %d out of %d", err, tot);
      end else if (timedout === 'b1) begin
         $display("FAILED due to TIMEOUT");
      end else begin
         $display("PASS");
      end

      $finish;
      
   end
   
endmodule // seq_mult_tb


`timescale 1ns / 1ps

module tb_debouncer ();


reg clk_i, key_i;	// Inputs
wire key_pressed_stb_o;		// Outputs

debouncer UUT (.clk_i(clk_i), .key_i(key_i), .key_pressed_stb_o(key_pressed_stb_o));

initial 
    begin
        clk_i = 1'b0;
        key_i = 1'b0; 
        //key_pressed_stb_o = 1'b0;
    end
always
    begin
       clk_i = ~clk_i;
		  #5;
    end

always
    begin
      #10  key_i = ~key_i;// 1 Bouncing
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #200 key_i = ~key_i;// On
      #10  key_i = ~key_i;// 0 Bouncing
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// 1
      #10  key_i = ~key_i;// 0
      #10  key_i = ~key_i;// off
      #200;
    end
endmodule
	
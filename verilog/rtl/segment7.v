//Verilog module.
module segment7(
     `ifdef USE_POWER_PINS
         inout vccd1,   // User area 1 analog ground
         inout vssd1,   // User area 1 digital ground
     `endif
     input wire clk,
     input wire reset,
     output reg [6:0] led_out,
     output wire [6:0] led_out_b
    );
     //Declare inputs,outputs and internal variables.
     reg [23:0] second_counter;
     reg [3:0] digit;

     `ifdef COCOTB_SIM
        initial begin
            $dumpfile ("segment7.vcd");
            $dumpfile (0, segment7);
            #1;
        end
         localparam MAX_CNT = 100;
     `else
         localparam MAX_CNT = 100;
     `endif


    assign led_out_b = 7'b0000000;


//always block for converting bcd digit into 7 segment format
    always @(posedge clk)
    begin
        if (reset) begin
            second_counter <= 0;
            digit <= 0;
        end
        else begin
            second_counter <= second_counter + 1'b1;
            if (second_counter==MAX_CNT) begin
               second_counter <= 0; 
               digit <= digit + 1'b1;
            end
        end
    end

    always @(*)
    begin
        case (digit) //case statement
            0 : led_out = 7'b0000001;
            1 : led_out = 7'b1001111;
            2 : led_out = 7'b0010010;
            3 : led_out = 7'b0000110;
            4 : led_out = 7'b1001100;
            5 : led_out = 7'b0100100;
            6 : led_out = 7'b0100000;
            7 : led_out = 7'b0001111;
            8 : led_out = 7'b0000000;
            9 : led_out = 7'b0000100;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : led_out = 7'b1111111; 
        endcase
    end

endmodule
/*    seg7 seg7(.counter(digit), .segments(led_out));

endmodule

module seg7(
    input wire [3:0] counter,
    output reg [6:0] segments

    );
    always @(*)
    begin
        case (counter) //case statement
            0 : segments = 7'b0000001;
            1 : segments = 7'b1001111;
            2 : segments = 7'b0010010;
            3 : segments = 7'b0000110;
            4 : segments = 7'b1001100;
            5 : segments = 7'b0100100;
            6 : segments = 7'b0100000;
            7 : segments = 7'b0001111;
            8 : segments = 7'b0000000;
            9 : segments = 7'b0000100;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : segments = 7'b1111111; 
        endcase
    end
    
endmodule*/
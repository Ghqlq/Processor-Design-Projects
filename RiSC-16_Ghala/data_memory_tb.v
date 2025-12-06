`timescale 1ns / 1ps

module data_memory_tb;
    // inputs
    reg clk, WE_dmem;
    reg [15:0] reg_out, alu_out;
    // outputs
    wire [15:0] mem_out;

    data_memory uut (
        .clk(clk),
        .WE_dmem(WE_dmem),
        .reg_out(reg_out),
        .alu_out(alu_out),
        .mem_out(mem_out)
    );

     // Clock Generator: 100MHaz clock (10ns period)
    always #5 clk = ~clk;

    integer i;
    reg [15:0] addrs [0:3];
    reg [15:0] data [0:3];  

    initial begin
        $display("T = %0t: Starting data_memory Testbench", $time);
        clk =0;
        WE_dmem = 0;
        reg_out = 16'h0000; 
        alu_out = 16'h0000; 
        #10;

        addrs[0] = 16'h0000; 
        addrs[1] = 16'h0010; 
        addrs[2] = 16'hABCD; 
        addrs[3] = 16'hFFFF; 

        data[0] = 16'hAAAA;
        data[1] = 16'h0014;  
        data[2] = 16'hDEAD;
        data[3] = 16'h5555;

        // testing initial read (should be 0)
        $display("T=%0t: [TEST 1] Testing initial memory values", $time);
        for (i = 0; i < 4; i = i + 1) begin
            alu_out = addrs[i];
            #1;
            if (mem_out !== 16'h0000) begin
                $display("T=%0t: [FAIL] mem_out = 0x%h expected 0x0000, address = 0x%h", $time, mem_out, addrs[i]);
            end else begin
                $display("T=%0t: [PASS] mem_out = 0x%h as expected, address = 0x%h", $time, mem_out, addrs[i]);
            end
        end
        #1;

        // testing write then read back
        $display("T=%0t: [TEST 2] Testing write and read back", $time);
        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);  
            alu_out <= addrs[i];  reg_out <= data[i];  WE_dmem <= 1'b1;
            @(posedge clk);  
            WE_dmem <= 1'b0;
            alu_out = addrs[i];

            #1;
            if (mem_out !== data[i])
                $display("T=%0t: [FAIL] at memory loc = 0x%04h, mem_out=0x%04h, exp=0x%04h", $time, addrs[i], mem_out, data[i]);
            else
                $display("T=%0t: [PASS] at memory loc = 0x%04h = 0x%04h", $time, addrs[i], mem_out);
        end

        // testing WE_dmem = 0 
        $display("T=%0t: [TEST 3] Testing read when WE_dmem is low", $time);
        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);    
            alu_out <= addrs[i];  reg_out <= data[i];  WE_dmem <= 1'b0;  
            
            #1;                    
            if (mem_out !== data[i])
                $display("T=%0t: [FAIL] at memory loc = 0x%04h, mem_out=0x%04h, exp=0x%04h", $time, addrs[i], mem_out, data[i]);
            else
                $display("T=%0t: [PASS] at memory loc = 0x%04h = 0x%04h", $time, addrs[i], mem_out);
        end

        // testing overwrite
        $display("T=%0t: [TEST 4] Testing overwrite existing data", $time);
        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);  
            alu_out <= addrs[i];  reg_out <= data[i] + 16'h0001;  WE_dmem <= 1'b1;
            @(posedge clk);  
            WE_dmem <= 1'b0;
            alu_out = addrs[i];

            #1;
            if (mem_out !== (data[i] + 16'h0001))
                $display("T=%0t: [FAIL] at memory loc = 0x%04h, mem_out=0x%04h, exp=0x%04h", $time, addrs[i], mem_out, data[i] + 16'h0001);
            else
                $display("T=%0t: [PASS] at memory loc = 0x%04h = 0x%04h", $time, addrs[i], mem_out);
        end

        $display("T = %0t: [DONE] data_memory testbench completed", $time);
        $finish;
    end
endmodule






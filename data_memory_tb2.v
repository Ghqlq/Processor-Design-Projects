`timescale 1ns / 1ps

module data_memory_tb;

    // Inputs
    reg clk;
    reg WE_dmem;        // 0: Don't write   // 1: Write
    reg [15:0] reg_out;
    reg [15:0] alu_out;

    // Outputs
    wire [15:0] mem_out;
    
    data_memory uut (
        .clk(clk),
        .WE_dmem(WE_dmem),
        .reg_out(reg_out),
        .alu_out(alu_out),
        .mem_out(mem_out)
    );

    // --- Data Memory --- //
    reg [15:0] mem_data [0:65535];

    integer data_ind;
    initial begin
        for (data_ind = 0; data_ind <= 65535; data_ind = data_ind + 1) begin
            mem_data[data_ind] = 16'h0000;
        end
    end

    // --- Clock Generator --- //
    initial begin
        clk = 0;
    end
    always begin
        #5 clk = ~clk;
    end

    // --- Verification Task --- //
    task check_and_print_mem_data;
        input [15:0] addr;

        begin
            if(uut.memory[addr] !== mem_data[addr]) begin
                $display("Address %0h: Expected=%0h, Actual=%0h   <-- MISMATCHED", addr, mem_data[addr], uut.memory[addr]);
            end else begin
                $display("Address %0h: Expected=%0h, Actual=%0h   <-- MATCH", addr, mem_data[addr], uut.memory[addr]);
            end
        end
    endtask

    task check_and_print_mem_out;
        input [15:0] expected_val;

        begin
            if(uut.mem_out !== expected_val) begin
                $display("      mem_out: Expected=%0h, Actual=%0h   <-- MISMATCHED", expected_val, uut.mem_out);
            end else begin
                $display("      mem_out: Expected=%0h, Actual=%0h   <-- MATCH", expected_val, uut.mem_out);
            end
        end
    endtask

    // --- Test Sequence --- //
    initial begin
        $display("Starting RiSC-16 Data Memory Testbench...");
        
        // 1. Initialize all inputs.
        WE_dmem <= 0; reg_out <= 16'h0000; alu_out <= 16'h0000;
        @(posedge clk); @(posedge clk);

        // TEST 1: Check initial state (all zeros).
        $display("\n[TEST] Verifying initial register state...");
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h0000);
        check_and_print_mem_data(16'h0008);
        check_and_print_mem_data(16'h01A5);
        check_and_print_mem_data(16'h2CDE);
        check_and_print_mem_data(16'hFFFF);

        // TEST 2: Check data memory when WE_dmem = 0 (memory does not change).
        $display("\n[TEST] Not writing to Data Memory...");
        WE_dmem <= 0; reg_out <= 16'h0ff1; alu_out <= 16'h0002;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h0002);
        check_and_print_mem_out(16'h0000);

        // TEST 3: Check memory address 132
        $display("\n[TEST] Writing/Overriding to Memory Addresses...");
        WE_dmem <= 1; reg_out <= 16'h0567; alu_out <= 16'h0000;
        mem_data[16'h0000] <= 16'h0567;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h0000);
        check_and_print_mem_out(16'h0567);
        WE_dmem <= 1; reg_out <= 16'h0345; alu_out <= 16'h00F2;
        mem_data[16'h00F2] <= 16'h0345;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h00F2);
        check_and_print_mem_out(16'h0345);
        WE_dmem <= 1; reg_out <= 16'h5612; alu_out <= 16'h0BAF;
        mem_data[16'h0BAF] <= 16'h5612;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h0BAF);
        check_and_print_mem_out(16'h5612);
        WE_dmem <= 1; reg_out <= 16'hDF56; alu_out <= 16'h2CDE;
        mem_data[16'h2CDE] <= 16'hDF56;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'h2CDE);
        check_and_print_mem_out(16'hDF56);
        WE_dmem <= 1; reg_out <= 16'h89A4; alu_out <= 16'hFFFF;
        mem_data[16'hFFFF] <= 16'h89A4;
        @(posedge clk); @(posedge clk);
        check_and_print_mem_data(16'hFFFF);
        check_and_print_mem_out(16'h89A4);

        #10;
        $display("\n[COMPLETE] Testbench cases are all completed.");
        $finish;
    end

endmodule
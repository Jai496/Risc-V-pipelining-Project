// Include all design files so that "iverilog pipe_tb.v" is the only command needed.
// processor.v is the Phase-I sequential processor and is excluded to avoid
// duplicate module definitions (pc, instruction_mem, etc. are shared).
`include "adder.v"
`include "subtractor.v"
`include "mux2_1.v"
`include "and.v"
`include "and_64bit.v"
`include "or.v"
`include "or_64bit.v"
`include "xor.v"
`include "xor_64bit.v"
`include "slt.v"
`include "sltu.v"
`include "left_shift.v"
`include "right_shift.v"
`include "right_shift_arithmetic.v"
`include "alu.v"
`include "alu_control.v"
`include "pc.v"
`include "register_file.v"
`include "instruction_mem.v"
`include "imm_gen.v"
`include "control_unit.v"
`include "data_memory.v"
`include "if_id_reg.v"
`include "id_ex_reg.v"
`include "ex_mem_reg.v"
`include "mem_wb_reg.v"
`include "forwarding_unit.v"
`include "hazard_detection.v"
`include "flush_unit.v"
`include "branch_predictor.v"
`include "pipeline_processor.v"

module pipe_tb;

reg clk;
reg reset;

integer cycle_count;
integer file;
integer i;

// instantiate processor
pipeline_processor uut(
    .clk(clk),
    .reset(reset)
);



// clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end



// reset
initial begin
    reset = 1;
    cycle_count = 0;
    #20;
    reset = 0;
end



// cycle counter + dynamic stop
always @(posedge clk) begin
    cycle_count = cycle_count + 1;

    // Stop when PC has moved past the last instruction in the program.
    // The testbench appends 4 dummy NOPs after the last real instruction to
    // drain the pipeline, so we wait until the PC is fetching beyond those.
    // 19 instructions total -> last byte address = 18*4 = 72.
    // After the final dummy is fetched, PC = 76.  Give one extra cycle for WB.
    if (!reset && uut.pc_current >= 64'd80) begin

        $display("Program finished");
        $display("Total cycles = %d", cycle_count);

        // open register file
        file = $fopen("register_file.txt","w");

        for(i = 0; i < 32; i = i + 1) begin
            $fdisplay(file,"%016h", uut.regfile_u.reg_array[i]);
        end

        $fdisplay(file,"%d", cycle_count);

        $fclose(file);

        $finish;
    end
end

endmodule
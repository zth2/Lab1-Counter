#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"  // Include Vbuddy functions

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    Vtop *top = new Vtop;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("top.vcd");

    // Initialize Vbuddy
    if (vbdOpen() != 1) return -1;
    vbdHeader("Lab: BCD Counter");

    top->clk = 1;
    top->rst = 1;
    top->en = 0; 
    top->v = 0;

    for (i = 0; i < 600; i++) {
        // Toggle clock
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk = !top->clk;
            top->eval();
        }

        // Enable counter and send Vbuddy values
        if (i > 4) {
            top->en = vbdFlag();  // Ensure vbdFlag() exists in vbuddy.cpp
            top->v = vbdValue();  // Ensure vbdValue() exists in vbuddy.cpp
        }

        // Plot BCD value
        vbdPlot(int(top->bcd), 0, 255);  // Ensure top->bcd exists in top.sv
        vbdCycle(i + 1);  // Ensure vbdCycle() exists in vbuddy.cpp

        top->rst = (i < 2);

        if (Verilated::gotFinish()) exit(0);
    }

    vbdClose();  // Ensure vbdClose() exists in vbuddy.cpp
    tfp->close();
    exit(0);
}

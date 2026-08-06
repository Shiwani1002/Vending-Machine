`timescale 1ns/1ps

module vending_machine_tb;

    //-----------------------------
    // Inputs
    //-----------------------------
    reg clk;
    reg rst;

    reg sel_tea;
    reg sel_coffee;
    reg sel_juice;
    reg sel_water;

    reg coin_5;
    reg coin_10;

    //-----------------------------
    // Outputs
    //-----------------------------
    wire dispense;
    wire [4:0] change;

    //-----------------------------
    // DUT
    //-----------------------------
    vending_machine uut(
        .clk(clk),
        .rst(rst),
        .sel_tea(sel_tea),
        .sel_coffee(sel_coffee),
        .sel_juice(sel_juice),
        .sel_water(sel_water),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .dispense(dispense),
        .change(change)
    );

    //-----------------------------
    // Generate VCD File
    //-----------------------------
    initial begin
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, vending_machine_tb);
    end

    //-----------------------------
    // Clock Generation
    //-----------------------------
    initial
        clk = 0;

    always #5 clk = ~clk;

    //-----------------------------
    // Display Monitor
    //-----------------------------
    initial begin
        $display("==============================================================");
        $display(" Time\tDispense\tChange");
        $display("==============================================================");

        $monitor("%4t\t%b\t\t%0d",
                 $time,
                 dispense,
                 change);
    end

    //-----------------------------
    // Coin Tasks
    //-----------------------------
    task insert5;
    begin
        coin_5 = 1;
        #10;
        coin_5 = 0;
        #10;
    end
    endtask

    task insert10;
    begin
        coin_10 = 1;
        #10;
        coin_10 = 0;
        #10;
    end
    endtask

    //-----------------------------
    // Product Selection Tasks
    //-----------------------------
    task buyTea;
    begin
        sel_tea = 1;
        #10;
        sel_tea = 0;
    end
    endtask

    task buyCoffee;
    begin
        sel_coffee = 1;
        #10;
        sel_coffee = 0;
    end
    endtask

    task buyJuice;
    begin
        sel_juice = 1;
        #10;
        sel_juice = 0;
    end
    endtask

    task buyWater;
    begin
        sel_water = 1;
        #10;
        sel_water = 0;
    end
    endtask

    //-----------------------------
    // Test Sequence
    //-----------------------------
    initial begin

        //-------------------------
        // Initialize Inputs
        //-------------------------
        rst         = 1;

        sel_tea     = 0;
        sel_coffee  = 0;
        sel_juice   = 0;
        sel_water   = 0;

        coin_5      = 0;
        coin_10     = 0;

        //-------------------------
        // Reset
        //-------------------------
        #20;
        rst = 0;

        //--------------------------------------------------
        // TEST 1 : Tea (Exact Payment)
        //--------------------------------------------------
        $display("\nTEST 1 : Tea (₹10)");

        buyTea();

        insert5();
        insert5();

        #40;

        //--------------------------------------------------
        // TEST 2 : Coffee (₹15)
        //--------------------------------------------------
        $display("\nTEST 2 : Coffee (₹15)");

        buyCoffee();

        insert10();
        insert5();

        #40;

        //--------------------------------------------------
        // TEST 3 : Juice (₹20)
        //--------------------------------------------------
        $display("\nTEST 3 : Juice (₹20)");

        buyJuice();

        insert10();
        insert10();

        #40;

        //--------------------------------------------------
        // TEST 4 : Water (₹25)
        //--------------------------------------------------
        $display("\nTEST 4 : Water (₹25)");

        buyWater();

        insert10();
        insert10();
        insert5();

        #40;

        //--------------------------------------------------
        // TEST 5 : Excess Payment (Change Expected)
        //--------------------------------------------------
        $display("\nTEST 5 : Excess Payment");

        buyTea();

        insert10();
        insert5();

        #40;

        //--------------------------------------------------
        // TEST 6 : Insufficient Payment
        //--------------------------------------------------
        $display("\nTEST 6 : Insufficient Payment");

        buyCoffee();

        insert5();

        #60;

        //--------------------------------------------------
        // TEST 7 : Consecutive Purchases
        //--------------------------------------------------
        $display("\nTEST 7 : Consecutive Purchases");

        buyTea();
        insert5();
        insert5();

        #20;

        buyJuice();
        insert10();
        insert10();

        #40;

        //--------------------------------------------------
        // TEST 8 : Reset During Transaction
        //--------------------------------------------------
        $display("\nTEST 8 : Reset During Transaction");

        buyWater();

        insert10();

        rst = 1;
        #20;
        rst = 0;

        #40;

        //--------------------------------------------------
        // Finish
        //--------------------------------------------------
        $display("\n==============================================================");
        $display(" All Test Cases Executed Successfully ");
        $display("==============================================================");

        $finish;

    end

endmodule

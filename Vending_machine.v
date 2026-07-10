`timescale 1ns / 1ps

module vending_machine (
    input              clk,
    input              rst,

    // Product Selection
    input              sel_tea,
    input              sel_coffee,
    input              sel_juice,
    input              sel_water,

    // Coin Inputs
    input              coin_5,
    input              coin_10,

    // Outputs
    output reg         dispense,
    output reg [4:0]   change
);

    //----------------------------------------------------
    // Product Prices
    //----------------------------------------------------
    parameter TEA_PRICE    = 10;
    parameter COFFEE_PRICE = 15;
    parameter JUICE_PRICE  = 20;
    parameter WATER_PRICE  = 25;

    //----------------------------------------------------
    // FSM States
    //----------------------------------------------------
    parameter IDLE      = 2'b00;
    parameter COLLECT   = 2'b01;
    parameter DISPENSE  = 2'b10;

    reg [1:0] state;

    reg [5:0] balance;
    reg [5:0] price;

    //----------------------------------------------------
    // FSM
    //----------------------------------------------------
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state     <= IDLE;
            balance   <= 0;
            price     <= 0;
            dispense  <= 0;
            change    <= 0;
        end

        else
        begin
            case(state)

            //------------------------------------------------
            // IDLE : Wait for Product Selection
            //------------------------------------------------
            IDLE:
            begin
                dispense <= 0;
                change   <= 0;
                balance  <= 0;

                if(sel_tea)
                begin
                    price <= TEA_PRICE;
                    state <= COLLECT;
                end

                else if(sel_coffee)
                begin
                    price <= COFFEE_PRICE;
                    state <= COLLECT;
                end

                else if(sel_juice)
                begin
                    price <= JUICE_PRICE;
                    state <= COLLECT;
                end

                else if(sel_water)
                begin
                    price <= WATER_PRICE;
                    state <= COLLECT;
                end
            end

            //------------------------------------------------
            // COLLECT MONEY
            //------------------------------------------------
            COLLECT:
            begin

                if(coin_5)
                    balance <= balance + 5;

                else if(coin_10)
                    balance <= balance + 10;

                if(balance >= price)
                    state <= DISPENSE;

            end

            //------------------------------------------------
            // DISPENSE PRODUCT
            //------------------------------------------------
            DISPENSE:
            begin
                dispense <= 1;
                change   <= balance - price;

                balance  <= 0;
                price    <= 0;

                state <= IDLE;
            end

            default:
                state <= IDLE;

            endcase
        end
    end

endmodule
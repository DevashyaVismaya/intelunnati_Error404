module AtpMachine(
  input wire clk,      
  input wire reset,    
  input wire placeBill,
  input wire scanBill, 
  input wire cash,     
  input wire upi,      
  input wire paymentReceived,

  output wire acceptCash,   
  output wire displayUPIQRCode,
  output wire updateNextBill,
  output wire calculateBill,
  output wire displayBillAmount,
  output wire displayInstructions,
  output wire completeTransaction,
  output wire printReceipt
);
  

  parameter S0 = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  parameter S4 = 4'b0100;
  parameter S5 = 4'b0101;
  parameter S6 = 4'b0110;
  parameter S7 = 4'b0111;
  parameter S8 = 4'b1000;
  parameter S9 = 4'b1001;
  parameter S10 = 4'b1010;
  parameter S11 = 4'b1011;
  parameter S12 = 4'b1100;
  parameter S13 = 4'b1101;
  parameter S14 = 4'b1110;
  parameter S15 = 4'b1111;
  parameter S16 = 4'b0001;
  parameter S17 = 4'b0010;


  reg [3:0] stateReg, nextState;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      stateReg <= S0;
    end else begin
      stateReg <= nextState;
    end
  end

  always @(stateReg or placeBill or scanBill or cash or upi or paymentReceived) begin
    nextState = stateReg;

    case(stateReg)
      S0: begin
        if (placeBill) begin
          nextState = S1;
        end
      end
      
      S1: begin
        if (scanBill) begin
          nextState = S2;
        end
      end
      
      S2: begin
        if (cash) begin
          nextState = S4;
        end else if (upi) begin
          nextState = S5;
        end
      end
      
      S4: begin
        if (acceptCash) begin
          nextState = S6;
        end else if (paymentReceived) begin
          nextState = S15;
        end
      end
      
      S5: begin
        if (displayUPIQRCode) begin
          nextState = S10;
        end else if (paymentReceived) begin
          nextState = S15;
        end
      end
      
      S7: begin
        if (updateNextBill) begin
          nextState = S10;
        end else if (calculateBill) begin
          nextState = S10;
        end
      end
      
      S8: begin
        if (calculateBill) begin
          nextState = S10;
        end
      end
      
      S9: begin
        if (calculateBill) begin
          nextState = S10;
        end
      end
      
      S10: begin
        if (displayBillAmount) begin
          nextState = S11;
        end
      end
      
      S11: begin
        if (displayInstructions) begin
          nextState = S12;
        end
      end
      
      S13: begin
        if (paymentReceived) begin
          nextState = S15;
        end
      end
      
      S14: begin
        if (paymentReceived) begin
          nextState = S15;
        end
      end
      
      S15: begin
        if (completeTransaction) begin
          nextState = S16;
        end
      end
      
      S16: begin
        if (printReceipt) begin
          nextState = S17;
        end
      end
      
      default: nextState = stateReg;
    endcase
  end


  assign acceptCash = (stateReg == S4);
  assign displayUPIQRCode = (stateReg == S5);
  assign updateNextBill = (stateReg == S7);
  assign calculateBill = (stateReg == S8) || (stateReg == S9) || (stateReg == S10);
  assign displayBillAmount = (stateReg == S11);
  assign displayInstructions = (stateReg == S12);
  assign completeTransaction = (stateReg == S15);
  assign printReceipt = (stateReg == S16);
endmodule

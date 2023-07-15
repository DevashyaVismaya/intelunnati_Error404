module AtpMachine_tb;

  reg clk;
  reg reset;
  reg placeBill;
  reg scanBill;
  reg cash;
  reg upi;
  reg paymentReceived;

  wire acceptCash;
  wire displayUPIQRCode;
  wire updateNextBill;
  wire calculateBill;
  wire displayBillAmount;
  wire displayInstructions;
  wire completeTransaction;
  wire printReceipt;


  ATPMachineController dut(
    .clk(clk),
    .reset(reset),
    .placeBill(placeBill),
    .scanBill(scanBill),
    .cash(cash),
    .upi(upi),
    .paymentReceived(paymentReceived),
    .acceptCash(acceptCash),
    .displayUPIQRCode(displayUPIQRCode),
    .updateNextBill(updateNextBill),
    .calculateBill(calculateBill),
    .displayBillAmount(displayBillAmount),
    .displayInstructions(displayInstructions),
    .completeTransaction(completeTransaction),
    .printReceipt(printReceipt)
  );


  always begin
    #5 clk = ~clk;
  end


  initial begin
    reset = 1;
    #10 reset = 0;
  end


  initial begin

    #20


    placeBill = 1;
    scanBill = 1;
    cash = 1;
    upi = 0;
    paymentReceived = 0;
    #10
    

    placeBill = 1;
    scanBill = 1;
    cash = 0;
    upi = 1;
    paymentReceived = 0;
    #10


    placeBill = 1;
    scanBill = 1;
    cash = 1;
    upi = 0;
    paymentReceived = 1;
    #10


    placeBill = 1;
    scanBill = 1;
    cash = 0;
    upi = 1;
    paymentReceived = 1;
    #10


    placeBill = 1;
    scanBill = 1;
    cash = 1;
    upi = 0;
    paymentReceived = 1;
    #10


    placeBill = 1;
    scanBill = 1;
    cash = 0;
    upi = 1;
    paymentReceived = 1;
    #10



    $finish;
  end
endmodule

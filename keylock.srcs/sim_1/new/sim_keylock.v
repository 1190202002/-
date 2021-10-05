`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/14 22:11:15
// Design Name: 
// Module Name: sim_keylock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_keylock( );
reg reset;
reg k1,k2,k3,k4;
reg p1,p2,p3,p4;
reg clk;
wire red,green,warn;
initial clk=0;
always #5 clk=~clk;
initial
begin
    reset=0;
    k1=0;
    k2=0;
    k3=0;
    k4=0;
    p1=0;
    p2=0;
    p3=0;
    p4=0;
    #5 reset=1;
   
end
always begin
   #10 k1=0;k2=1;k3=1;k4=1;
   #10 p1=1;p2=0;p3=0;p4=0;
   #10 k1=0;k2=1;k3=1;k4=1;
   #10 p1=1;p2=1;p3=0;p4=0;
   #10 k1=1;k2=1;k3=1;k4=0;
   #10 p1=1;p2=0;p3=1;p4=0;
   #10 k1=1;k2=1;k3=0;k4=1;
   #10 p1=1;p2=0;p3=0;p4=1;
   #10 k1=0;k2=0;k3=0;k4=1;
   #10 p1=1;p2=0;p3=0;p4=0;
   #10 k1=0;k2=0;k3=1;k4=1;
   #10 p1=1;p2=1;p3=0;p4=0;
   #10 k1=0;k2=1;k3=1;k4=0;
   #10 p1=1;p2=0;p3=1;p4=0;
   #10 k1=1;k2=0;k3=0;k4=1;
   #10 p1=1;p2=0;p3=0;p4=1;
   
       
   end
keylock ul(clk,reset,k1,k2,k3,k4,p1,p2,p3,p4,red,green,warn);
    


endmodule

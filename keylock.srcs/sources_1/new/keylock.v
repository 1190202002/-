`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/12 17:59:10
// Design Name: 
// Module Name: keylock
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


module keylock(
input clk,input reset,input k1,input k2,input k3,input k4,input p1,input p2,input p3,input p4,
output reg red,reg green,reg warn
);
    reg [4:0]cur=0;
    reg [4:0]nxt=0;
    //定义状态
    parameter s0 = 5'b00000; 
    parameter s1 = 5'b00001; 
    parameter s2 = 5'b00010; 
    parameter s3 = 5'b00100; 
    parameter s4 = 5'b01000; 
    parameter s5 = 5'b10000;
    //设置密码
    parameter password=16'b0001001101101001; 
    //复位
    always @(negedge reset or posedge clk)
        begin
             if(!reset) begin
                cur<=s0;  //复位
              end
            else 
            cur<=nxt;//下一状态
       end        
  //时钟
    parameter CNT_20s=1999999999;
    reg [30:0] cnt_20s;        
     always @(negedge reset or posedge clk)
        begin
             if(!reset) begin
                cnt_20s<=0;//时钟复位
              end
            else if(cnt_20s==CNT_20s)
                cnt_20s<=0;
            else
               cnt_20s=cnt_20s+1'b1;//时钟加1
       end            
    //状态转换
    always @(k1 or k2 or k3 or k4 or p1 or p2 or p3 or p4)
        begin
            if(!reset) begin
                nxt=s0;             //复位
             end
            else if(cnt_20s==CNT_20s-1)
                case(cur)
                    s0:nxt=s4;
                    s1: nxt=s4;
                    s2:nxt=s4;
                    s3:nxt=s4;
                    s4:nxt=s4;
                    s5:nxt=s5;
                    default:nxt=s4;
               endcase              //达到时间状态转换
            else begin
                case(cur)
                    s0:begin
                    if(p1==1)
                      nxt=({k1,k2,k3,k4}==password[15:12])?s1:s0;
                    else 
                      nxt=s0;
                    end
                    s1:begin
                    if(p2==1)
                      nxt=({k1,k2,k3,k4}==password[11:8])?s2:s0;
                    else 
                      nxt=s1;
                    end
                    s2:begin
                    if(p3==1)
                      nxt=({k1,k2,k3,k4}==password[7:4])?s3:s0;
                    else 
                      nxt=s2;
                    end
                    s3:begin
                    if(p4==1)
                      nxt=({k1,k2,k3,k4}==password[3:0])?s5:s0;
                    else 
                      nxt=s3;
                    end
                    s4:begin
                    nxt=s4;
                    end
                    s5:begin
                    nxt=s5;
                    end
                    default:nxt=5'bxxxxx;
               endcase               //未达到时间状态转换
             end
           
        end
   //各状态下显示情况
    always @(reset or cur)
        begin
            if (!reset)begin
                green<=0;
                red<=1;
                warn<=0;
            end
            else begin
            case(cur)
            s0:begin
                green<=0;
                red<=1;
                warn<=0;
            end
            s1:begin
                green<=0;
                red<=1;
                warn<=0;
            end
            s2:begin
                green<=0;
                red<=1;
                warn<=0;
            end
            s3:begin
                green<=0;
                red<=1;
                warn<=0;
            end
            s4:begin
                green<=0;
                red<=1;
                warn<=1;
            end
            s5:begin
                green<=1;
                red<=0;
                warn<=0;
            end
           default:begin
                green<=0;
                red<=1;
                warn<=0;
            end
           endcase
        end
        end
endmodule


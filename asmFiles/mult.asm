  org 0x0000
  ori   $29, $0, 0xfffc    //set stack pointer

  and   $6, $6, $0
  ori   $6, $6, 4
  push  $6                //push first operand

  and   $6, $6, $0
  ori   $6, $6, 8
  push  $6                //push second operand

mult:
  and   $6, $6, $0  //load 0 in reg06 to accumulate
  and   $2, $2, $0   //load 1 in reg01 to subtract
  ori   $2, $2, 0x0001
  pop   $7      //operand 1
  pop   $8      //operand 2

myloop:
  addu  $6, $6, $8
  subu  $7, $7, $2
  bne   $7, $0, myloop
  push  $6
  halt

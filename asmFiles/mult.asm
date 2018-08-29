  org 0x0000

  lw    $29, 0xfffc($0) //set the stack pointer in reg29
  lw    $6, $0  //load 0 in reg06 to accumulate
  lw    $1, 1   //load 1 in reg01 to subtract
  pop   $7      //operand 1
  pop   $8      //operand 2

myloop:
  addu  $6, $6, $8
  subu  $7, $7, $1
  bne   $7, $0, myloop
  halt

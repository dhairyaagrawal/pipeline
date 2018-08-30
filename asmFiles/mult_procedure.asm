  org 0x0000

  and   $29, $29, $0
  ori   $29, $29, 0xfffc    //set stack pointer

  and   $6, $6, $0
  ori   $6, $6, 0x0011
  push  $6                //push first operand

  and   $6, $6, $0
  ori   $6, $6, 0x00fa
  push  $6                //push second operand

  and   $6, $6, $0
  ori   $6, $6, 0x0f11
  push  $6

  and   $6, $6, $0
  ori   $6, $6, 0x000f
  push  $6

  and   $28, $28, $0
  ori   $28, $28, 0xfff8
loop:
  jal   mult
  bne   $29, $28, loop
  halt

  org 0x1000
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
  jr    $31

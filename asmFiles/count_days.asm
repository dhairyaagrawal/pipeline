  org 0x0000

  ori   $29, $0, 0xfffc    //set stack pointer
//Days = CD + 30*(CM-1) + 365*(CY-2000)
  ori $3, $0, 20    //CD
  ori $4, $0, 8     //CM
  ori $5, $0, 2018  //CY

  //30*(CM-1)
  ori $11, $0, 30
  ori $12, $0, 1
  subu  $13, $4, $12
  push  $11
  push  $13
  jal   main
  pop   $4

  //365*(cy-2000)
  ori $11, $0, 2000
  ori $12, $0, 365
  subu  $13, $5, $11
  push  $12
  push  $13
  jal   main
  pop   $5

  addu  $11, $3, $4
  addu  $12, $11, $5
  push  $12
  halt
//////////////////////////////////////////
  org 0x1000

main:
  and   $6, $6, $0  //load 0 in reg06 to accumulate
  ori   $2, $0, 1   //load 1 in reg01 to subtract
  pop   $7      //operand 1
  pop   $8      //operand 2

myloop:
  addu  $6, $6, $8
  subu  $7, $7, $2
  bne   $7, $0, myloop
  push  $6
  jr    $31

#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

mainp0:
  push $ra
  ori $t6, $0, 0x10 #seed
  ori $t7, $0, 256  #counter for generating 256 random variables


lp0:
  #crc section
  or  $a0, $0, $t6    #load seed/random[N-1] from $t6 into $a0
  jal crc32
  or  $t8, $0, $v0    #load crc value from $v0 into $t8

  #lock/unlock section
  ori $a0, $0, l1     # move lock to arguement register
  jal lock
  or  $a0, $0, $t8    #load crc into argument 0 variable
  jal myPush
  ori $a0, $0, l1     # move lock to arguement register
  jal unlock          # release the lock

  #check loop variable
  or $t6, $0, $t8    #load crc variable into $t6 register
  addi $t7, $t7, -1    #decrement random variable count
  bne  $t7, $0, lp0

  #return to calling function
  pop $ra
  jr $ra

#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x200               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt

mainp1:
  push $ra
  ori $s1, $0, 256    #static number for consuming 256 variables
  ori $s2, $0, 0    #register for max value
  ori $s3, $0, 0xFFFFFFFF #register for min value
  ori $s4, $0, 0    #register for sum
  ori $s5, $0, 0    #up count for consuming 256 variables
  ori $s6, $0, 0    #quotient
  ori $s7, $0, 0    #register to track successful pop

lp1:
  #lock
  ori $a0, $0, l1     # move lock to arguement register
  jal lock
  #pop
  jal myPop

ul1:
  #unlock
  ori $a0, $0, l1     # move lock to arguement register
  jal unlock          # release the lock

  #check if pop was successful
  beq $s7, $0, lp1    #if stack was empty, go back to lock

  #increment & check loop variable
  addi $s5, $s5, 1
  #beq $s1, $s5, stats #this is so it doesnt take the beq below once all crcs have been consumed


stats:
  #mask upper 16 bits
  andi $v1, $v1, 0xFFFF
  #add to sum
  add $s4, $s4, $v1

  #max
  or $a0, $0, $v1    #load popped value into $a0
  or $a1, $0, $s2    #load max value into $a1
  jal max
  or $s2, $0, $v0    #return new max value to max register
  #min
  or $a1, $0, $s3    #load min value into $a1
  jal min
  or $s3, $0, $v0

  bne $s1, $s5, lp1 #jumps back to loop for consuming variables if count hasnt recahed max # to consume

  #calculate average
  or $a0, $0, $s4
  ori $a1, $0, 256
  jal divide
  or $s6, $0, $v0    #quotient

  #return to calling function
  pop $ra
  jr $ra


myPop:
  ori $t0, $0, stackoffset  #load stack offset memory location
  ori $t1, $0, stackbase    #load stack base memory loction
  lw  $t2, 0($t0)           #load actual stack offset into t2
  ori $t5, $0, 0x0FFC
  beq $t2, $t5, breakPop          #check if stack is empty

  ori $s7, $0, 1            #flag for successful pop
  lw  $t3, 0($t1)           #load actual stack base into t3
  add $t4, $t3, $t2         #add stack offset to stack base
  addi $t4, $t4, 4

  lw  $v1, 0($t4)           #load value off of stack
  sw  $0,  0($t4)           #zero out stack value
  addi $t2, $t2, 4          #increment stack offset
  sw  $t2, 0($t0)           #store new stack offset at stackoffset memory location
  jr $ra

breakPop:
  ori $s7, $0, 0            #flag for unsuccessful pop
  jr $ra

myPush:
  ori $t0, $0, stackoffset  #load stack offset memory location
  ori $t1, $0, stackbase   #load stack base memory location
  lw  $t2, 0($t0)           #load actual stack offset into t2
  lw  $t3, 0($t1)
  add $t4, $t3, $t2         #add stack offset to stack base

  sw  $a0, 0($t4)          #sw @ stackbase+offset
  addi  $t2, $t2, -4       #decrement stackoffset
  sw  $t2, 0($t0)          #store new stack offset to stack offset memory location
  jr $ra

#------------------------LOCK-------------------------------#
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra
#------------------------------------------------------------#


#-----------------------UNLOCK-------------------------------#
# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra
#------------------------------------------------------------#


#------------------------------CRC---------------------------#
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

loop1:
  slt $t4, $t2, $t3
  beq $t4, $zero, loop2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, loop3
  xor $a0, $a0, $t1
loop3:
  addiu $t2, $t2, 1
  j loop1
loop2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------------#


#---------------------------DIVIDE---------------------------#
# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#------------------------------------------------------------#

#---------------------------MINMAX---------------------------#
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#------------------------------------------------------------#

#Memory
l1:
  cfw 0x0

#stack
stackbase:
  cfw 0x9000

org 0x9400
stackoffset:
  cfw 0x0FFC

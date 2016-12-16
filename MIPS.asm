.data
#Main Program Messages...
main_Message : .asciiz "\nInput a value 1.delete-2.replace-3.convertCase-4.convertNumber-5.sortChar-6.sortInt-7.compareStrings : "
continue_Message : .asciiz "\nIf you want to continue press 1 else any key."
###############################################################################
#Convert Case Procedure Data Segment...
convertCase_Message: .asciiz "Your input in capital is: "
convertCase_input_list: .asciiz "Cse 338"
convertCase_output_list: .space 24
################################################################################
#Convert BinaryToDecimal Procedure Data Segment...
convertBinarytoDecimal_input_list: .asciiz "1101"
convertNumberHexadecimal_input_list :.asciiz "11111011"
convertNumberHexadecimal_Message:.asciiz "Binary Number's Hexadecimal form is : "
convertBinarytoDecimal_Message:	.asciiz "Binary Number's Decimal form is : "
convertBinarytoDecimal_type: .asciiz "2"
################################################################################
#Compare String Procedure Data Segment...
compareString_str1: .asciiz "John"
compareString_str2: .asciiz "Ann"
compareString_isGreater: .asciiz " is greater than "
compareString_isEqual: .asciiz " is equal "
compareString_str1_c: .space 24
compareString_str2_c: .space 24
space:  .asciiz " "
################################################################################
replace_str1: .asciiz "o"
replace_str2: .asciiz "x"
replace_list: .asciiz "Computer Organization"
################################################################################
delete_list: .asciiz "I AM USING SPIM SIMULATOR"
delete_str:  .asciiz "IM"
delete_type: .asciiz  "0"
################################################################################
sortChar_input_list: .asciiz "Cse_338"
sortChar_type: .asciiz "1"
sortChar_output_list: .space 24
################################################################################
jumptable: .word main, case1, case2, case3, case4,case5,case6,case7
################################################################################
sortInt_prompt1: .asciiz "Sorted Integer Array : "
sortInt_space : .asciiz " "
sortInt_array: .word 1,6,23,-5,18
################################################################################
.globl main
.text

main:

li $v0, 4 	 
la $a0, main_Message
syscall
li $v0, 5 	
syscall
blez $v0, main 	
li   $t3, 7
bgt  $v0, $t3, main 
la $a1, jumptable 	
sll $t0, $v0, 2 	
add $t1, $a1, $t0     
lw $t2, 0($t1)  	
jr $t2 			

#######################################################################################
case1: 
	la $a0,delete_list
	la $a1,delete_str
	la $a2,delete_type
	li $t7,0   #count
	li $t5,0   #shift count

	lb  	$t2,0($a2)
	beq 	$t2,48,delete_main_loop
	beq     $t2,49,delete_main_loop1
	
delete_main_loop:
	li   $t7,0
	lb $t0,0($a0)
	lb $t1,0($a1)
	beq $t0,$t1,delete_addition
	addi $a0,$a0,1
	j delete_main_loop
delete_addition:
	addi $t7,$t7,1 #count=count+1
	addi $a0,$a0,1
	addi $a1,$a1,1
	lb   $t0,0($a0)
	lb   $t1,0($a1)
	beqz $t1,delete_delete_loop #if str shows null value delete .
	beq  $t0,$t1,delete_addition
	b delete_sub  #if next element is not equal then restore count and str address
delete_delete_loop:
	move $a3,$a0  #current address of a0 , assigned to a3
	sub  $a0,$a0,$t7
delete_remove_loop:
	lb   $t6,0($a3)
	beqz $t6,delete_exit_loop
	sb   $t6,0($a0)            #this loop makes shift in $a0 address
	addi $a3,$a3,1
	addi $a0,$a0,1
	j delete_remove_loop
delete_sub:
	sub  $a1,$a1,$t7
	li   $t7,0
	addi $a0,$a0,1
	j delete_main_loop
delete_exit_loop:
	sb   $zero,0($a0)
	li $v0,4
	la $a0,delete_list
	syscall
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
##########################################################################

delete_main_loop1:
	lb $t0,0($a0)
	beqz $t0,delete_print
	lb $t1,0($a1)
	beq $t0,$t1,delete_addition1
	addi $a0,$a0,1
	j delete_main_loop1
delete_addition1:
	addi $t7,$t7,1 #count=count+1
	addi $a0,$a0,1
	addi $a1,$a1,1
	lb   $t0,0($a0)
	lb   $t1,0($a1)
	beqz $t1,delete_delete_loop1
	beq  $t0,$t1,delete_addition1
	b delete_sub1
delete_delete_loop1:
	move $a3,$a0
	sub  $a0,$a0,$t7
delete_remove_loop1:
	lb   $t6,0($a3)
	beqz $t6,delete_exit_loop1
	sb   $t6,0($a0)
	addi $a3,$a3,1
	addi $a0,$a0,1
	addi $t5,$t5,1
	j delete_remove_loop1
delete_sub1:
	sub  $a1,$a1,$t7
	li   $t7,0
	addi $a0,$a0,1
	j delete_main_loop1
delete_exit_loop1:
	sb   $0,0($a0)
	sub  $a0,$a0,$t5
	sub  $a1,$a1,$t7
	li   $t5,0
	li   $t7,0
	j delete_main_loop1
delete_print:	
	li $v0,4
	la $a0,delete_list
	syscall
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall	
#######################################################################################
case2:
	
    la $a0,replace_list
	la $a2,replace_str2
	la $a1,replace_str1
	li $t7,0     #count=0
      
        
        li      $s0, 0
        la      $s1, replace_str1
test:
        lb      $s2, 0($s1)
        beqz    $s2, done
        addi    $s0, $s0, 1
        addi    $s1, $s1, 1
        j       test
done:
 	move    $t5, $s0                  
replace_main_loop:
	lb   $t0,0($a0)
	beqz $t0,replace_exit_loop
	lb   $t1,0($a1)
	beq  $t0,$t1,replace_addition
	addi $a0,$a0,1
	j replace_main_loop
replace_addition:
	addi $t7,$t7,1 #count=count+1
	addi $a2,$a2,1
	addi $a0,$a0,1
	addi $a1,$a1,1
	lb   $t0,0($a0)
	lb   $t1,0($a1)
	beqz $t1,replace_replace_loop
	beq  $t0,$t1,replace_addition
	b replace_sub
replace_replace_loop:    
	beqz $t7,replace_again
	addi $a0,$a0,-1
	addi $a2,$a2,-1
	lb   $t2,0($a2)
	sb   $t2,0($a0)
	addi $t7,$t7,-1
	j replace_replace_loop
replace_sub:
	addi $t7,$t7,-1
	addi $a1,$a1,-1
	addi $a0,$a0,1
	addi $a2,$a2,-1
	j replace_main_loop
replace_exit_loop:
	li $v0,4
	la $a0,replace_list
	syscall 
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall	
replace_again:
	add  $a0,$a0,$t5
	sub  $a1,$a1,$t5
	lb   $t0,0($a0)
	beqz $t0,replace_exit_loop
	j replace_main_loop
###############################################################################
case3: 
      li    $v0,4
      la    $a0,convertCase_Message    
      syscall
      la    $a0,convertCase_input_list 
      la    $a1,convertCase_output_list
convertCase_loop:
      lb    $t1,($a0)
      beqz  $t1,convertCase_exit_loop   
      blt   $t1,'a',convertCase_no_change
      bgt   $t1,'z',convertCase_no_change
      addiu $t1,$t1,-32           
convertCase_no_change:
      sb    $t1,0($a1)
      addiu $a0,$a0,1        
      addiu $a1,$a1,1
      j     convertCase_loop
convertCase_exit_loop:	
      li $v0,4
      la $a0,convertCase_output_list    
      syscall
      li $v0,4 	
      la $a0,continue_Message
      syscall
      li $v0,5
      syscall
      beq $v0,1,main
      li $v0,10           
      syscall
############################################################################################
case4:
	la $a3,convertBinarytoDecimal_type
	lb $t0,0($a3)
	beq $t0,50,type2
	li $a3,0
	la $a0,convertBinarytoDecimal_Message
	li $v0,4
	syscall
	li $t0,0    # i
	li $t1,0    # j
	li $t2,1    #power_sum
	li $t3,0    #sum
	la $a0,convertBinarytoDecimal_input_list
	li      $s0, 0
        la      $s1, convertBinarytoDecimal_input_list
get_length:
        lb      $s2, 0($s1)
        beqz    $s2, get_length_done
        addi    $s1, $s1, 1
        beq     $s2,32,get_length
        addi    $s0, $s0, 1
        j       get_length
get_length_done:
 	move    $t4, $s0  #length
 	add     $t5, $0,$t4 #length_copy -2 olan
	lb      $t6,0($a0) 
	beq     $t6,49,one_loop #if(array[0]==1)
	b zero_loop
one_loop:
	addi $t4,$t4,-2   #length=length-2
one_loop_main:	
	li $t1,0    # j
	blt  $t0,$t5,for_one_loop  # i < 4 
	addi $t3,$t3,-1		# sum = sum - 1 
	b print_convertToDecimal
for_one_loop:
	addi $a0,$a0,1
	lb   $t6,0($a0)
	beq  $t6,32,one_loop_main
	beq  $t6,48,length_check     # if(array[i]==0)
	beq  $t6,49,length_decrease  #length=length-1;
length_decrease:
	addi $t4,$t4,-1 #length=length-1;
	addi $t0,$t0,1
	j one_loop_main
length_check:
	beqz $t4,power_sum_value_1   # if(length==0)
	bne  $t4,$zero,power_sum_for_loop  #if(length!=0)

power_sum_value_1:
	li $t2,1 #  power_sum=1;
	sub $t3,$t3,$t2 #sum=sum-power_sum;
	addi $t4,$t4,-1 # length=length-1;
	addi $t0,$t0,1	
	j one_loop_main
power_sum_for_loop:
	blt $t1,$t4,power_sum_value_2  # if(j<length)
	sub $t3,$t3,$t2 #sum=sum-power_sum;
	li  $t2,1       #power_sum=1;
	addi $t4,$t4,-1 # length=length-1;
	addi $t0,$t0,1	
	j one_loop_main
power_sum_value_2:
	sll $t2,$t2,1  #power_sum=power_sum*2
	addi $t1,$t1,1 #j=j+1
	j power_sum_for_loop
zero_loop:
	addi $t4,$t4,-2   #length=length-1
zero_loop_main:	
	li $t1,0    # j
	blt  $t0,$t5,for_zero_loop  # i < 4 
	b print_convertToDecimal
for_zero_loop:
	addi $a0,$a0,1
	lb   $t6,0($a0)
	beq  $t6,32,zero_loop_main
	beq  $t6,49,length_check_zero     # if(array[i]==0)
	beq  $t6,48,length_decrease_zero  #length=length-1;
length_decrease_zero:
	addi $t4,$t4,-1 #length=length-1;
	addi $t0,$t0,1
	j zero_loop_main
length_check_zero:
	beqz $t4,power_sum_value_1_zero   # if(length==0)
	bne  $t4,$zero,power_sum_for_loop_zero  #if(length!=0)

power_sum_value_1_zero:
	li $t2,1 #  power_sum=1;
	add $t3,$t3,$t2 #sum=sum+power_sum;
	addi $t4,$t4,-1 # length=length-1;
	addi $t0,$t0,1	
	j zero_loop_main
power_sum_for_loop_zero:
	blt $t1,$t4,power_sum_value_2_zero  # if(j<length)
	add $t3,$t3,$t2 #sum=sum+power_sum;
	li  $t2,1       #power_sum=1;
	addi $t4,$t4,-1 # length=length-1;
	addi $t0,$t0,1	
	j zero_loop_main
power_sum_value_2_zero:
	sll $t2,$t2,1  #power_sum=power_sum*2
	addi $t1,$t1,1 #j=j+1
	j power_sum_for_loop_zero
	
print_convertToDecimal:
	li $v0,1
	move $a0,$t3
	syscall
   	li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall	

type2:
	li $s0,0
	li $a1,0
	li $s1,0
	la $s0,convertNumberHexadecimal_input_list
	la $a1,convertNumberHexadecimal_input_list
	li $t5,0  #sum
	li $t7,8  #2'exponent
convertNumberHexadecimalget_length:
	lb $t0,0($s0)
	beqz $t0,convertNumberHexadecimalget_length_done
	addi $s0,$s0,1
	addi $s1,$s1,1
	j convertNumberHexadecimalget_length
convertNumberHexadecimalget_length_done:
	move $t6,$s1   #t6 is our length
	li $t0,0
	li $s0,0
	la $a0,convertNumberHexadecimal_Message
	li $v0,4
	syscall
	li $a0,0
	b convertNumberHexadecimal_main

convertNumberHexadecimal_main:
	beqz $t6,convertNumberHexadecimal_print_loop
	lb  $t0,0($a1)
	beq $t0,48,convertNumberHexadecimal_zero_loop
	beq $t0,49,convertNumberHexadecimal_one_loop
	
convertNumberHexadecimal_one_loop:
	add $t5,$t5,$t7
	beq $t7,1,convertNumberHexadecimal_value_assign_loop
	srl $t7,$t7,1
	addi $t6,$t6,-1
	addi $a1,$a1,1
	j convertNumberHexadecimal_main
convertNumberHexadecimal_value_assign_loop:
	li $t7,8
	addi $t6,$t6,-1
	addi $a1,$a1,1
	b convertNumberHexadecimal_print_loop
convertNumberHexadecimal_zero_loop:
	beq $t7,1,convertNumberHexadecimal_value_assign_loop
	srl $t7,$t7,1
	addi $a1,$a1,1
	addi $t6,$t6,-1
	j convertNumberHexadecimal_main
convertNumberHexadecimal_print_loop:
	beq  $t5,10,convertNumberHexadecimal_print_A
	beq  $t5,11,convertNumberHexadecimal_print_B
	beq  $t5,12,convertNumberHexadecimal_print_C
	beq  $t5,13,convertNumberHexadecimal_print_D
	beq  $t5,14,convertNumberHexadecimal_print_E
	beq  $t5,15,convertNumberHexadecimal_print_F
	b convertNumberHexadecimal_print_default
convertNumberHexadecimal_print_A:
	li $a0,65
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
 	li $v0,10
	syscall
convertNumberHexadecimal_print_B:
	li $a0,66
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
convertNumberHexadecimal_print_C:
	li $a0,67
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
convertNumberHexadecimal_print_D:
	li $a0,68
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
convertNumberHexadecimal_print_E:
	li $a0,69
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
convertNumberHexadecimal_print_F:
	li $a0,70
	li $v0,11
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
convertNumberHexadecimal_print_default:
	move $a0,$t5
	li $v0,1
	syscall
	li $t5,0
	bnez $t6,convertNumberHexadecimal_main
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
        li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall
######################################################################
case5:
        la      $a0,sortChar_input_list
	la 	$a2,sortChar_type
	lb  	$t0,0($a2)
	beq 	$t0,49,type1_loop_outer
type1_loop_outer:
	lb      $t0,0($a0)
	beqz    $t0,type1_loop_end
	addi    $a0,$a0,1
	move    $a1,$a0
	b 	type1_loop_inner

type1_loop_inner:
	lb      $t1,0($a1)
	beqz    $t1,type1_loop_outer
	lb      $t0,-1($a0)
	bgt     $t0,$t1,swap
	addi 	$a1,$a1,1
	j type1_loop_inner
swap:
	sb $t0,0($a1)
	sb $t1,-1($a0)
	addi $a1,$a1,1
	j type1_loop_inner
type1_loop_end:	
	li $v0,4
        la $a0,sortChar_input_list
        syscall
        li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
    
######################################################################################        


case6:
	sortInt_main:
	la $a0,sortInt_array
	la $a1,sortInt_array	
	li $t5,0  #counter
	li $t6,-1  #i
	li $t7,0  #j
	li $t4,0  #length
	
	li      $s0, 0
        la      $s1, sortInt_array
sortInt_test:
        lw      $s2, 0($s1)
        beqz    $s2, sortInt_done
        addi    $s0, $s0, 1
        addi    $s1, $s1, 4
        j       sortInt_test
sortInt_done:
 	move    $t4, $s0  	
sortInt_for_outer:
	addi $t6,$t6,1
	move $t7,$t6
        addi $t7,$t6,1
        beqz $t5,sortInt_continue
        addi $a0,$a0,4
        addi $t5,$t5,-4
        sub  $a1,$a1,$t5
        li   $t5,0
sortInt_continue:
	blt $t6,$t4,sortInt_for_inner	
	la $a1,sortInt_array
	li $v0,4
	la $a0,sortInt_prompt1
	syscall
	j sortInt_exit	      
sortInt_for_inner:
	blt  $t7,$t4,sortInt_if_loop
	j sortInt_for_outer
sortInt_if_loop:
	lw $t0,0($a0)   #temp=array[i]
	lw $t1,4($a1)   #t1=array[j]
	bgt $t0,$t1,sortInt_swap
	addi $t7,$t7,1
	addi $a1,$a1,4
	addi $t5,$t5,4
	j sortInt_for_inner
sortInt_swap:   
	sw $t0,4($a1)
	sw $t1,0($a0)
	addi $t7,$t7,1
	addi $a1,$a1,4
	addi $t5,$t5,4
	j sortInt_for_inner

sortInt_exit:	
	lw $t2,0($a1)
	beqz $t2,sortInt_quit
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,sortInt_space
	syscall
	addi $a1,$a1,4
	j sortInt_exit
sortInt_quit:
	li $v0, 4 	 
        la $a0, continue_Message
        syscall
	li $v0,5
        syscall
        beq $v0,1,main
	li $v0,10
	syscall	
	
####################################################################################
case7:
	la $a0,compareString_str1 #load the address of the str1 = John
        la $a1,compareString_str2 #load the address of the str2 = Ann
        bgtz $s7,compareString_Compare_Main   # if $t7 greater than zero then the string placement is done.
        la $s0,compareString_str1_c
        la $s1,compareString_str2_c       
	li $s3, 0
	li $s5, 0
compareString_get_length:
        lb      $s2, 0($a0)
        beqz    $s2, compareString_get_length_done
        sb      $s2, 0($s0)
        addi    $a0, $a0,1 
        addi    $s3, $s3, 1
        addi    $s0,$s0,1
        j       compareString_get_length
compareString_get_length_done:
	lb      $s4, 0($a1)
        beqz    $s4,compareString_loop_
        sb      $s4,0($s1)
        addi    $s1,$s1,1
        addi    $a1, $a1,1
        addi    $s5, $s5, 1
        j       compareString_get_length_done	
compareString_loop_:
	sub   $a0,$a0,$s3
	sub   $a1,$a1,$s5
compareString_loop1:
	lb    $t2,0($a0)
	beqz  $t2,compareString_loop2    
        blt   $t2,'a',compareString_no_change1
        bgt   $t2,'z',compareString_no_change1
	addiu $t2,$t2,-32      # convert to uppercase       
        sb    $t2,0($a0)
        addiu $a0,$a0,1        # increment pointer 
        j compareString_loop1
compareString_no_change1:
       addiu $a0,$a0,1        # increment pointer 
        j compareString_loop1
compareString_loop2:   
        lb    $t3,0($a1)
	beqz  $t3,compareString_UpperCase_Exit    
	blt   $t3,'a',compareString_no_change2
        bgt   $t3,'z',compareString_no_change2
	addiu $t3,$t3,-32      # convert to uppercase     
        sb    $t3,0($a1)
        addiu $a1,$a1,1        # increment pointer 
        j compareString_loop2
compareString_no_change2:
      addiu $a1,$a1,1        # increment pointer 
      j     compareString_loop2

compareString_UpperCase_Exit:	
      la $a0,compareString_str1
      la $a1,compareString_str2
      b compareString_Compare_Main
     
compareString_Compare_Main:
      lb $t0,0($a0)
      lb $t1,0($a1)
      beqz $t0,compareString_equal
      bne $t0,$t1,compareString_compare
      addi $a0,$a0,1
      addi $a1,$a1,1
      j compareString_Compare_Main
compareString_compare:
      bgt $t0,$t1,compareString_exit
      la  $a0,compareString_str2_c      
      li $v0,4
      syscall 
      la $a0,compareString_isGreater
      li $v0,4
      syscall
      la $a0,compareString_str1_c      
      li $v0,4
      syscall
      addi $s7,$s7,1
       li $v0, 4 	 # Code to print a string
      la $a0, continue_Message
      syscall
      li $v0,5
      syscall
      beq $v0,1,main
      li $s7,0
      li $v0,10           # exit
      syscall
compareString_exit:   
      la $a0,compareString_str1_c      
      li $v0,4
      syscall
      la $a0,compareString_isGreater
      li $v0,4
      syscall
      la $a0,compareString_str2_c       
      li $v0,4
      syscall 
      addi $s7,$s7,1
       li $v0, 4 	 # Code to print a string
      la $a0, continue_Message
      syscall
      li $v0,5
      syscall
      beq $v0,1,main
      li $s7,0
      li $v0,10           # exit
      syscall
compareString_equal:
      beqz $t1,compareString_are_equal
      la $a0,compareString_str2_c     
      li $v0,4
      syscall 
      la $a0,compareString_isGreater
      li $v0,4
      syscall
      la $a0,compareString_str1_c     
      li $v0,4
      syscall
      addi $s7,$s7,1
      li $v0, 4 	 # Code to print a string
      la $a0, continue_Message
      syscall
      li $v0,5
      syscall
      beq $v0,1,main
      li $s7,0
      li $v0,10           # exit
      syscall
compareString_are_equal:
      la $a0,compareString_str1_c      
      li $v0,4
      syscall
      la $a0,compareString_isEqual
      li $v0,4
      syscall
      la $a0,compareString_str2_c       
      li $v0,4
      syscall 
      addi $s7,$s7,1
      li $v0, 4 	 # Code to print a string
      la $a0, continue_Message
      syscall
      li $v0,5
      syscall
      beq $v0,1,main
      li $s7,0
      li $v0,10           # exit
      syscall

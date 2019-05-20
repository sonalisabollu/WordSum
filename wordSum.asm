		.data
MAXSIZE = 10
inventory:	.word	311,29,410,138,33,7,55,600,10,272    # Array of 10 Elements and Each Element takes 4 Byte
 	
total:		.asciiz	"\nThe total inventory is: "

		.code
		.globl	main
main:	
	li	$t0,0		# $t0 is the index
	li	$t1,0		# $t1 is the offset
	li	$t2,0		# $t2 is the total inventory
	li	$t3,0		# $t3 is the current item's inventory
	b	test
				# Effective Address = BaseAddress + offset

loop:	#  The loop to sum up all the inventory
								
	la	$t5,inventory	# This is the BaseAddress
	add	$t5,$t5,$t1	# add the current offset
	lw	$t3,0($t5)	# load the current inventory
	add	$t2,$t2,$t3	# add it to the total inventory
	add	$t1,$t1,4	# calculate new offset by adding 4 so next time next word is fetched
	add     $t0,$t0,1	# next index

test:	li	$t4,MAXSIZE
	bne	$t0,$t4,loop

	la	$a0,total	
	syscall	$print_string
	mov	$a0,$t2	
	syscall	$print_int

	syscall $exit
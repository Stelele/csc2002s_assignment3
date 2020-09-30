.data
inputRequest: .asciiz "Enter a string:\n"
outputMessage: .asciiz "The value +5 is:\n"
userInput: .space 10

.text
main:
    #Output request for user input
    la		$a0, inputRequest	 
    li		$v0, 4		# command to print string
    syscall

    #Capture user input string
    li		$a1, 10		# limit string size to 10 characters

    la		$a0, userInput		# set userInput as address to store input 
    li		$v0, 8		# capture user input command
    syscall

    #Output output message
    la		$a0, outputMessage		# address storing output message
    li		$v0, 4		# $v0 =4 
    syscall

    la		$t0, userInput		# address storing captured user input
    li		$t1, 0		# $t1 =0, where final sum is stored 
     
        
    ascToIntLoop:
        lb		$t2, 1($t0)		# Load byte 1 after byte located in $t0
        addi	$t0, $t0, 1			# $t0 = $t0 + 1
        
        #check if reached '\n' and end else continue in loop
        beq		$t2, 10, endAscToIntLoop	# if $t2 =10t1 then jump to endAscToIntLoop

        mul     $t1, $t1, 10    # $t1 *= 10

        sub		$t2, $t2, '0'		# $t2 = $t2 - '0'
        add		$t1, $t1, $t2		# $t1 = $t1 + $t2
        
        j		ascToIntLoop				# jump to ascToIntLoop

    endAscToIntLoop:    

        addi	$t1, $t1, 5			# $t1 = $t1 + 5

        move 	$a0, $t1		# $a0 = $t1
        li		$v0, 1		# command to output number
        syscall
        
        li		$v0, 10		# exit program command
        syscall
    
    
    
    
    
    
    
    
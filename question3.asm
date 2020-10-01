.data
InputRequest: .asciiz "Enter a series of 5 formulae:\n"
OutputMessage: .asciiz "The values are:\n"
userInput: .space 25

.text
main:
    # Limit reading in text size
    li		$a1, 5		# limit strings read in to a max of 5 characters

    # Output request for input message
    la		$a0, InputRequest		# set $a0 to address of InputRequest data
    li		$v0, 4		# command to output a string
    syscall

    #loop to run 5 times and capture user input
    li		$t0, 0		# $t0 =0  counter variable to keep track of loop
    la		$t1, userInput		# $t1 = starting address of space to store user input
    
    
    readingInLoop:
        beq		$t0, 5, endReadingInLoop	# if $t0 == 5  then got to endReadingInLoop
        
        move 	$a0, $t1		# $a0 = $t1
        addi	$t1, $t1, 5			# $t1 = $t1 + 5 offset to next allocated location

        li		$v0, 8		# command to read in string from user
        syscall
        
        addi	$t0, $t0, 1			# $t0 = $t0 + 1
        
        j		readingInLoop				# jump to readingInLoop
        
    endReadingInLoop:

    # print out output message
    la		$a0, OutputMessage		# set $a0 to address of OutputMessage data
    li		$v0, 4		# command to output a string
    syscall

    # print out values in stored spreadsheet
    li		$t0, 0		# $t0 =0  counter variable to track loop 
    la		$t1, userInput		# $t1 = starting address of space to store user input
    li		$t5, 0		# $t5 = 0
    

    outputInputLoop:
        beq		$t0, 5, endOutputInputLoop	# if $t0 == $t1 then got to endOutputInputLoop

        lb		$t2, 0($t1)		# get byte at location stored in $t1

        #check if first byte is '='
        beq		$t2, 61, formulaEntered	# if $t2 == '=' then go to formula entered
        
        # print number as is
            move 	$a0, $t1		# $a0 = $t1
            li		$v0, 4		# command to output a string
            syscall

            bne		$t5, 0, recursiveFunctionCallDone	# if $t5 != 0 then go to recursiveFunctionCallDone
            
                addi	$t1, $t1, 5			# $t1 = $t1 + 5 
                j		continueToNextIteration				# jump to continueToNextIteration
                

            recursiveFunctionCallDone:
                addi	$t1, $t5, 5		# $t1 = $t5 + 5
                li		$t5, 0		# $t5 = 0
                
            continueToNextIteration:
                j		finalLoopOperation				# jump to finalLoopOperation
            
        # print cell being referenced
        formulaEntered:
            li		$t5, 0		# $t5 = 0
            
            lb		$t2, 1($t1)		# get byte 1 after location stored in $t1
            la		$t4, userInput		# $t4 = starting address of space to store user input
            
            sub		$t3, $t2, '0'		# $t3 = $t2 - '0', convert ASCII to integer
            mul     $t3, $t3, 5         # $t3 *= 5 to account for space allocations

            add		$t4, $t4, $t3		# $t4 = $t4 + $t3

            move 	$t5, $t1		# $t5 = $t1 Backup $t1 address into $t5
            move 	$t1, $t4		# $t1 = $t4

            #check if cell is also a formula then restart
            lb		$t2, 0($t4)		# get byte at location stored in $t4
            beq		$t2, 61, formulaEntered	# if $t2 == '=' then go to formulaEntered

            #output final value obtained
            move 	$a0, $t4		# $a0 = $t4
            li		$v0, 4		# command to output a string
            syscall

            addi	$t5, $t5, 5			# $t5 = $t5 + 5
            move 	$t1, $t5		# $t1 = $t5
                   
        finalLoopOperation:             
            addi	$t0, $t0, 1			# $t0 = $t1 + 1
            j		outputInputLoop				# jump to outputInputLoop
        
    endOutputInputLoop:
    
    li		$v0, 10		# command to end program
    syscall
    
    
    


        
    
    
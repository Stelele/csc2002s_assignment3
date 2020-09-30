.data
inputRequest: .asciiz "Enter a series of 5 formulae:\n"
outputInfo: .asciiz "\nThe values are:\n\n"
nextLine: .asciiz "\n"
firstInput: .space 5
secondInput: .space 5
thirdInput: .space 5
fourthInput: .space 5
fifthInput: .space 5

.text
main:
    li		$a1, 5		# limit to 5 characters for reading in

    
    la		$a0, inputRequest		# Output request for input
    li		$v0, 4 		# output string to screen
    syscall


    la		$a0, firstInput		# address containing first string
    li		$v0, 8		# get user input
    syscall   

    la		$a0, secondInput		# address containing second string
    li		$v0, 8		# get user input
    syscall  

    la		$a0, thirdInput		# address containing third string
    li		$v0, 8		# get user input
    syscall  

    la		$a0, fourthInput		# address containing fourth string
    li		$v0, 8		# get user input
    syscall  

    la		$a0, fifthInput		# address containing fifth string
    li		$v0, 8		# get user input
    syscall    
    

    la		$a0, outputInfo		# Output message
    li		$v0, 4		# output string to screen
    syscall
    
    la		$a0, firstInput		# Address containing first string
    syscall

    la		$a0, secondInput		# Address containing first string
    syscall

    la		$a0, thirdInput		# Address containing first string
    syscall

    la		$a0, fourthInput		# Address containing first string
    syscall

    la		$a0, fifthInput		# Address containing first string
    syscall

    li		$v0, 10		# exit program
    syscall 
     
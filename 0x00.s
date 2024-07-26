.data
	m: .space 4
	n: .long 4
	p: .space 4
	k: .space 4
	x: .space 4
	y: .space 4
	sum: .space 4
	index: .space 4
	lineIndex: .space 4
	columIndex: .space 4
	matrix: .space 1600
	matrix2: .space 1600
	formatPrintf: .asciz "%d "
	formatScanf: .asciz "%d"
	endl: .asciz "\n"
.text
.global main
main:
	lea matrix, %edi
	lea matrix2, %esi

citire_m:
	pushl $m
	push $formatScanf
	call scanf
	addl $8, %esp
	addl $2, m
	
citire_n:
	pushl $n
	push $formatScanf
	call scanf
	addl $8, %esp
	addl $2, n
	
citire_p:
	pushl $p
	push $formatScanf
	call scanf
	addl $8, %esp
	
citire_elemente:
	movl $0, index
	for_i_cit:
		movl index, %ebx
		cmpl p, %ebx
		je citire_k
		
		citire_x:
			pushl $x
			push $formatScanf
			call scanf
			addl $8, %esp
		citire_y:
			pushl $y
			push $formatScanf
			call scanf
			addl $8, %esp
		
		addl $1, x
		addl $1, y
		movl x, %eax
		movl $0, %edx
		movl n, %ebx
		mull %ebx
		addl y, %eax
		movl $1, %ebx
		movl %ebx, (%edi, %eax, 4)
		
		addl $1, index
		jmp for_i_cit

citire_k:
	pushl $k
	push $formatScanf
	call scanf
	addl $8, %esp
	
	movl $0, index
	
for_k:
	movl index, %eax
	cmpl k, %eax
	je afisare_matr
	movl $1, lineIndex
	
	for_i_k:
		movl lineIndex, %eax
		movl m, %ebx
		dec %ebx
		cmpl %eax, %ebx
		je cont_for_k
		movl $1, columIndex
		
		for_j_k:
			movl columIndex, %eax
			movl n, %ebx
			dec %ebx
			cmpl %eax, %ebx
			je cont_for_i_k
			
			movl $0, sum
			
			movl lineIndex, %eax
			dec %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			dec %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			dec %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			dec %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			inc %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			dec %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			inc %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			inc %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			dec %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			inc %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
			movl lineIndex, %eax
			inc %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			inc %ebx
			addl %ebx, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, sum
			
		   if_viu:
			movl lineIndex, %eax
			movl $0, %edx
			mull n
			movl columIndex, %ebx
			addl %ebx, %eax
			movl %eax, %ecx
			movl (%edi, %eax, 4), %ebx
			cmpl $0, %ebx
			je if_mort
			
			movl $2, %eax
			cmpl sum, %eax
			je if_1
			movl $3, %eax
			cmpl sum, %eax
			jne if_0
			
			movl $1, (%esi, %ecx, 4)
			jmp cont_for_j_k
			
		   if_mort:
		   	movl $3, %eax
		   	cmpl sum, %eax
		   	jne if_0
		   	movl $1, (%esi, %ecx, 4)
		   	jmp cont_for_j_k
		   	
		   if_1:
		   	movl $1, (%esi, %ecx, 4)
			jmp cont_for_j_k
		   if_0:
		   	movl $0, (%esi, %ecx, 4)
			
		  cont_for_j_k:
		        addl $1, columIndex
		        jmp for_j_k
		
	   cont_for_i_k:
	   	addl $1, lineIndex
	   	jmp for_i_k		
	
   cont_for_k:
     copiere_matr:
	movl $1, lineIndex
	for_i_cop:
		movl lineIndex, %ebx
		movl m, %eax
		dec %eax
		cmpl %eax, %ebx
		je cont2_for_k
		movl $1, columIndex
		
		for_j_cop:
			movl columIndex, %ebx
			movl n, %eax
			dec %eax
			cmpl %eax, %ebx
			je cont_for_i_cop
			
			movl lineIndex, %eax
			movl n, %ebx
			movl $0, %edx
			mull %ebx
			addl columIndex, %eax
			movl (%esi, %eax, 4), %ebx
			movl %ebx, (%edi, %eax, 4)
			
			addl $1, columIndex
			jmp for_j_cop
		
	   cont_for_i_cop:
	   	
	   	addl $1, lineIndex
	   	jmp for_i_cop
   	
    cont2_for_k:
   	addl $1, index
   	jmp for_k
		
afisare_matr:
	movl $1, lineIndex
	for_i_afis:
		movl lineIndex, %ebx
		movl m, %eax
		dec %eax
		cmpl %eax, %ebx
		je et_exit
		movl $1, columIndex
		
		for_j_afis:
			movl columIndex, %ebx
			movl n, %eax
			dec %eax
			cmpl %eax, %ebx
			je cont_for_i_afis
			
			movl lineIndex, %eax
			movl n, %ebx
			movl $0, %edx
			mull %ebx
			addl columIndex, %eax
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			push $formatPrintf
			call printf
			addl $8, %esp
			
			addl $1, columIndex
			jmp for_j_afis
		
	   cont_for_i_afis:
	   	push $endl
	   	call printf
	   	addl $4, %esp
	   	
	   	addl $1, lineIndex
	   	jmp for_i_afis
	
et_exit:
	pushl $0
	call fflush
	addl $4, %esp
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80

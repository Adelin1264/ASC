.data
	m: .space 4
	n: .long 4
	p: .space 4
	k: .space 4
	o: .space 4
	x: .space 4
	y: .space 4
	sum: .space 4
	nr_matrice: .space 4
	nr_mesaj: .space 4
	nr_cheie: .space 4
	nr_hexa: .space 4
	hexa: .space 4
	index: .space 4
	index1: .space 4
	lineIndex: .space 4
	columIndex: .space 4
	chr: .space 1
	matrix: .space 1600
	matrix2: .space 1600
	sir: .space 85
	mesaj: .space 81
	litera: .space 9
	cheie: .space 1600
	result: .space 1600
	formatPrintfCaracter: .asciz "%c"
	formatScanf: .asciz "%d"
	formatScanfSir: .asciz "%s"
	formatPrintfSir: .asciz "%s\n"
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
	
citire_o:
	pushl $o
	push $formatScanf
	call scanf
	addl $8, %esp
	
citire_sir:
	push $sir
	push $formatScanfSir
	call scanf
	addl $8, %esp
	
	movl $0, index
	
for_k:
	movl index, %eax
	cmpl k, %eax
	je criptare
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
		
criptare:
	movl $1, %ebx
	cmpl o, %ebx
	je decriptare
	
	movl $0, index1
	mov $sir, %esi
	mov $mesaj, %edi
	
	for_litera_sir:
		
		mov $sir, %esi
		movl $0, %eax
		movl index1, %ebx
		movb (%esi, %ebx, 1), %al
		
		cmpb $0, %al
		je nr_elemente_cheie_0
		
		mov $litera, %esi
		movl $7, %ecx
		
		for_litera:
			cmpl $-1, %ecx
			je cont_for_litera_sir
			movl $0, %edx
			movl $2, %ebx
			divl %ebx
			
			addl $48, %edx
			movb %dl, (%esi, %ecx, 1)
			
		   	
		   cont_for_litera:
			dec %ecx
			jmp for_litera
			
	   cont_for_litera_sir:
	   	movl $0, %ecx
	   	for_litera_mesaj:
	   		cmpl $8, %ecx
	   		je final_for_litera_sir
	   		
	   		movb (%esi, %ecx, 1), %al
	   		movb %al, (%edi)
	   		inc %edi
	   		incl %ecx
	   		jmp for_litera_mesaj
	   		
	   final_for_litera_sir:
	   	
	   	addl $1, index1
	   	jmp for_litera_sir
	   	
	nr_elemente_cheie_0:
		movl index1, %ebx
		movl $8, %eax
		movl $0, %edx
		mull %ebx
		mov $mesaj, %edi
		movb $0, (%edi, %eax, 1)
		movl %eax, nr_mesaj
		
		movl m, %eax
		movl n, %ebx
		movl $0, %edx
		mull %ebx
		movl %eax, nr_cheie
		movl %eax, nr_matrice
		mov $cheie, %edi
		mov $matrix, %esi
		
	for_cheie_criptare:
		movl $0, %ecx
		for_cheie_criptare_el:
			cmpl nr_matrice, %ecx
			je cont_for_cheie_criptare
			
			movl (%esi, %ecx, 4), %eax
			addl $48, %eax
			movb %al, (%edi)
		    	inc %edi
		    	
		    	incl %ecx
		    	jmp for_cheie_criptare_el
		
 	    cont_for_cheie_criptare:	
		movl nr_cheie, %eax
		cmpl nr_mesaj, %eax
		jge xor_criptare
		movl nr_matrice, %eax
		addl %eax, nr_cheie
		jmp for_cheie_criptare
	
	xor_criptare:
		movl $0, %ecx
		movb $0, (%edi)
		mov $mesaj, %esi
		mov $result, %edi
		mov $cheie, %edx
		for_xor_criptare:
			cmpl nr_mesaj, %ecx
			je afisare_criptat
			
			movl $0, %eax
			movl $0, %ebx
			movb (%esi), %al
			movb (%edx), %bl
			subl $48, %eax
			subl $48, %ebx
			xorb %bl, %al
			addl $48, %eax
			movb %al, (%edi)
			
			incl %esi
			incl %edi
			incl %edx
			
			incl %ecx
			jmp for_xor_criptare
		
	afisare_criptat:
		movb $0, (%edi)
		
		movb $'0', chr
		push chr
		push $formatPrintfCaracter
		call printf
		addl $8, %esp
		
		movb $'x', chr
		push chr
		push $formatPrintfCaracter
		call printf
		addl $8, %esp
		
		movl nr_mesaj, %eax
		movl $0, %edx
		movl $4, %ebx
		div %ebx
		movl %eax, nr_hexa
		mov $result, %edi
		movl $0, index1
		
		for_hexa_crip:
			movl index1, %eax
			cmpl nr_hexa, %eax
			je afisare_endl_crip
			movl $0, %ecx
			movl $0, hexa
			movl $8, %ebx
			
			for_afis_hexa_crip:
				cmpl $4, %ecx
				je transf_hexa_crip
				movl $0, %eax
				movb (%edi), %al
				subl $48, %eax
				mull %ebx
				addl %eax, hexa
				incl %ecx
				incl %edi
				movl %ebx, %eax
				movl $2, %ebx
				divl %ebx
				movl %eax, %ebx
				jmp for_afis_hexa_crip
		   transf_hexa_crip:
		   	movl hexa, %eax
		   	cmpl $9, %eax
		   	jg if_above_9_crip
		   	addl $48, %eax
		   	jmp cont_for_hexa_crip
		   	
		   	if_above_9_crip:
		   		addl $55, %eax
		   	
		   cont_for_hexa_crip:
		   	movb %al, chr
		   	push chr
		   	push $formatPrintfCaracter
		   	call printf
		   	addl $8, %esp
		   	
			addl $1, index1
			jmp for_hexa_crip
			
		afisare_endl_crip:
			push $endl
			call printf
			addl $4, %esp
			
		
	jmp et_exit
	
decriptare:
	movl $0, index1
	mov $mesaj, %edi
	
	for_el_sir:
		
		mov $sir, %esi
		addl $2, %esi
		movl $0, %eax
		movl index1, %ebx
		movb (%esi, %ebx, 1), %al
		
		cmpb $0, %al
		je nr_elemente_cheie_1
		
		subl $48, %eax
		cmpl $10, %eax
		jl if_less_than_10
		subl $7, %eax
		
	   if_less_than_10:
		mov $litera, %esi
		movl $3, %ecx
		
		for_el:
			cmpl $-1, %ecx
			je cont_for_el_sir
			movl $0, %edx
			movl $2, %ebx
			divl %ebx
			
			addl $48, %edx
			movb %dl, (%esi, %ecx, 1)
			
			dec %ecx
			jmp for_el
			
	   cont_for_el_sir:
	   	movl $0, %ecx
	   	for_el_mesaj:
	   		cmpl $4, %ecx
	   		je final_for_el_sir
	   		
	   		movb (%esi, %ecx, 1), %al
	   		movb %al, (%edi)
	   		incl %edi
	   		incl %ecx
	   		jmp for_el_mesaj
	   		
	   final_for_el_sir:
	   	
	   	addl $1, index1
	   	jmp for_el_sir
	
	nr_elemente_cheie_1:
		movb $0, (%edi)
		movl index1, %ebx
		movl $4, %eax
		movl $0, %edx
		mull %ebx
		mov $mesaj, %edi
		movl %eax, nr_mesaj
		
		movl m, %eax
		movl n, %ebx
		movl $0, %edx
		mull %ebx
		movl %eax, nr_cheie
		movl %eax, nr_matrice
		mov $cheie, %edi
		mov $matrix, %esi
		
	for_cheie_decriptare:
		movl $0, %ecx
		for_cheie_decriptare_el:
			cmpl nr_matrice, %ecx
			je cont_for_cheie_decriptare
			
			movl (%esi, %ecx, 4), %eax
			addl $48, %eax
			movb %al, (%edi)
		    	incl %edi
		    	
		    	incl %ecx
		    	jmp for_cheie_decriptare_el
		
 	    cont_for_cheie_decriptare:	
		movl nr_cheie, %eax
		cmpl nr_mesaj, %eax
		jge xor_decriptare
		movl nr_matrice, %eax
		addl %eax, nr_cheie
		jmp for_cheie_decriptare
	
	xor_decriptare:
		movb $0, (%edi)
		movl $0, %ecx
		mov $mesaj, %esi
		mov $result, %edi
		mov $cheie, %edx
		for_xor_decriptare:
			cmpl nr_mesaj, %ecx
			je afisare_decriptat
			
			movl $0, %eax
			movl $0, %ebx
			movb (%esi), %al
			movb (%edx), %bl
			subl $48, %eax
			subl $48, %ebx
			xorb %bl, %al
			addl $48, %eax
			movb %al, (%edi)
			
			incl %esi
			incl %edi
			incl %edx
			
			incl %ecx
			jmp for_xor_decriptare
		
	afisare_decriptat:
		movb $0, (%edi)
		
		movl nr_mesaj, %eax
		movl $0, %edx
		movl $8, %ebx
		div %ebx
		movl %eax, nr_hexa
		mov $result, %edi
		movl $0, index1
		
		for_hexa_decrip:
			movl index1, %eax
			cmpl nr_hexa, %eax
			je afisare_endl_decrip
			movl $0, %ecx
			movl $0, hexa
			movl $128, %ebx
			
			for_afis_hexa_decrip:
				cmpl $8, %ecx
				je cont_for_hexa_decrip
				movl $0, %eax
				movb (%edi), %al
				subl $48, %eax
				mull %ebx
				addl %eax, hexa
				incl %ecx
				incl %edi
				movl %ebx, %eax
				movl $2, %ebx
				divl %ebx
				movl %eax, %ebx
				jmp for_afis_hexa_decrip
		   	
		   cont_for_hexa_decrip:
		   	movl $0, %eax
		   	movl hexa, %eax
		   	movb %al, chr
		   	push chr
		   	push $formatPrintfCaracter
		   	call printf
		   	addl $8, %esp
		   	
			addl $1, index1
			jmp for_hexa_decrip
			
		afisare_endl_decrip:
			push $endl
			call printf
			addl $4, %esp
	
et_exit:
	pushl $0
	call fflush
	addl $4, %esp
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80

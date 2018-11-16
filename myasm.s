section .data                    	; data section, read-write
        an:    DD 0              	; this is a temporary var
	
	count: DW 0
	
	
	
	
section .text                    	; our code is always in the .text section
        global add_Str_N          	; makes the function appear in global scope
        extern printf            	; tell linker that printf is defined elsewhere 				; (not used in the program)

add_Str_N:                        	; functions are defined as labels
        push    ebp              	; save Base Pointer (bp) original value
        mov     ebp, esp         	; use base pointer to access stack contents
        pushad                   	; push all variables onto stack
        mov ecx, dword [ebp+8]	; get function argument

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 
	mov dword [an], 0 ; initialize answer
	mov edx, 0
	label_here: ; Your code goes somewhere around here...

	  cmp byte [ecx], 65
	  jl label_inc_char 

	  cmp byte [ecx], 90
	  jna label_inc_char_count ;;;;;
	  
	  
	label_small:
	  cmp byte [ecx], 97
	  jl label_inc_char;;;;;;;;;;;
	  
	  cmp byte [ecx], 122
	  ja label_inc_char
	  
	label_inc_char_count:
	  add byte [ecx], 5;
	  
	  cmp byte [ecx], 65
	  jl label_inc_count 
	
	  cmp byte [ecx], 90
	  jl label_end
	  
	  cmp byte [ecx], 97
	  jl label_inc_count
	  
	  cmp byte [ecx], 122
	  jl label_end
	  
	label_inc_count:
	  inc edx
	  jmp label_end
	  
	label_inc_char:
	  add byte [ecx], 5

	label_end:
	  inc ecx ; increment pointer ;ecxb??
	  cmp byte [ecx], 0 ; check if byte pointed to is zero
	  jnz label_here ; keep looping until it is null terminat

	  mov [an],edx 

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 
         popad                    ; restore all previously used registers
         mov     eax,[an]         ; return an (returned values are in eax)
         mov     esp, ebp
         pop     ebp
         ret 

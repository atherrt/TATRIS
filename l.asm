[org 0x0100]

;initializing

jmp start

score: db 'S C O R E: '
size_s:dw 11
_Score:dw 0
time:db 'T I M E: '
size_t:dw 9

welcome:db'WELCOME TO ATHARs TATRIS GAME!'
wsize:dw 37

ke:db 'KEYS:'
kesize:dw 5
KeysL:db'LEFT ARROW KEY <-'
Lksize:     dw 17
KeysR:db'RIGHT ARROW KEY ->'
Rksize:     dw 18
are: db 'ARE'
you: db 'YOU'
ready:db 'READY!'

tostart:db'Press any key to start the game (;' ;34

gameOver:db 'GAME OVER !'
size_go:dw 11

next_Shape: db'Next Shape: '
ns_size:dw 12


min_count: dw 0
sec_count: dw -1
tick_count:dw 0

count:dw 0
;print   NUM

PrintNum:
	push bp
	mov bp, sp
	push es
	push di
	push dx
	push cx
	push bx
	push ax
	
	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+4]
	mov bx, 10
	mov cx, 0

	break:
		mov dx, 0
		div bx
		add dx, 0x30
		push dx
		inc cx
		test ax, 0xFFFF
		jnz break
	
	mov di,[bp+6] 
	mov dx,[bp+8]

	nextnum:
		pop ax
		mov ah, dh
		stosw
		loop nextnum

	pop ax
	pop bx
	pop cx
	pop dx
	pop di
	pop es
	mov sp, bp
	pop bp
	ret 6
	



;print    NUM2
PrintNum2:
	push bp
	mov bp, sp
	push es
	push di
	push dx
	push cx
	push bx
	push ax
	
	
	mov ax, 0xb800
	mov es, ax
	mov ax, [bp+4]
	mov bx, 10
	mov cx, [bp+10] ;no of digits

	break2:
		mov dx, 0
		div bx
		add dx, 0x30
		push dx
		loop break2
	
	mov di,[bp+6] 
	mov dx,[bp+8]
	mov cx,[bp+10]

	nextnum2:
		pop ax
		mov ah, dh
		stosw
		loop nextnum2

	pop ax
	pop bx
	pop cx
	pop dx
	pop di
	pop es
	pop bp
	ret 8



;Time
 
TIME: 
 push es
 push di 
 push ax 
 
 inc word[sec_count]
   cmp word[sec_count],59
   jne exit2222
   mov word[sec_count],0
   inc word[min_count] 
 
 exit2222:
 mov ax,0xb800
 mov es,ax
 mov di,1096
 mov ah,0x70
 mov al,':'
 push 0x7000
 push 1094
 push word[min_count]
 call PrintNum
 stosw
  
 push 0x7000
 push 1098
 push word[sec_count]
 call print_time

 pop ax
 pop di
 pop es
 ret
 


 ;print time
 print_time:
 push bp
 mov bp,sp
 push 2 ;to print 2 digits
 push word[bp+8]
 push word[bp+6]
 push word[bp+4]
 
 call PrintNum2
 pop bp
 ret 6
 
 
;clear screen
cls:
   push es
   push di
   push ax
   push cx 
 
   mov ax,0xb800
   mov es ,ax
   mov di ,0
   mov ax,0x7020
    mov cx,2000
	cld
	 rep stosw
pop cx
pop ax
pop di
pop es
ret


clss:
   push es
   push di
   push ax
   push cx 
 
   mov ax,0xb800
   mov es ,ax
   mov di ,0
   mov ax,0x0720
    mov cx,2000
	cld
	 rep stosw
pop cx
pop ax
pop di
pop es
ret


;Lshape
printLshape:
    push bp
	mov bp,sp
    push es
	push di
	push ax
    push bx
    push cx   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x4420 ;red line 
   	  
      ;vertical line 1 
	 	  mov bx,[bp+4] 
         mov di ,bx     ; to print from the middle of the first line	
	     add bx,160
	L1:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne L1
		 mov cx,bx
		 add bx,2
		     mov di ,[bp+4]     ; to print from the middle of the first line	
			  add di,2
	L3:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne L3
	;horizontal line
	mov di ,cx
	add cx,8
	L2: mov [es:di],ax
	     add di,2
         cmp di,cx
		 jne L2
pop cx
pop bx		 
pop ax
pop di
pop es
pop bp
ret 2

;vanishL
vanishLshape:
    push bp
	mov bp,sp
    push es
	push di
	push ax
    push bx
    push cx   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x7020 ;red line 
   	  
      ;vertical line 1 
	 	  mov bx,[bp+4] 
         mov di ,bx     ; to print from the middle of the first line	
	     add bx,160
	L111:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne L111
		 mov cx,bx
		 add bx,2
		     mov di ,[bp+4]     ; to print from the middle of the first line	
			  add di,2
	L333:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne L333
	;horizontal line
	mov di ,cx
	add cx,8
	L222: mov [es:di],ax
	     add di,2
         cmp di,cx
		 jne L222
pop cx
pop bx		 
pop ax
pop di
pop es
pop bp
ret 2



;square

printSquare:

 push bp
	mov bp,sp
    push es
	push di
	push ax
    push bx
    push cx   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0xE020 ;yellow line 
   	  
      ;vertical line 1 
	 	  mov bx,[bp+4] 
         mov di ,bx     ; to print from the middle of the first line	
	     add bx,8
	L0111:mov [es:di],ax
	     add di ,2
		 cmp di ,bx
		 jne L0111
		 mov cx,bx
		 ;add bx,2
		     mov di ,[bp+4]     ; to print from the middle of the first line	
			  add di,160
			  add cx,160
	L0333:mov [es:di],ax
	     add di ,2
		 cmp di ,cx
		 jne L0333

pop cx
pop bx		 
pop ax
pop di
pop es
pop bp
ret 2



vanishSuqare:


 push bp
	mov bp,sp
    push es
	push di
	push ax
    push bx
    push cx   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x7020 ;red line 
   	  
      ;vertical line 1 
	 	  mov bx,[bp+4] 
         mov di ,bx     ; to print from the middle of the first line	
	     add bx,8
	L00111:mov [es:di],ax
	     add di ,2
		 cmp di ,bx
		 jne L00111
		 mov cx,bx
		 ;add bx,2
		     mov di ,[bp+4]     ; to print from the middle of the first line	
			  add di,160
			  add cx,160
	L00333:mov [es:di],ax
	     add di ,2
		 cmp di ,cx
		 jne L00333

pop cx
pop bx		 
pop ax
pop di
pop es
pop bp
ret 2


;vertical line
printVertical:
    push bp
	mov bp,sp
	push es
	push di
	push ax
    push bx
   
    mov ax,0xb800
    mov es ,ax
    
    
	  mov ax,0x5520 ;Megenta line 
   	  
	  ;vertical line	  
          mov bx,[bp+4]
		 mov di ,bx     ; to print from the middle of the first line	
	  add bx,320
	vl1:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne vl1
		 add bx,2
		   mov di ,[bp+4]     ; to print from the middle of the first line	
	        add di,2
	vl2:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne vl2
		 
pop bx
pop ax
pop di
pop es
pop bp
ret 2


;VanishVER
vanishVertical:
    push bp
	mov bp,sp
	push es
	push di
	push ax
    push bx
   
    mov ax,0xb800
    mov es ,ax
    
    
	  mov ax,0x7020 
   	  
	  ;vertical line	  
          mov bx,[bp+4]
		 mov di ,bx     ; to print from the middle of the first line	
	  add bx,320
	vl111:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne vl111
		 add bx,2
		   mov di ,[bp+4]     ; to print from the middle of the first line	
	        add di,2
	vl222:mov [es:di],ax
	     add di ,160
		 cmp di ,bx
		 jne vl222
		 
pop bx
pop ax
pop di
pop es
pop bp
ret 2

;horizontal line

printHorizontal:
    push bp
	mov bp,sp
	push es
	push di
	push ax
    push bx
   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x1120 ; dark blue line 
   	  
	  ;horizontal line
         mov bx,[bp+4]	  
         mov di ,bx    ; to print from the middle of the first line	
	     add bx,8
	hl1: mov [es:di],ax
	     add di ,2
		 cmp di ,bx
		 jne hl1
pop bx
pop ax
pop di
pop es
pop bp
ret 2

;Vanish Horizontal
vanishHorizontal:
    push bp
	mov bp,sp
	push es
	push di
	push ax
    push bx
   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x7020 ; dark blue line 
   	  
	  ;horizontal line
         mov bx,[bp+4]	  
         mov di ,bx    ; to print from the middle of the first line	
	     add bx,8
	hl11: mov [es:di],ax
	     add di ,2
		 cmp di ,bx
		 jne hl11
pop bx
pop ax
pop di
pop es
pop bp
ret 2


;to draw boundary
drawOuterBoundary:

    push es
 	push di
	push ax
	
	
   
   
   mov ax,0xb800
   mov es ,ax
  

	  mov ax,0x1720 ; line 
   	  
	  ;first horzontal line	  
         mov di ,0     ; to print from the middle of the first line	
	bh1:mov [es:di],ax
	     add di ,2
		 cmp di ,160
		 jne bh1
     
    	 ;second horzontal line
      	   mov di,3840
      bh2:mov [es:di],ax
	     add di ,2
		 cmp di ,4000
		 jne bh2

	 ;first vertical line
	     mov di ,0
      bv1:mov [es:di],ax
	     add di ,160
		 cmp di ,3840
		 jne bv1

       	 mov di ,2
         bv1_2:mov [es:di],ax
	     add di ,160
		 cmp di ,3842
		 jne bv1_2

		;second vertical line
          mov di ,158
      bv2:mov [es:di],ax
	     add di ,160
		 cmp di ,4000
		 jbe bv2
	  
  	   mov di ,156
      bv2_1:mov [es:di],ax
	     add di ,160
		 cmp di ,3998
		 jbe bv2_1

pop ax
pop di
pop es
ret




;startScreen Printing

print_Start_Screen:
	push es
	push di
	push ax
	push cx
	push si
    push bx
	push dx
	
     call drawOuterBoundary
    
   
      mov ax,0xb800
      mov es ,ax 
	  mov ax,0x2220 ;green line 
   	  
	  ;first horzontal line	  
   
    mov di ,364     ; to print from the middle of the first line	
	h1:mov [es:di],ax
	     add di ,2
		 cmp di ,442

		 jne h1
     
    	 ;second horzontal line
      	   mov di,3724
      h2:mov [es:di],ax
	     add di ,2
		 cmp di ,3802
		 jne h2

	 ;first vertical line
	     mov di ,364
      v1:mov [es:di],ax
	     add di ,160
		 cmp di ,3724
		 jne v1
       	  mov di ,366
       v1_1:mov [es:di],ax
	     add di ,160
		 cmp di ,3726
		 jne v1_1
		;second vertical line
          mov di ,442
     
   	   v2:mov [es:di],ax
	     add di ,160
		 cmp di ,3802
		 jbe v2
		 mov di ,440
      
	  v2_2:mov [es:di],ax
	     add di ,160
		 cmp di ,3800
		 jbe v2_2
		 
		 
	; score string printing
     mov si,score
     mov di,650
	 mov cx,[size_s]
	 mov ah,0x74
	 
     score_print:	
    
    	 mov al,[si]
	     mov [es:di],ax
	     add di ,2
		 inc si
		 loop score_print
;Score printing
 mov di,976
 mov ax,0x7000
 push ax
 push di
 push word [_Score]
 ;mov si,_Score
 call PrintNum


; Time string printing 
     mov si,time
     mov di,770
	 mov cx,[size_t]
	 mov ah,0x74
     
     time_print:	
    	 mov al,[si]
	     mov [es:di],ax
	     add di ,2
		 inc si
		 loop time_print 
		 
   call TIME

; Next Shape string printing
     mov si,next_Shape
     mov di,2050
	 mov cx,[ns_size]
	 mov ah,0x74
       Next_shape:
         mov al,[si]
	     mov [es:di],ax
	     add di ,2
		 inc si
		 loop Next_shape	  
		  
		  
		  xor ax,ax
		  mov es,ax
		  push word[es:8*4]
		  push word[es:8*4+2]
		  cli 
		  mov word[es:8*4],Timmer
		  mov word[es:8*4+2],cs
		  sti
		  
		  
		  
		  
		  mov ax,0xb800
		  mov es,ax
		  
		 
          mov bx,1		


		
		lpp:
		
		; ;check for the roof
			 
		 ;push di
         mov di,690
		 mov cx,35
		 mov ax,0x7020
		 repe scasw
		 cmp cx,0
		 jne chalchutikr
		   
		 ;pop di
		
		
		
		 push bx
		 call print_next_shape
		 
		  cmp bx,1
		  je LLL
		  
		  cmp bx,2
		  je verrrr
		  
		  cmp bx,3
		  je Horrr
		  
		  cmp bx,4
		  je plusssss
		 
		 
		LLL:
		push 560
		call movLshape
    	jmp loooop
		
		verrrr:
		push 560
		call movVertical
		jmp loooop
		
		Horrr:
		push 560
		call movhorizontal
		jmp loooop
		
		plusssss:
		 push 560
		 call movsquare
		 jmp loooop
		
		chalchutikr:
		   jmp byeforever
		
		 again:
	 mov bx,1
	 jmp lip

	 loooop:
	 inc bx
	 cmp  bx,5
	 je again
	 
	 
   	lip:
	   mov di,3568
		mov dx,18
	
	lp:
    
		mov si,di  ;3568
        mov cx,36     ;; try
		mov ax,0x7020
		repne scasw    ;;tab tak repeat karo jab tak equal nai aata
		 cmp cx,0
		 jne suii
		 jmp toto 
		 
		lipo:
	    
		mov si,di  ;3568
        mov cx,36     ;; try
		mov ax,0x7020
		repne scasw    ;;tab tak repeat karo jab tak equal nai aata
		 cmp cx,0
		 jne scoreNaBarhao
		
   toto:
   add word [_Score],10
   push 0x7000
   push 976
   push word [_Score]  
   call PrintNum
   

       mov di,si
     
   tordo1: 
        push di
		call uraade
        
	 asli_scroll:
	  mov di,si
     
	 
	  sub di,160
       mov cx,36
   scroll:	   
	     cmp word[es:di],0x4420  
          je nr		 
		
		  cmp word[es:di],0x5520  
          je np		 
         
		 cmp word[es:di],0xE020  
          je ny		 
		 
		 cmp word[es:di],0x1120  
          je nb
		
		jmp su
		
		nr: 
		push di
		call nechayred

		jmp su
		
 		suii:jmp snb
		
		scoreNaBarhao:
		jmp scoreNaBarhaoo
		
		np: 
		push di
		call nechaypink
		
		jmp su
 		
		ny: 
		push di
		call nechayyellow
		jmp su
 		
		nb:
		 push di
         call nechayblue
	       jmp su		 
 		su:
	    add di,2
        loop scroll
	 
	jmp popo
	  scoreNaBarhaoo:
   jmp asli_scroll
   popo:      
        mov di,si ;3568
		 sub di,160
		 sub si,160
	dec dx
   cmp dx ,0
   jg lipo  
   
   
 
  snb:
 
     cmp word[min_count],5
     jne lpp	

byeforever:
		xor ax,ax
		 	mov es,ax	  
		  pop word[es:8*4+2]
	      pop word[es:8*4]

pop dx		  
pop bx
pop si
pop cx
pop ax
pop di
pop es
ret


uraade:
push bp
mov bp,sp
push ax
push es
push di
push cx
push si
push bx
mov ax,0xb800
mov es,ax
mov cx,36
mov ax,0xEE20

mov di,[bp+4]


lpc1:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc1
  call delay 
  ;call delay 
 
   
mov ax,0x7020
mov cx,36
mov ax,0x7020
mov di,[bp+4]

lpc:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc

  call delay 
  call delay 


mov cx,36
mov ax,0xEE20

mov di,[bp+4]


lpc2:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc2
  call delay 
  call delay 


  call delay 
  ;call delay 
 
   
mov ax,0x7020
mov cx,36
mov ax,0x7020
mov di,[bp+4]

lpc3:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc3

  call delay 
  ;call delay 


mov cx,36
mov ax,0xEE20

mov di,[bp+4]


lpc4:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc4
  


  call delay 
  ;call delay 
 
   
mov ax,0x7020
mov cx,36
mov ax,0x7020
mov di,[bp+4]

lpc5:
  
   mov [es:di],ax
    add di,2 
	
   loop lpc5

  call delay 
  ;call delay 
















pop bx
pop si
pop cx
pop di
pop es
pop ax
pop bp
ret 2

nechayred:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
   
   mov bx,[bp+4]
   mov di,bx
   

 mov ax,0xb800
 mov es,ax
 
   m11122:
    mov ax,0x7020
	   push di
       add di,160
	   mov cx,2
        repe scasw		
         cmp cx,0
		 jne bye0040
   
	 pop di
	 
	 push di  
     call VanishRed 
	 
	 add di,160   
	 push di
     call printRed    
    
;	call delaythora
    call delaythora
  ;  call delay
	
	
	 cmp di,3400
	 jge bye6099
 
   
	
noke1101:	cmp word[min_count],5
	je bye6099  
	
	cmp di,3400
	 jl m11122
      
	  jmp bye6099
bye0040:	  
pop di	  
bye6099:
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 




  


printPink:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x5520
   mov cx,2
   lio:
      mov [es:di],ax      
      add di,2
	  loop lio 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

VanishPink:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x7020
   mov cx,2
   lio1:
      mov [es:di],ax      
      add di,2
	  loop lio1 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 




printRed:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x4420
   mov cx,2
   lio2:
      mov [es:di],ax      
      add di,2
	  loop lio2 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

VanishRed:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x7020
   mov cx,2
   lio12:
      mov [es:di],ax      
      add di,2
	  loop lio12 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 


printYellow:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0xE020
   mov cx,4
   lio22:
      mov [es:di],ax      
      add di,2
	  loop lio22 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

VanishYellow:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x7020
   mov cx,4
   lio229:
      mov [es:di],ax      
      add di,2
	  loop lio229 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

printblue:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x1120
   mov cx,4
   lio2269:
      mov [es:di],ax      
      add di,2
	  loop lio2269 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

Vanishblue:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
 
   mov ax,0xb800
   mov es,ax
mov bx,[bp+4]
   mov di,bx
   mov ax,0x7020
   mov cx,4
   lio2299:
      mov [es:di],ax      
      add di,2
	  loop lio2299 
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 




nechaypink:

 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
   
   mov bx,[bp+4]
   mov di,bx
   

 mov ax,0xb800
 mov es,ax
 
   m1112:
    mov ax,0x7020
	   push di
       add di,160
	   mov cx,2
        repe scasw		
         cmp cx,0
		 jne bye040
   
	 pop di
	 
	 push di  
     call VanishPink 
	 
	 add di,160   
	 push di
     call printPink    
    
;	call delaythora
    call delaythora
  
	
	 cmp di,3400
	 jge bye609
 
   
	
noke110:	cmp word[min_count],5
	je bye609  
	
	cmp di,3400
	 jl m1112
      
	  jmp bye609
bye040:	  
pop di	  
bye609:
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

nechayyellow:

 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx

   mov bx,[bp+4]
   mov di,bx
   mov ax,0xb800
   mov es,ax
   
   m011110:
         
     
    mov ax,0x7020
	   push di
       add di,160
        mov cx,4
        repe scasw		
         cmp cx,0
		 jne bye003001
	 
	 pop di
	 
	 push di  
     call VanishYellow 
	
	add di,160   
	 push di
     call printYellow  

    ;call delay
    ;call delaythora
    call delaythora

    



	cmp di,3360
	jge bye0990
   	
	
	
noke0020:	cmp word[min_count],5
	je bye0990  
	
	cmp di,3360
	 jl m011110
    
	jmp bye0990

bye003001:
pop di
bye0990: 
pop cx
pop si	 
pop bx
pop ax
pop di
pop es
pop bp
ret 2 

nechayblue:


 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx

   mov bx,[bp+4]
   mov di,bx
   mov ax,0xb800
   mov es,ax
   
   m691111:
   
    mov ax,0x7020
	   push di
       add di,160
        mov cx,4
        repe scasw		
         cmp cx,0
		 jne bye0369
	 
	 pop di
	 
	 push di  
     call Vanishblue 
	
	add di,160   
	 push di
     call printblue  

    ;call delay
    ;call delaythora
    call delaythora

    



	cmp di,3520
	jge bye969
  
	
noke269:cmp word[min_count],5
	je bye969  
	
	cmp di,3520
	 jl m691111
    
	jmp bye969

bye0369:
pop di
bye969: 
pop cx
pop si	 
pop bx
pop ax
pop di
pop es
pop bp
ret 2 


;TIMMER


Timmer:
 push ax
 inc word[tick_count]
 cmp word[tick_count],18
 jne exit22222
 mov word[tick_count],0
 call TIME
 
 exit22222:
  mov al,0x20  
  out 0x20,al
pop ax
 iret


;MovLshape
movLshape:
   push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx 
   
   mov bx,[bp+4]
   mov di,bx
 
 
   xor ax,ax
   mov ax,0xb800
   mov es,ax
     
  m:
      mov ax,0x7020
	   push di
       add di,320
        mov cx,4
        repe scasw		
         cmp cx,0
		 jne bye0111



    pop di	   

     push di
	 call vanishLshape 

     add di,160 
	 push di
     call printLshape    

	
     call delay
     call delay
    ; call delay
	  
	   cmp di,3400
	   jge bye
	  
	  in al,0x60
      cmp al,0x4B   ;for left keypress	 
      jne nextkey
	   
	   push di  

       call vanishLshape	

	   push di
       call movLLeft
     
	   call delay
       call delay
     ;  call delay
     
	  cmp di,3400
	   jge bye
      
  nextkey: cmp al,0x4D ;for right keypress	 
	        jne nopress  
	  push di  
       call vanishLshape	

	  push di	
	  call movLRight
    
	 ;call delay
       call delay
       call delay
	 
nopress:
	 cmp word[min_count],5
	 je bye  
	 
	 cmp di,3400
     jl m
     
     jmp bye	 
  	 
bye0111:
pop di
bye:
pop cx
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 
	 
	

;MovLeftL
movLLeft:
   push bp
   mov bp,sp
   push es
   push ax
   push bx
   push dx
   push cx
   push si
 

   mov cx,di  ; old di

   mov dx,4
   mov bx,[bp+4]
   mov di,bx
   sub di,dx   ;di changed
  

    
      mov si,di   
	  add si,320
	 
      cmp word [es:si],0x7020
	  jne millgya	 

	
	cmp di,3400
	 jg bye1
	 
    add di,160   
	 push di
     call printLshape    
    ;call delay
    call delay
     call delay
	cmp word[min_count],5
	je bye1  
	jmp bye1
	millgya:
	 mov di,cx ;old di
	 add di,160   
	 push di
     call printLshape    
    ;call delay
    call delay
     call delay
	 

bye1:
pop si
pop cx
pop dx
pop bx
pop ax
pop es
pop bp
ret 2 	
	
;MovLRIGHT
movLRight:

   push bp
   mov bp,sp
   push es
  ; push di
   push ax
   push bx
   push dx
   push cx
   push si

    mov cx,di 
	 
   mov dx,4
   mov bx,[bp+4]
   mov di,bx
   add di,dx

      mov si,di  
  
	  add si,320
	  ;add si,4
	  cmp word [es:si],0x7020
	  jne millgya1	 
  
  cmp di,3400
	    jg bye2
   
	 add di,160   
	 push di
     call printLshape    
    ;call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye2 
	jmp bye2
	
	millgya1:
	    mov di,si
		 add di,160   
	 push di
     call printLshape    
    ;call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye2 

	
bye2:
pop si
pop cx
pop dx
pop bx
pop ax
;pop di
pop es
pop bp
ret 2 




;Mov Vertical
movVertical:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx  
   
   mov bx,[bp+4]
   mov di,bx
   
  
   
 mov ax,0xb800
 mov es,ax
 
   m11:
   
 
   
    mov ax,0x7020
	   push di
       add di,320
	   mov cx,2
        repe scasw		
         cmp cx,0
		 jne bye04
   
	 pop di
	 
	 push di  
     call vanishVertical 
	 
	 add di,160   
	 push di
     call printVertical    
    
	call delay
    call delay
  ;  call delay
	
	
	 cmp di,3400
	 jge bye6
 
    
     in al,0x60
     cmp al,0x4B   ;for left keypress	 
     jne nextkey11
	
	 push di  
     call vanishVertical 
	  
	 push di
	 call movVerticalLeft 
	 call delay
     call delay
 ;    call delay
	
	cmp di,3400
	jge bye6
	 
	nextkey11:
     cmp al,0x4D
	  jne noke1
	push di  
    call vanishVertical 
	
	push di
	call movVerticalRight
	
	call delay
    call delay
;    call delay
	
	 
	
	
	
	
noke1:	cmp word[min_count],5
	je bye6  
	
	cmp di,3400

	 jl m11
      jmp bye6
bye04:	  
pop di	  
bye6:
pop cx	 	 
pop si
pop bx
pop ax
pop di
pop es
pop bp
ret 2 
 
;Move vertical left

movVerticalLeft:
 push bp
   mov bp,sp
   push es
   push ax
   push bx
    push dx
	push cx
	push si
	
	mov cx,di

 mov dx,4 
 mov bx,[bp+4]
   mov di,bx
   sub di,dx
  
 mov si,di  
 
    add si,320
	cmp word[es:si],0x7020
	jne millgya3
	
	cmp di,3400
	 jge bye7

	
	add di,160   
	 push di
     call printVertical    
    ;call delay
    call delay
    call delay

	cmp word[min_count],5
	je bye7  
     jmp bye7	
	millgya3:
	mov di,cx
	add di,160   
	 push di
     call printVertical    
    ;call delay
    call delay
    call delay

	cmp word[min_count],5
	je bye7  
	
	
	
bye7:
pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 


 
 ;Mov vertical Right
 movVerticalRight:
 push bp
   mov bp,sp
   push es
   push ax
   push bx
    push dx
  push cx
  push si

mov cx,di

 mov dx,4 
 mov bx,[bp+4]
   mov di,bx
   add di,dx
 
  mov si ,di
    add si,320
	cmp word [es:si],0x7020
     jne millgya9 
 
	cmp di,3400
	 jge bye8
	
	add di,160   
	 push di
     call printVertical    
    ;call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye8 
	jmp bye8


millgya9:
     mov di, cx
	add di,160   
	 push di
     call printVertical    
    call delay
    call delay
	cmp word[min_count],5
	je bye8 


	bye8:	 



pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 

 
 
 
 ;Mov horizontal
 movhorizontal:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx

   mov bx,[bp+4]
   mov di,bx
   mov ax,0xb800
   mov es,ax
   
   m1111:
  
     
    mov ax,0x7020
	   push di
       add di,160
        mov cx,4
        repe scasw		
         cmp cx,0
		 jne bye03
	 
	 pop di
	 
	 push di  
     call vanishHorizontal 
	
	add di,160   
	 push di
     call printHorizontal  

    ;call delay
    call delay
    call delay

    



	cmp di,3520
	jge bye9
    
	in al,0x60
     cmp al,0x4B   ;for left keypress	 
     jne nextkey111
	
	push di
    call vanishHorizontal
        
	push di
    call movhorizontalLeft
   
    ;call delay
    call delay
    call delay

	cmp di,3520
	jge bye9
   	 
	 nextkey111:
	cmp al,0x4D
    jne noke2	
	push di
    call vanishHorizontal
        
	push di
    call movhorizontalRight
	;call delay
    call delay
    call delay

	
noke2:	cmp word[min_count],5
	je bye9  
	
	cmp di,3520
	 jl m1111
    
	jmp bye9

bye03:
pop di
bye9: 
pop cx
pop si	 
pop bx
pop ax
pop di
pop es
pop bp
ret 2 
 
;Mov Horizontal Left
movhorizontalLeft:
   push bp
   mov  bp,sp
   push es
   push ax
   push bx
   push dx
   push cx
   push si   
 
   mov cx,di
   
   mov  dx,4
   mov  bx,[bp+4]
   mov  di,bx
   sub di,dx
   
	mov si,di 
	add si,160
	cmp word[es:si],0x7020
	jne mila

	cmp di,3520
	 jge bye10

	add di,160   
	 push di
     call printHorizontal  
 ;   call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye10  
     jmp bye10	
  
  mila:
     mov di,cx
	add di,160   
	 push di
     call printHorizontal  
 ;   call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye10  
     	
		


	bye10:
pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 




;Move Horizontal right

movhorizontalRight:
   push bp
   mov  bp,sp
   push es
    push ax
   push bx
   push dx
   push cx
   push si
   
   mov cx,di

   mov  dx,4
   mov  bx,[bp+4]
   mov  di,bx
  add di,dx
 
   mov si,di
   add si,160
   cmp word[es:si],0x7020
   jne milgya

   cmp di,3520
   jge bye11  
	
	add di,160   
	 push di
     call printHorizontal  
     ;call delay
     call delay
     call delay
	 cmp word[min_count],5
	 je bye11  
	 jmp bye11
	 
	 milgya:
	 mov di,cx
	 add di,160   
	 push di
     call printHorizontal  

    call delay
    call delay
	cmp word[min_count],5
	je bye11 
	 
bye11:	 
pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 




;Move Square
movsquare:
 push bp
   mov bp,sp
   push es
   push di
   push ax
   push bx
   push si
   push cx

   mov bx,[bp+4]
   mov di,bx
   mov ax,0xb800
   mov es,ax
   
   m01111:
         
     
    mov ax,0x7020
	   push di
       add di,320
        mov cx,4
        repe scasw		
         cmp cx,0
		 jne bye003
	 
	 pop di
	 
	 push di  
     call vanishSuqare 
	
	add di,160   
	 push di
     call printSquare  

    ;call delay
    call delay
    call delay

    



	cmp di,3360
	jge bye09
   	
	in al,0x60
     cmp al,0x4B   ;for left keypress	 
     jne nextkey0111
	
	push di
    call vanishSuqare
        
	push di
    call movsquareleft
   
    ;call delay
    call delay
    call delay

	cmp di,3360
	jge bye09
   	 
	 nextkey0111:
	cmp al,0x4D     ;for right keypress
    jne noke02	
	push di
    call vanishSuqare
        
	push di
    call movsquareright
	call delay
    call delay
    ;call delay

	
noke02:	cmp word[min_count],5
	je bye09  
	
	cmp di,3360
	 jl m01111
    
	jmp bye09

bye003:
pop di
bye09: 
pop cx
pop si	 
pop bx
pop ax
pop di
pop es
pop bp
ret 2 


;Move Square right

movsquareright:
   push bp
   mov  bp,sp
   push es
    push ax
   push bx
   push dx
   push cx
   push si
   
   mov cx,di

   mov  dx,4
   mov  bx,[bp+4]
   mov  di,bx
  add di,dx
 
   mov si,di
   add si,360
   cmp word[es:si],0x7020
   jne milgyaa

   cmp di,3360
	jge bye011
   	
	add di,160   
	 push di
     call printSquare  
;    call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye011  
	 jmp bye011
	 
	 milgyaa:
	 mov di,cx
	 add di,160   
	 push di
     call printSquare  
;    call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye011 
	 
bye011:	 
pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 



;Move Square Left

movsquareleft:
   push bp
   mov  bp,sp
   push es
    push ax
   push bx
   push dx
   push cx
   push si
   
   mov cx,di

   mov  dx,4
   mov  bx,[bp+4]
   mov  di,bx
  sub di,dx
 
   mov si,di
   add si,320
   cmp word[es:si],0x7020
   jne milgyaaa

 cmp di,3360
	jge bye0011
   		
	add di,160   
	 push di
     call printSquare  
;    call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye0011  
	 jmp bye0011
	 
	 milgyaaa:
	 mov di,cx
	 add di,160   
	 push di
     call printSquare  
;    call delay
    call delay
    call delay
	cmp word[min_count],5
	je bye0011 
	 
bye0011:	 
pop si
pop cx
pop dx	 	 
pop bx
pop ax
pop es
pop bp
ret 2 




;prints next shape
print_next_shape:
    push bp
    mov bp,sp
	push ax
    push bx 
	mov bx,[bp+4]
    
	cmp bx,1
    je verrr
    
	cmp bx,2
    je horr 	
    
	cmp bx,3
	je plusss
	
	cmp bx,4
	je LL
	
   verrr:
   mov ax,2376
	push ax
	call vanishLshape
    push ax
	call printVertical
    jmp exit
    
	horr:
	mov ax,2376
	push ax
	call vanishVertical
    push ax
	call printHorizontal
    jmp exit

    plusss:
    mov ax,2376
	push ax
    call vanishHorizontal
    push ax
	call printSquare
    jmp exit

  LL:
    mov ax,2376
	push ax
     call vanishSuqare
	 push ax
    call printLshape
    jmp exit

  
exit:
pop bx 
pop ax
pop bp
ret 2



;prints end screen

print_End_Screen:

  push es
  push di
  push ax
  push si
  push cx
  call clss
  
  call drawOuterBoundary
  
   mov ax,0xb800
   mov es,ax
  
  
  
  
  ;GAME OVER 
    mov si,gameOver
	mov cx,[size_go]
	mov ah,0x0C
    mov di ,550
   
	g_o: 
  
    	 mov al,[si]
	     mov [es:di],ax
		 call delay
		 call delay
	     add di ,2
		 inc si 
		 loop g_o 
  
  
  
   mov si,score
     mov di,870
	 mov cx,[size_s]
	 mov ah,0x0A
	 
     s_p:	
    
    	 mov al,[si]
	     mov [es:di],ax
	     add di ,2
		 inc si 
		 loop s_p 
  
 
  
   mov di,1200
   mov ax,0x8f00
   push ax 
   push di
   push word[_Score]
    call PrintNum 

	   
	   
	  xor ax,ax
      xor di,di	  
   	   
	 mov si,time
     mov di,1832
	 mov cx,[size_t]
	 mov ah,0x0A
     
     t_p:	
    	 
		 mov al,[si]
	     mov [es:di],ax
	     add di ,2
		 inc si
		 loop t_p 
	   
	   
	   ;printing the time in the end
	   mov ax,0xb800
 mov es,ax
 mov di,2318
 mov ah,0x8f
 mov al,':'
 push 0x8f00
 push 2316
 push word[min_count]
 call PrintNum
 stosw
  
 push 0x8f00
 push 2320
 push word[sec_count]
 call print_time
 
 
 
 
 
 
   pop cx 
   pop si   
   pop ax
   pop di
   pop es
   ret
   
   
   
 
 ;delay for multiple testing reasons

delaythora:
push es
push ax
push bx
push cx
push di
push si


delaYYY: add bx,1
        cmp bx,0xffff      
		loop delaYY
		xor bx,bx
		
pop si
pop di
pop cx
pop bx
pop ax
pop es
ret		

delay:
push es
push ax
push bx
push cx
push di
push si


delaYY: add bx,1
        cmp bx,0xffff      
		loop delaYY
		xor bx,bx
  delaYY2: add bx,1
          cmp bx,0xffff      
		  loop delaYY2

		
pop si
pop di
pop cx
pop bx
pop ax
pop es
ret	

;start

start:

    call clss
    
	mov ax,0xb800
	mov es,ax
   mov ah,0x09
   mov si,welcome   
	mov cx,[wsize]
      mov di,1640
	nextchar:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar
      
   mov ah,0x0E
   mov si,ke  
	mov cx,[kesize]
      mov di,1800
	nextchar1:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar1
	  
 mov ah,0x0A
   mov si,KeysL  
	mov cx,[Lksize]
      mov di,1960
	nextchar2:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar2

mov ah,0x0A
   mov si,KeysR  
	mov cx,[Rksize]
      mov di,2120
	nextchar3:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar3

mov ah,0x0C
   mov si,are  
	mov cx,3
      mov di,2280
	nextchar4:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar4

add di,2
mov ah,0x0C
   mov si,you  
	mov cx,3

	nextchar5:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar5

add di,2
mov ah,0x0C
   mov si,ready  
	mov cx,6
	nextchar6:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
      call delay
	 loop nextchar6


mov ah,0x8E
   mov si,tostart  
	mov cx,34
      mov di,3400
	nextchar7:
	 mov al,[si] 
	  mov [es:di],ax  
	  inc si
       
	  add di,2
	 loop nextchar7

  xor ax,ax
  xor di,di
  xor cx,cx
  xor si,si
  
  mov ah,0
  int 16h   
	call cls
    call print_Start_Screen
    call print_End_Screen
 
;termination
mov ax,0x1
int 0x21
mov ax,0x4c00
int 0x21
.model small
.stack 100
.data
row dw 51,81,111,141,171
col dw 41,71,101,131,161

elr db 4,8,12,15,19
elc db 3,7,11,14,18

elem db '*','1','1','1','1','1','2','2','*','1','1','2','*','2','1','*','2','2','2','1','1','1','1','*','1','$'
rv dw 0
cv dw 0
clv dw 0
oldX dw -1
oldY dw 0

mr db 0
mc db 0
break db 0
vis db '0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','$'

dis db 0

n_cell db 0

m db 'MinesWeeper $'
p db 'Press p to Play $'
c db 'Press c for Credits $'
J1      db  '-----------------$'
J2      db  '||-------------||$'
J3      db  '|| MINESWEEPER ||$'
J4      db  '||-------------||$'
J5      db  '-----------------$'

GoBack  db  'Press g to return to the Main Menu.$'
c1 db '  Jargis Ahmed         $'
c2 db '  20th Batch           $'
c3 db '  Roll - 04            $'    
c4 db '  Pritom Saha          $'
c5 db '  20th Batch           $' 
c6 db '  Roll - 56            $'     
c7 db 'Department of Computer Science & Engineering$'
uni db 'University of Dhaka$'

kala db '                                            $'
ywin db 'Winner ',3,3,3,' ',1,'$'
game db '  Game Over$'
ak   db 'Press any key$'
exit db 'Press Esc to exit$'
boom db '  Booooom!!$'

cdval db 0
;line db 100,120
.code
main proc    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;   ;;;;
    ;;;;;     Main Menu   ;;;;;;        ;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    mov  ax,@data
    mov  ds,ax                            ;
    mov  es,ax                            ;                                      ;
    
                                          ;
    start:
    mov ah, 0
    mov al, 12h                           ;
    int 10h    ;;;; vga 640*480, 12 color
    
    
    mov n_cell,0
    mov cl,25
    lea si,vis
    mov ch,'0'
    
    set_0:
    mov [si],ch
    inc si
    dec cl
    cmp cl,0
    jne set_0
                                    
    mov dh, 1       ;                     ;
    mov dl, 30       ;
    lea si, J1                            ; 
    call print
        
    mov dh, 2
    mov dl, 30
    lea si, J2    
    call print
        
    mov dh, 3
    mov dl, 30
    lea si, J3    
    call print       ;;;;;;; minesweeper
        
    mov dh, 4
    mov dl, 30
    lea si, J4    
    call print
    
    mov dh, 5
    mov dl, 30
    lea si, J5    
    call print
    
    mov dh, 8
    mov dl, 30
    lea si, p    
    call print
    
    mov dh, 10
    mov dl, 30
    lea si, c       ;
    call print      ;
    
    mov dh,12
    mov dl,30
    lea si,exit
    call print
    
wait_for_key:    
    mov ah, 0h
    int 16h      ;; wait until input, after check flash input buffer
    
    cmp al, 'p'
    je new_game
    
    cmp al, 'c'
    je cred 
    
    cmp al,27  ;;;; 
    je stop
    
    
    jne wait_for_key
    
    
    stop:
    mov ax, 3 ; back to text mode: 80x25
    int 10h
;;;;;;;;;;;;;;;;;;; ending main proc ;;;;;;;;;;;;;;;;;;;;
    mov ah,4ch
    int 21h
    main endp
    
        
    new_game:   
    jmp new_start
    
cred:
    mov dh, 6
    mov dl, 30
    lea si, c1
    call print1
    
    mov dh, 7
    mov dl, 30
    lea si, c2    
    call print1
    
    mov dh, 8
    mov dl, 30
    lea si, c3    
    call print1
    
    mov dh, 10
    mov dl, 30
    lea si, c4    
    call print1
    
    mov dh, 11
    mov dl, 30
    lea si, c5    
    call print1
    
    mov dh, 12
    mov dl, 30
    lea si, c6    
    call print1
    
    mov dh, 14
    mov dl, 17
    lea si, c7    
    call print1
    
    mov dh, 15
    mov dl, 29
    lea si, uni   
    call print1
    
    mov cdval,0
    mov dh, 17
    mov dl, 22
    lea si, GoBack    
    call print
    
    sec_w_f_k:
    mov ah, 0h
    int 16h     ;; wait until input, after check flash input buffer
    
    cmp al, 'g' ;; input char goes to al
    je j_start
    
    jne sec_w_f_k
    
    j_start:
    
    mov ax,12h
    int 10h   ;;; again set 640*480 mode
                              ;
    jmp start                                



                                            
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           
    ;;;;;  Start the game  ;;;;;;;         
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
     
    new_start:
    ;set graphics mode
    mov ah,0
    mov al,13h
    int 10h
    
    ;;;;;;;;;;;;;;;;;; row 1 ;;;;;;;;;;;;;;;
    mov bx,11
    mov rv,bx
    ;cell no. 1
    mov cv,21
    mov clv,50
    
    x1:
    ;mov rv,bx
    call back_print
    inc rv
    cmp rv,41
    jne x1
    
    ;cell no. 2
    add cv,30
    mov rv,11
    add clv,30
    x2:
    call back_print
    inc rv
    cmp rv,41
    jne x2
    
    ;cell no. 3
    add cv,30
    mov rv,11
    add clv,30
    x3:
    call back_print
    inc rv
    cmp rv,41
    jne x3
    
    ;cell no. 4
    add cv,30
    mov rv,11
    add clv,30
    x4:
    call back_print
    inc rv
    cmp rv,41
    jne x4
    
    ;cell no. 5
    add cv,30
    mov rv,11
    add clv,30
    x5:
    call back_print
    inc rv
    cmp rv,41
    jne x5
    
    ;;;;;;;;;;;;;;;;;;;;; row 2 ;;;;;;;;;;;;;;;;;;;
    mov bx,41
    mov rv,bx
    ;cell no. 1
    mov cv,21
    mov clv,50
    
    x6:
    call back_print
    inc rv
    cmp rv,71
    jne x6
    
    ;cell no. 2
    add cv,30
    mov rv,41
    add clv,30
    x7:
    call back_print
    inc rv
    cmp rv,71
    jne x7
    
    ;cell no. 3
    add cv,30
    mov rv,41
    add clv,30
    x8:
    call back_print
    inc rv
    cmp rv,71
    jne x8
    
    ;cell no. 4
    add cv,30
    mov rv,41
    add clv,30
    x9:
    call back_print
    inc rv
    cmp rv,71
    jne x9
    
    ;cell no. 5
    add cv,30
    mov rv,41
    add clv,30
    x10:
    call back_print
    inc rv
    cmp rv,71
    jne x10
    
    ;;;;;;;;;;;;;;;;;; row 3 ;;;;;;;;;;;;;;;;;;;
    mov bx,71
    mov rv,bx
    ;cell no. 1
    mov cv,21
    mov clv,50
    
    x11:
    call back_print
    inc rv
    cmp rv,101
    jne x11
    
    ;cell no. 2
    add cv,30
    mov rv,71
    add clv,30
    x12:
    call back_print
    inc rv
    cmp rv,101
    jne x12
    
    ;cell no. 3
    add cv,30
    mov rv,71
    add clv,30
    x13:
    call back_print
    inc rv
    cmp rv,101
    jne x13
    
    ;cell no. 4
    add cv,30
    mov rv,71
    add clv,30
    x14:
    call back_print
    inc rv
    cmp rv,101
    jne x14
    
    ;cell no. 5
    add cv,30
    mov rv,71
    add clv,30
    x15:
    call back_print
    inc rv
    cmp rv,101
    jne x15
    
    ;;;;;;;;;;;;;;;;;; row 4 ;;;;;;;;;;;;;;;;;
    mov bx,101
    mov rv,bx
    ;cell no. 1
    mov cv,21
    mov clv,50
    
    x16:
    call back_print
    inc rv
    cmp rv,131
    jne x16
    
    ;cell no. 2
    add cv,30
    mov rv,101
    add clv,30
    x17:
    call back_print
    inc rv
    cmp rv,131
    jne x17
    
    ;cell no. 3
    add cv,30
    mov rv,101
    add clv,30
    x18:
    call back_print
    inc rv
    cmp rv,131
    jne x18
    
    ;cell no. 4
    add cv,30
    mov rv,101
    add clv,30
    x19:
    call back_print
    inc rv
    cmp rv,131
    jne x19
    
    ;cell no. 5
    add cv,30
    mov rv,101
    add clv,30
    x20:
    call back_print
    inc rv
    cmp rv,131
    jne x20
    
    ;;;;;;;;;;;;;;;; row 5 ;;;;;;;;;;;;;;;
    mov bx,131
    mov rv,bx
    ;cell no. 1
    mov cv,21
    mov clv,50
    
    x21:
    call back_print
    inc rv
    cmp rv,161
    jne x21
    
    ;cell no. 2
    add cv,30
    mov rv,131
    add clv,30
    x22:
    call back_print
    inc rv
    cmp rv,161
    jne x22
    
    ;cell no. 3
    add cv,30
    mov rv,131
    add clv,30
    x23:
    call back_print
    inc rv
    cmp rv,161
    jne x23
    
    ;cell no. 4
    add cv,30
    mov rv,131
    add clv,30
    x24:
    call back_print
    inc rv
    cmp rv,161
    jne x24
    
    ;cell no. 5
    add cv,30
    mov rv,131
    add clv,30
    x25:
    call back_print
    inc rv
    cmp rv,161
    jne x25
    
    
;;;;;;;;;;;;;;;;;; printing row line  ;;;;;;;;;;;;;;;;;;
    mov ch,0
    mov cl,6h
    mov bx,11
    
for_rl_p:
    call rl_print
    add bx,30
    dec cl
    cmp cl,0h
    ;inc di
    jg for_rl_p
    
    
;;;;;;;;;;;;;;;;;; printing column line  ;;;;;;;;;;;;;;
    mov ch,0
    mov cl,6h
    mov bx,21    
for_cl_p:
    call cl_print
    add bx,30
    dec cl
    cmp cl,0h
    ;inc di
    jg for_cl_p
    ;////////////////////////////////////////////////////////////
    
    int 3h
;;;;;;;; use of mouse;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



check_mouse_button:
    ;push bx
    mov ax,1  ;;;;;; show mouse cursor
    int 33h
    
    mov ax, 3  ;;;;;;;;;;position and clicked or not clicked
    int 33h
    shr cx, 1 ; x/2 cx is doubled ah=13h,int 10h 320*200 video mode
    ;mov cx,40   ;; cx is row val
    ;mov dx,50   ;; dx is col val of pixel
    cmp bx, 1;;;;;;;;;;;;;; click of left mouse button
    
    ;je point_draw
    je find_cell
    
    cmp bx,2
    je place_qm
    
    jmp check_mouse_button   
    
check_any_key:
    
win:
    mov dh,9
    mov dl,23
    lea si,ywin
    call print
    
    mov dh,11
    mov dl,23
    lea si,ak
    call print1
    mov n_cell,0
    mov ah, 0h
    int 16h   ;;;;;; wait for any key press
    jmp start
    
    
place_qm:
    mov ah,2
    int 33h    
    cmp dx,11
    jl check_mouse_button
    
    cmp dx,161
    jg check_mouse_button
    
    cmp cx,21
    jl check_mouse_button
    
    cmp cx,171
    jg check_mouse_button
    
    call quest_mk
    jmp check_mouse_button
    
    

find_cell:

    mov al,-1
    mov ah,-1
    
    lea si,row
    lea di,col
    
    cmp dx,11
    jl check_mouse_button
    
    cmp dx,161
    jg check_mouse_button
    
    cmp cx,21
    jl check_mouse_button
    
    cmp cx,171
    jg check_mouse_button
    
    count_row:
    
    inc ah  ;;inc row no.
    mov bx,si
    add si,2
    cmp [si-2],cx
    jl count_row
    
    count_col:
    inc al
    mov bx,di
    add di,2
    cmp [di-2],dx
    jl count_col
    
    
    ;push ax
    
    mov mr,ah
    mov mc,al
    
    mov bx,[si-2]
    mov rv,bx
    ;sub rv,10
    sub bx,29
    ;suv rv,10
    
    mov cx,[di-2]
    sub cx,29
    mov cv,cx
    mov clv,cx
    add clv,28
        
    push ax
    
    mov ax,02 ;;;;; hide mouse cursor
    int 33h
    
    run_black:
    call black_the_cell
    inc bx
    cmp bx,rv
    jne run_black
    

    
point_draw:
    pop ax
    push dx
    push cx
    ;push bx
    lea di,elr
    lea si,elc
    
    inc_si: ;;find row val
    cmp ah,0
    je inc_di
    inc di
    dec ah
    jmp inc_si
    
    
    inc_di: ;;find col val
    cmp al,0
    je st_draw
    inc si
    dec al
    jmp inc_di
    
    st_draw:
    mov dl,[di] ;;;set col
    mov dh,[si] ;;;set row
    
    ;push dx
    ;xchg dh,dl
    
    mov al,mc
    mov cl,5
    mul cl
    
    mov cl,'0' ;;; to check vis or not vis
    
    add al,mr
    mov dis,al
    lea di,elem
    
    lea si,vis   ;;;;;;;;; make n-th visited
    add si,ax
    cmp [si],cl
    je counter
    
resume_point_draw:
    mov cl,'1'
    mov [si],cl
    
    ;mov al,'1'
    add di,ax
    mov al,[di]
    
    ;pop dx
    mov bh,0  ; \\//same page\\//
    mov ah,02 ;;;;set cursor
    int 10h
    
    mov ah,9h ;write char func
    mov cx, 1 ;how many char
    mov bl,0100b ; color of char wanted
    int 10h   ;;;;;;; write char at the cursor pointed  
    
    cmp al,'*'  ;;;;;;;;; check for bomb
    je set_break
    ;jne counter
    pop cx
    pop dx
    
    cmp n_cell,20  ;;;;;;;;;;;;; check for 20 cell opened
    je  jmp_check_any_key
    ;pop bx
    ;pop ax
    jmp check_mouse_button
set_break:
    pop cx
    pop dx
    ;mov break,1
    
    mov dh,8
    mov dl,23
    lea si,boom
    call print
    
    mov dh,10
    mov dl,23
    lea si,game
    call print
    
    mov dh,12
    mov dl,23
    lea si,ak
    call print1
    mov ah, 0h
    int 16h   ;;;;;;;;;;;;;; wait for any key press
    jmp start

counter:
    inc n_cell
    jmp resume_point_draw

jmp_check_any_key:
    jmp check_any_key
       
    
;;;;;;;;;;;;;;;;;;;;;; 25 cells ;;;;;;;;;;;;;;;;;;;;;;;;;
back_print proc
    ;draw line
    push cx
    mov ah,0ch
    mov al,1
    mov cx,cv
    mov dx,rv
    L:
    int 10h
    inc cx
    cmp cx,clv
    jle L
    pop cx
    ret
    back_print endp

;;;;;;;;;;;;;;;;;;;;;;;; yellow row line ;;;;;;;;;;;;;;;;;
rl_print proc
    ;draw line
    push cx
    mov ah,0ch
    mov al,1110B
    mov cx,21
    mov dx,bx
    L1:
    int 10h
    inc cx
    cmp cx,170
    jle L1
    pop cx
    ret
    rl_print endp
;;;;;;;;;;;;;;;;;;;;;;; yellow column line ;;;;;;;;;;;;;;;;
cl_print proc
    ;draw line
    push cx
    mov ah,0ch
    mov al,1110B
    mov cx,bx
    mov dx,11
    LL2:
    int 10h
    inc dx
    cmp dx,161
    jle LL2
    pop cx
    ret
    cl_print endp

;;;;;;;;;;;;;;;;;;;;;;;; blacking the clicked cell ;;;;;;;;;;;
black_the_cell proc
    push ax
    mov ah,0ch
    mov al,0
    mov cx,bx
    mov dx,cv
    blk:
    int 10h
    inc dx
    cmp dx,clv
    jle blk
    pop ax
    ret   
    black_the_cell endp

quest_mk proc
    ;push bx           
    mov al,-1
    mov ah,-1
    
    lea si,row
    lea di,col
    
    count_row_qm:
    inc ah ;;inc row no.
    mov bx,si
    add si,2
    cmp [si-2],cx
    jl count_row_qm
    
    count_col_qm:
    inc al
    mov bx,di
    add di,2
    cmp [di-2],dx
    jl count_col_qm 
    
    lea di,elr
    lea si,elc
    
    inc_si_qm: ;;find row val
    cmp ah,0
    je inc_di_qm
    inc di
    dec ah
    jmp inc_si_qm
    
    
    inc_di_qm: ;;find col val
    cmp al,0
    je st_draw_qm
    inc si
    dec al
    jmp inc_di_qm
    
    st_draw_qm:
    mov dl,[di] ;;;set col
    mov dh,[si] ;;;set row
    
    mov bh,0  ; \\//same page\\//
    mov ah,02 ;set cursor
    int 10h
    
    mov al,'?'
    mov ah,9h ;write char func
    mov cx, 1 ;how many char
    mov bl,0100b ; color of char wanted
    int 10h   ;;;;;;; write char at the cursor pointed
    
    ;pop cx
    ;pop dx
    ;jmp check_esc_key
    ret
    quest_mk endp

print proc
    push cx
        
    LP:
    mov bh, 0  ; \\//same page\\//
    mov ah, 02 ;set cursor
    int 10h
    mov al, [si]
    cmp al, '$'
    je break_print
    
    mov ah, 9h ;write char func
    mov cx, 1 ;how many char
    mov bl, 0100b ; color of char wanted
    int 10h     ;;;;;;; write char at the cursor pointed
    inc si
    inc dl
    
    jmp LP
         
    break_print:
    pop cx
    ret
    print endp

print1 proc
    push cx
        
    LP1:
    mov bh, 0  ; \\//same page\\//
    mov ah, 02 ;set cursor
    int 10h
    mov al, [si]
    cmp al, '$'
    je break_print1
    
    mov ah, 9h ;write char func
    mov cx, 1 ;how many char
    mov bl, 0101b ; color of char wanted
    int 10h     ;;;;;;; write char at the cursor pointed
    inc si
    inc dl
    
    jmp LP1
         
    break_print1:
    pop cx
    ret
    print1 endp
end main
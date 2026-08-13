 ORG 100H       ; origin directive tells the assembler: "Calculate all memory addresses starting from 100H"
                ;When you write START:, assembler calculates its address as 0100H 
                ;why we start from org100  PSP (Program Segment Prefix) - 256 bytes of DOS system data
                ; IP = Instruction Pointer - A 16-bit register inside the CPU IP :Holds the OFFSET address of the NEXT instruction to execute  , 
                ;How IP works: After each instruction, the CPU automatically increments IP to point to the next instruction  
                ; physical address calculation = (1234H x 10H) + 0100H 
                ; So your code starts at physical memory address 12440H   
                ; DOS = The operating system that runs your program
                ; COM = Command file (simplest executable format in DOS)  , Entry point always at offset 0100H (hence ORG 100H) , All segments (CS, DS, ES, SS) set to same value
                    
                    
DELAY_LONG_TICKS  EQU 91    ;  EQU = EQUate assembler directive for readbility not memory allocation
DELAY_SHORT_TICKS EQU 36    ;  1 tick = 1 timer interrupt , For 5 seconds: 5 seconds ÷ 0.054925 seconds/tick = 91.02 ticks ? Rounded to 91
                            ;  For 2 seconds: 2 seconds ÷ 0.054925 seconds/tick = 36.41 ticks ? Rounded to 36
                            ;  delay calculation = no of seconds/ period of one tick w period of one tick = 1/frequency                                                                           
                       
                                                                                                        
                       ; program entry point                                                                                         
START:         
    MOV AX, 0003H      ; video mode setup  AX met2asema hagteen taba3 BIOS    ( AH stores 00H for running set video mode)  ( AL stores 03H set video mode 3 for color text )
                       ; CPU fetches opcode B8 (MOV AX, immediate)  Reads next 2 bytes: 03 (low byte), 00 (high byte)  Loads AX = 0003H IP increments by 3 (1 byte opcode + 2 bytes data) to point to next instruction  
    INT 10H            ; INT 10H = BIOS Video Services Interrupt  , handles all video operations
                       ; when interupt happens  1) cpu save current state , ip points to next instruction   2)cpu clears flag  3) CPU Finds Interrupt Handler    4)CPU Jumps to BIOS and then Bios returns back from interrupt 
         
                        
MAIN_LOOP:       ;This is a label where ip starts from the loop

    MOV DX, OFFSET RED_STATE_MSG      ; operator that points to place ( red state ) badal ma nkteb mov dx, red-state-msg  fa hwa gabha 3alttol   
                                      ; dx data register Often used for: I/O port addresses Memory addresses (as here) Multiplication/division results
    CALL PRINT_MSG                    ; Call procedure instruction
    CALL NEWLINE
    MOV CX, DELAY_LONG_TICKS          ; CX containing delay amount (91 ticks)  , count register
    CALL DELAY_BIOS                   ; "POST Delay, is a setting that pauses the startup process for a few seconds before the operating system begins to load.

    
    
    MOV DX, OFFSET YELLOW_STATE_MSG
    CALL PRINT_MSG
    CALL NEWLINE
    MOV CX, DELAY_SHORT_TICKS
    CALL DELAY_BIOS
    
 
    MOV DX, OFFSET GREEN_STATE_MSG
    CALL PRINT_MSG
    CALL NEWLINE
    MOV CX, DELAY_LONG_TICKS
    CALL DELAY_BIOS
    
   
    JMP MAIN_LOOP             ; (unconditional jump) finite loop , MAIN_LOOP = Label to jump to   
                              ; jmp btfdl t loop bs , call lazem t store memory address then jump  
              
              
PRINT_MSG:    ; label
 
    MOV AH, 09H      ;  DOS printing/display string function 
    INT 21H          ;  DOS services interrupt , prints string currently pointed to by dx until $ terminator 
    RET              ;  return from stack (by address)
                                                      
                                                      
NEWLINE:      ;label
    PUSH DX              ; push into stack  , save address
    MOV DX, OFFSET CRLF  ; carriage return shayla line of string  , move to next line 
    MOV AH, 09H          ; DOS printing/display string function
    INT 21H              ; DOS services interrupt , prints string currently pointed to by dx until $ terminator
    POP DX               ; pop restores original address lel dx    el hwa el output string 
    RET

DELAY_BIOS PROC   ; "Start of delay procedure"        kol elpush ; Save registers (put them in pockets)
    PUSH AX       
    PUSH BX
    PUSH CX        ; CX has how long to wait (91 or 36)
    PUSH DX        ; current time
    MOV AH, 00H    ;  read system clock
    INT 1AH        ; "Hey BIOS timer, what time is it?"  ,  interrupt of timer service , like asking for the time
    ADD DX, CX     ; "Add wait time to current time"   
    MOV BX, DX     ; "Save target time in BX"
              
WAIT_LOOP:
    MOV AH, 00H    ; "What time is it now?"
    INT 1AH
    CMP DX, BX     ; "Compare current time with target time"
    JB WAIT_LOOP   ; "If current < target, keep waiting"     , conditional jump (jump if below)
    POP DX         ; Restore registers (take from pockets)
    POP CX
    POP BX
    POP AX
    RET           ; "Return to caller"
DELAY_BIOS ENDP   ; "End of delay procedure"


RED_STATE_MSG    DB 'STATE: RED (Stopping)$'    ; DB = Define Bytes (allocate memory for these characters) , Each character uses 1 byte
YELLOW_STATE_MSG DB 'STATE: YELLOW (Preparing for GO)$'   ;$ when to stop printing , and start el message el b3dha
GREEN_STATE_MSG  DB 'STATE: GREEN (Go)$'
CRLF             DB 0DH, 0AH, '$'           ; 0DH Carriage Return (CR) Think: "Go back to start of this line"  
                                            ; 0AH 


END START   ;end   



; Interrupt types 
; 1) INT 10H =  BIOS Video Services Interrupt  , handles all video operations 
; 2) INT 21H =  DOS services interrupt , prints string currently pointed to by dx until $ terminator  
; 3) INT 1AH =  interrupt of timer service , like asking for the time "Hey BIOS timer, what time is it?"  

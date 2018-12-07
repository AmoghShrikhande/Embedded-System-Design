	      ORG 0000H
         MOV 20H, #00H   ;clear location 20H of any prvious data
         MOV 21H, #00H   ;clear location 21H of any prvious data
         MOV 22H, #00H   ;clear location 22H of any prvious data
         MOV 23H, #00H   ;clear location 23H of any prvious data
         MOV 30H, #00H   ;clear location 30H of any prvious data
         MOV R0,A        ;save the dividend in register R0 
         MOV A,0F0H      ;move the divisor from register B to A for further processing 
         CLR C           ;clear the carry flag to avoid false result
         RLC A           ;logic to multiply divisor by 4 
         RLC A
         ORL C,0E0H      ;logic to determine if the multiplication exceeds 8 bits      
         JC ERROR        ;Steps to perform in case multiplication exceeds 8 bit
         JZ ZERO         ;logic to determine if the divisor is 0
         MOV 20H,A       ;result of multiplication of divisor and 4 stored at 20H
         MOV A,R0
         MOV R2,#00H
         CLR C
 BACK:   SUBB A, 20H     ; logic for values of divisor < 3F and divisor=/0
         JC DOWN
         MOV R3,A
         INC R2
         SJMP BACK
 DOWN:   MOV 21H,R2      ; moving values to the specified locations
         MOV 22H,R3
         MOV 23H,R2
 ENDLOOP:SJMP ENDLOOP    ; End of Program
 ZERO:   MOV 30H,#01H
         SJMP ENDLOOP
 ERROR:  CLR 0E0H
         MOV 23H,A
         MOV 30H,#02H
         SJMP ENDLOOP
       

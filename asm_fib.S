	.arch armv6
	.cpu cortex-a53
	.text
	.global asm_fib

	.equ 	FP_OFFSET, 8
	
	.equ	LOCAL_VAR_SPACE, 8
	.equ	a_OFFSET, -12		//Temp Var Holder for (i-1)th element of Fp
	.equ	b_OFFSET, -16		//Temp Var Holder for ith element of FP

asm_fib:
	push {R4, fp, lr}		//Saving registers that may be used
	add fp, sp, #FP_OFFSET		//Accomdates for the amount of registers pushed
	sub sp, sp, #(LOCAL_VAR_SPACE)	//sets sp based on local var space

	CMP R0, #1			//if (n > 1) {
					//.
	BLE base_case			//else {
	
	STR R0, [FP, #b_OFFSET]		//	b = r0/n;
	SUB R0, R0, #1			//	n = n - 1;
	BL asm_fib			//	asm_fib();
	MOV R4, R0			//	r4 = n
	STR R4, [fp, #a_OFFSET]		//	a = r4/n
	
	LDR R0, [fp, #b_OFFSET]		//	r0 = b;
	SUB R0, R0, #2			//	b = b - 2;
	BL asm_fib			//	asm_fib();
	
	ADD R0, R0, R4			//	b = b + a;
	B end

base_case: 				// n = 1;
	MOV R0, #1			// .
end:
	sub sp, fp, #FP_OFFSET
	pop {R4, fp, lr}
	bx lr

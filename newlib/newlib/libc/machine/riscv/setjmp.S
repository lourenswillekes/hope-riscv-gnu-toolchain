#ifdef __riscv64
# define REG_S    sd
# define REG_L     ld
# define SZREG 8
#else
# define REG_S    sw
# define REG_L     lw
# define SZREG 4
#endif

/* int setjmp (jmp_buf);  */
  .globl  setjmp
setjmp:
	REG_S ra,  0*SZREG(a0)
	REG_S s0,  1*SZREG(a0)
	REG_S s1,  2*SZREG(a0)
	REG_S s2,  3*SZREG(a0)
	REG_S s3,  4*SZREG(a0)
	REG_S s4,  5*SZREG(a0)
	REG_S s5,  6*SZREG(a0)
	REG_S s6,  7*SZREG(a0)
	REG_S s7,  8*SZREG(a0)
	REG_S s8,  9*SZREG(a0)
	REG_S s9, 10*SZREG(a0)
	REG_S s10,11*SZREG(a0)
	REG_S s11,12*SZREG(a0)
	REG_S sp, 13*SZREG(a0)

#ifdef __riscv_hard_float
	frsr a3

	fsd   fs0, 16*SZREG+ 0*8(a0)
	fsd   fs1, 16*SZREG+ 1*8(a0)
	fsd   fs2, 16*SZREG+ 2*8(a0)
	fsd   fs3, 16*SZREG+ 3*8(a0)
	fsd   fs4, 16*SZREG+ 4*8(a0)
	fsd   fs5, 16*SZREG+ 5*8(a0)
	fsd   fs6, 16*SZREG+ 6*8(a0)
	fsd   fs7, 16*SZREG+ 7*8(a0)
	fsd   fs8, 16*SZREG+ 8*8(a0)
	fsd   fs9, 16*SZREG+ 9*8(a0)
	fsd   fs10,16*SZREG+10*8(a0)
	fsd   fs11,16*SZREG+11*8(a0)

	REG_S a3, 15*SZREG(a0)
#endif

	li    a0, 0
	ret

/* volatile void longjmp (jmp_buf, int);  */
        .globl  longjmp
        .align 3
longjmp:
	REG_L ra,  0*SZREG(a0)
	REG_L s0,  1*SZREG(a0)
	REG_L s1,  2*SZREG(a0)
	REG_L s2,  3*SZREG(a0)
	REG_L s3,  4*SZREG(a0)
	REG_L s4,  5*SZREG(a0)
	REG_L s5,  6*SZREG(a0)
	REG_L s6,  7*SZREG(a0)
	REG_L s7,  8*SZREG(a0)
	REG_L s8,  9*SZREG(a0)
	REG_L s9, 10*SZREG(a0)
	REG_L s10,11*SZREG(a0)
	REG_L s11,12*SZREG(a0)

        # make sure we blow away any tags on the stack
        addi sp, sp, -2 * SZREG
        REG_S s0, 0(sp)
        REG_S s1, SZREG(sp)
        mv s0, sp
        addi s0, s0, 2 * SZREG
	REG_L s1, 13*SZREG(a0)
1:      
        REG_S zero, 0(s0)
        addi s0, s0, SZREG
        bne s0, s1, 1b
        REG_L s0, 0(sp)
        REG_L s1, SZREG(sp)
        
	REG_L sp, 13*SZREG(a0)

        # this next code seems unwise to me - if the jump buffer is a local, then we may have reset SP
        # past it just now, and if, for example, an interrupt comes in while we're doing the operations
        # below, then a0 may be pointing at a buffer about to be corrupted.

#ifdef __riscv_hard_float
	REG_L a3, 15*SZREG(a0)

	fld  fs0, 16*SZREG+ 0*8(a0)
	fld  fs1, 16*SZREG+ 1*8(a0)
	fld  fs2, 16*SZREG+ 2*8(a0)
	fld  fs3, 16*SZREG+ 3*8(a0)
	fld  fs4, 16*SZREG+ 4*8(a0)
	fld  fs5, 16*SZREG+ 5*8(a0)
	fld  fs6, 16*SZREG+ 6*8(a0)
	fld  fs7, 16*SZREG+ 7*8(a0)
	fld  fs8, 16*SZREG+ 8*8(a0)
	fld  fs9, 16*SZREG+ 9*8(a0)
	fld  fs10,16*SZREG+10*8(a0)

	fssr a3
#endif

	seqz a0, a1
	add  a0, a0, a1   # a0 = (a1 == 0) ? 1 : a1
	ret
        .align 3
        
        .globl  longjmp_end
longjmp_end:

	.file	"heavy_ops.c"
	.text
	.globl	batched_gemm                    # -- Begin function batched_gemm
	.p2align	4
	.type	batched_gemm,@function
batched_gemm:                           # @batched_gemm
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -32(%rbp)
	movl	$0, -12(%rbp)
	jmp	.LBB0_1
	.p2align	4
.LBB0_11:                               #   in Loop: Header=BB0_1 Depth=1
	incl	-12(%rbp)
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
                                        #       Child Loop BB0_5 Depth 3
                                        #         Child Loop BB0_8 Depth 4
	cmpl	$63, -12(%rbp)
	jg	.LBB0_12
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movl	$0, -8(%rbp)
	jmp	.LBB0_3
	.p2align	4
.LBB0_10:                               #   in Loop: Header=BB0_3 Depth=2
	incl	-8(%rbp)
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB0_5 Depth 3
                                        #         Child Loop BB0_8 Depth 4
	cmpl	$63, -8(%rbp)
	jg	.LBB0_11
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=2
	movl	$0, -4(%rbp)
	jmp	.LBB0_5
	.p2align	4
.LBB0_9:                                #   in Loop: Header=BB0_5 Depth=3
	movss	-20(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movslq	-12(%rbp), %rax
	shlq	$14, %rax
	addq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	shlq	$8, %rcx
	addq	%rax, %rcx
	movslq	-4(%rbp), %rax
	movss	%xmm0, (%rcx,%rax,4)
	incl	-4(%rbp)
.LBB0_5:                                #   Parent Loop BB0_1 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB0_8 Depth 4
	cmpl	$63, -4(%rbp)
	jg	.LBB0_10
# %bb.6:                                #   in Loop: Header=BB0_5 Depth=3
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	cmpl	$63, -16(%rbp)
	jg	.LBB0_9
	.p2align	4
.LBB0_8:                                #   Parent Loop BB0_1 Depth=1
                                        #     Parent Loop BB0_3 Depth=2
                                        #       Parent Loop BB0_5 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movslq	-12(%rbp), %rax
	shlq	$14, %rax
	movq	-48(%rbp), %rcx
	addq	%rax, %rcx
	movslq	-8(%rbp), %rdx
	shlq	$8, %rdx
	addq	%rcx, %rdx
	movslq	-16(%rbp), %rcx
	addq	-40(%rbp), %rax
	movss	(%rdx,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	leal	1(%rcx), %edx
	shlq	$8, %rcx
	addq	%rax, %rcx
	movslq	-4(%rbp), %rax
	mulss	(%rcx,%rax,4), %xmm0
	addss	-20(%rbp), %xmm0
	movss	%xmm0, -20(%rbp)
	movl	%edx, -16(%rbp)
	cmpl	$63, -16(%rbp)
	jle	.LBB0_8
	jmp	.LBB0_9
.LBB0_12:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	batched_gemm, .Lfunc_end0-batched_gemm
	.cfi_endproc
                                        # -- End function
	.globl	conv2d                          # -- Begin function conv2d
	.p2align	4
	.type	conv2d,@function
conv2d:                                 # @conv2d
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -32(%rbp)
	movl	$0, -8(%rbp)
	jmp	.LBB1_1
	.p2align	4
.LBB1_14:                               #   in Loop: Header=BB1_1 Depth=1
	incl	-8(%rbp)
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
                                        #       Child Loop BB1_5 Depth 3
                                        #         Child Loop BB1_7 Depth 4
                                        #           Child Loop BB1_10 Depth 5
	cmpl	$31, -8(%rbp)
	jg	.LBB1_15
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movl	$0, -4(%rbp)
	jmp	.LBB1_3
	.p2align	4
.LBB1_13:                               #   in Loop: Header=BB1_3 Depth=2
	movss	-24(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movslq	-8(%rbp), %rax
	shlq	$7, %rax
	addq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movss	%xmm0, (%rax,%rcx,4)
	incl	-4(%rbp)
.LBB1_3:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_5 Depth 3
                                        #         Child Loop BB1_7 Depth 4
                                        #           Child Loop BB1_10 Depth 5
	cmpl	$31, -4(%rbp)
	jg	.LBB1_14
# %bb.4:                                #   in Loop: Header=BB1_3 Depth=2
	movl	$0, -24(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB1_5
	.p2align	4
.LBB1_12:                               #   in Loop: Header=BB1_5 Depth=3
	incl	-20(%rbp)
.LBB1_5:                                #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_3 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB1_7 Depth 4
                                        #           Child Loop BB1_10 Depth 5
	cmpl	$15, -20(%rbp)
	jg	.LBB1_13
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=3
	movl	$0, -16(%rbp)
	jmp	.LBB1_7
	.p2align	4
.LBB1_11:                               #   in Loop: Header=BB1_7 Depth=4
	incl	-16(%rbp)
.LBB1_7:                                #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_3 Depth=2
                                        #       Parent Loop BB1_5 Depth=3
                                        # =>      This Loop Header: Depth=4
                                        #           Child Loop BB1_10 Depth 5
	cmpl	$4, -16(%rbp)
	jg	.LBB1_12
# %bb.8:                                #   in Loop: Header=BB1_7 Depth=4
	movl	$0, -12(%rbp)
	cmpl	$4, -12(%rbp)
	jg	.LBB1_11
	.p2align	4
.LBB1_10:                               #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_3 Depth=2
                                        #       Parent Loop BB1_5 Depth=3
                                        #         Parent Loop BB1_7 Depth=4
                                        # =>        This Inner Loop Header: Depth=5
	movslq	-20(%rbp), %rax
	imulq	$5184, %rax, %rcx               # imm = 0x1440
	addq	-48(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movslq	-16(%rbp), %rsi
	addq	%rsi, %rdx
	leaq	(%rdx,%rdx,8), %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	movslq	-4(%rbp), %rcx
	movslq	-12(%rbp), %rdi
	addq	%rdi, %rcx
	movss	(%rdx,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	imulq	$100, %rax, %rax
	addq	-40(%rbp), %rax
	leaq	(%rsi,%rsi,4), %rcx
	leaq	(%rax,%rcx,4), %rax
	mulss	(%rax,%rdi,4), %xmm0
	addss	-24(%rbp), %xmm0
	movss	%xmm0, -24(%rbp)
	leal	1(%rdi), %eax
	movl	%eax, -12(%rbp)
	cmpl	$4, -12(%rbp)
	jle	.LBB1_10
	jmp	.LBB1_11
.LBB1_15:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	conv2d, .Lfunc_end1-conv2d
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function fft_4096
.LCPI2_0:
	.quad	0x8000000000000000              # double -0
.LCPI2_1:
	.quad	0xc00921fb54442d18              # double -3.1415926535897931
	.text
	.globl	fft_4096
	.p2align	4
	.type	fft_4096,@function
fft_4096:                               # @fft_4096
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$96, %rsp
	movq	%rdi, -32(%rbp)
	movl	$1, -16(%rbp)
	jmp	.LBB2_1
	.p2align	4
.LBB2_14:                               #   in Loop: Header=BB2_1 Depth=1
	incl	-16(%rbp)
.LBB2_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_3 Depth 2
                                        #       Child Loop BB2_5 Depth 3
	cmpl	$12, -16(%rbp)
	jg	.LBB2_15
# %bb.2:                                #   in Loop: Header=BB2_1 Depth=1
	movzbl	-16(%rbp), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	movl	%eax, -60(%rbp)
	sarl	%eax
	movl	%eax, -12(%rbp)
	xorps	%xmm2, %xmm2
	cvtsi2sd	%eax, %xmm2
	movsd	.LCPI2_0(%rip), %xmm0           # xmm0 = [-0.0E+0,0.0E+0]
	divsd	%xmm2, %xmm0
	movsd	.LCPI2_1(%rip), %xmm1           # xmm1 = [-3.1415926535897931E+0,0.0E+0]
	divsd	%xmm2, %xmm1
	movsd	%xmm0, -96(%rbp)
	movsd	%xmm1, -88(%rbp)
	callq	cexp@PLT
	cvtsd2ss	%xmm0, %xmm0
	cvtsd2ss	%xmm1, %xmm1
	movss	%xmm0, -56(%rbp)
	movss	%xmm1, -52(%rbp)
	movl	$0, -8(%rbp)
	jmp	.LBB2_3
	.p2align	4
.LBB2_13:                               #   in Loop: Header=BB2_3 Depth=2
	movl	-60(%rbp), %eax
	addl	%eax, -8(%rbp)
.LBB2_3:                                #   Parent Loop BB2_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_5 Depth 3
	cmpl	$4095, -8(%rbp)                 # imm = 0xFFF
	jg	.LBB2_14
# %bb.4:                                #   in Loop: Header=BB2_3 Depth=2
	movq	$1065353216, -24(%rbp)          # imm = 0x3F800000
	movl	$0, -4(%rbp)
	.p2align	4
.LBB2_5:                                #   Parent Loop BB2_1 Depth=1
                                        #     Parent Loop BB2_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB2_13
# %bb.6:                                #   in Loop: Header=BB2_5 Depth=3
	movss	-24(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	-20(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	addq	%rcx, %rdx
	movslq	-12(%rbp), %rcx
	addq	%rdx, %rcx
	movss	(%rax,%rcx,8), %xmm2            # xmm2 = mem[0],zero,zero,zero
	movss	4(%rax,%rcx,8), %xmm3           # xmm3 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm4
	mulss	%xmm2, %xmm4
	movaps	%xmm1, %xmm5
	mulss	%xmm3, %xmm5
	subss	%xmm5, %xmm4
	movaps	%xmm0, %xmm6
	mulss	%xmm3, %xmm6
	movaps	%xmm1, %xmm5
	mulss	%xmm2, %xmm5
	addss	%xmm6, %xmm5
	ucomiss	%xmm4, %xmm4
	jp	.LBB2_7
.LBB2_9:                                #   in Loop: Header=BB2_5 Depth=3
	movss	%xmm4, -48(%rbp)
	movss	%xmm5, -44(%rbp)
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	addq	%rcx, %rdx
	movss	(%rax,%rdx,8), %xmm0            # xmm0 = mem[0],zero,zero,zero
	movss	4(%rax,%rdx,8), %xmm1           # xmm1 = mem[0],zero,zero,zero
	movss	%xmm0, -40(%rbp)
	movss	%xmm1, -36(%rbp)
	addss	%xmm4, %xmm0
	addss	%xmm5, %xmm1
	movss	%xmm0, (%rax,%rdx,8)
	movss	%xmm1, 4(%rax,%rdx,8)
	movss	-40(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	-36(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	subss	-48(%rbp), %xmm0
	subss	-44(%rbp), %xmm1
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	addq	%rcx, %rdx
	movslq	-12(%rbp), %rcx
	addq	%rdx, %rcx
	movss	%xmm0, (%rax,%rcx,8)
	movss	%xmm1, 4(%rax,%rcx,8)
	movss	-56(%rbp), %xmm2                # xmm2 = mem[0],zero,zero,zero
	movss	-52(%rbp), %xmm3                # xmm3 = mem[0],zero,zero,zero
	movss	-24(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	movss	-20(%rbp), %xmm1                # xmm1 = mem[0],zero,zero,zero
	movaps	%xmm0, %xmm4
	mulss	%xmm2, %xmm4
	movaps	%xmm1, %xmm5
	mulss	%xmm3, %xmm5
	subss	%xmm5, %xmm4
	movaps	%xmm0, %xmm6
	mulss	%xmm3, %xmm6
	movaps	%xmm1, %xmm5
	mulss	%xmm2, %xmm5
	addss	%xmm6, %xmm5
	ucomiss	%xmm4, %xmm4
	jp	.LBB2_10
.LBB2_12:                               #   in Loop: Header=BB2_5 Depth=3
	movss	%xmm4, -24(%rbp)
	movss	%xmm5, -20(%rbp)
	incl	-4(%rbp)
	jmp	.LBB2_5
.LBB2_7:                                #   in Loop: Header=BB2_5 Depth=3
	ucomiss	%xmm5, %xmm5
	jnp	.LBB2_9
# %bb.8:                                #   in Loop: Header=BB2_5 Depth=3
	callq	__mulsc3@PLT
	movlps	%xmm0, -76(%rbp)
	movss	-76(%rbp), %xmm4                # xmm4 = mem[0],zero,zero,zero
	movss	-72(%rbp), %xmm5                # xmm5 = mem[0],zero,zero,zero
	jmp	.LBB2_9
.LBB2_10:                               #   in Loop: Header=BB2_5 Depth=3
	ucomiss	%xmm5, %xmm5
	jnp	.LBB2_12
# %bb.11:                               #   in Loop: Header=BB2_5 Depth=3
	callq	__mulsc3@PLT
	movlps	%xmm0, -68(%rbp)
	movss	-68(%rbp), %xmm4                # xmm4 = mem[0],zero,zero,zero
	movss	-64(%rbp), %xmm5                # xmm5 = mem[0],zero,zero,zero
	jmp	.LBB2_12
.LBB2_15:
	addq	$96, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	fft_4096, .Lfunc_end2-fft_4096
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0                          # -- Begin function gelu_layernorm
.LCPI3_0:
	.quad	0x3ee4f8b588e368f1              # double 1.0000000000000001E-5
.LCPI3_1:
	.quad	0x3ff0000000000000              # double 1
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0
.LCPI3_2:
	.long	0x3f000000                      # float 0.5
.LCPI3_3:
	.long	0x3d372713                      # float 0.0447149985
.LCPI3_4:
	.long	0x3f4c422a                      # float 0.797884583
.LCPI3_5:
	.long	0x3f800000                      # float 1
	.text
	.globl	gelu_layernorm
	.p2align	4
	.type	gelu_layernorm,@function
gelu_layernorm:                         # @gelu_layernorm
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -12(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movl	$0, -4(%rbp)
	.p2align	4
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB3_3
# %bb.2:                                #   in Loop: Header=BB3_1 Depth=1
	movq	-40(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm1            # xmm1 = mem[0],zero,zero,zero
	movss	%xmm1, -68(%rbp)
	movaps	%xmm1, %xmm0
	mulss	.LCPI3_3(%rip), %xmm0
	mulss	%xmm1, %xmm0
	mulss	%xmm1, %xmm0
	addss	%xmm1, %xmm0
	mulss	.LCPI3_2(%rip), %xmm1
	movss	%xmm1, -44(%rbp)                # 4-byte Spill
	mulss	.LCPI3_4(%rip), %xmm0
	callq	tanhf@PLT
	addss	.LCPI3_5(%rip), %xmm0
	mulss	-44(%rbp), %xmm0                # 4-byte Folded Reload
	movss	%xmm0, -48(%rbp)
	movq	-40(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movss	%xmm0, (%rax,%rcx,4)
	movss	-48(%rbp), %xmm0                # xmm0 = mem[0],zero,zero,zero
	xorps	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	addsd	-32(%rbp), %xmm1
	movsd	%xmm1, -32(%rbp)
	mulss	%xmm0, %xmm0
	cvtss2sd	%xmm0, %xmm0
	addsd	-24(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
	incl	-4(%rbp)
	jmp	.LBB3_1
.LBB3_3:
	movsd	-32(%rbp), %xmm1                # xmm1 = mem[0],zero
	cvtsi2sdl	-12(%rbp), %xmm2
	divsd	%xmm2, %xmm1
	movsd	%xmm1, -64(%rbp)
	movsd	-24(%rbp), %xmm0                # xmm0 = mem[0],zero
	divsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm1
	subsd	%xmm1, %xmm0
	addsd	.LCPI3_0(%rip), %xmm0
	movsd	%xmm0, -80(%rbp)
	xorpd	%xmm1, %xmm1
	ucomisd	%xmm1, %xmm0
	jb	.LBB3_5
# %bb.4:
	sqrtsd	%xmm0, %xmm0
	jmp	.LBB3_6
.LBB3_5:                                # %call.sqrt
	callq	sqrt@PLT
.LBB3_6:                                # %.split
	movsd	.LCPI3_1(%rip), %xmm1           # xmm1 = [1.0E+0,0.0E+0]
	divsd	%xmm0, %xmm1
	movsd	%xmm1, -56(%rbp)
	movl	$0, -8(%rbp)
	.p2align	4
.LBB3_7:                                # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB3_9
# %bb.8:                                #   in Loop: Header=BB3_7 Depth=1
	movq	-40(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movss	(%rax,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	subsd	-64(%rbp), %xmm0
	mulsd	-56(%rbp), %xmm0
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, (%rax,%rcx,4)
	incl	-8(%rbp)
	jmp	.LBB3_7
.LBB3_9:
	addq	$80, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	gelu_layernorm, .Lfunc_end3-gelu_layernorm
	.cfi_endproc
                                        # -- End function
	.globl	prefix_sum                      # -- Begin function prefix_sum
	.p2align	4
	.type	prefix_sum,@function
prefix_sum:                             # @prefix_sum
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -32(%rbp)
	movl	%esi, -8(%rbp)
	movl	$1, -16(%rbp)
	jmp	.LBB4_1
	.p2align	4
.LBB4_5:                                #   in Loop: Header=BB4_1 Depth=1
	shll	-16(%rbp)
.LBB4_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_3 Depth 2
	movl	-16(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB4_6
# %bb.2:                                #   in Loop: Header=BB4_1 Depth=1
	movl	$0, -20(%rbp)
	.p2align	4
.LBB4_3:                                #   Parent Loop BB4_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB4_5
# %bb.4:                                #   in Loop: Header=BB4_3 Depth=2
	movq	-32(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movl	-4(%rax,%rsi,4), %esi
	leaq	(%rcx,%rdx,2), %rcx
	addl	%esi, -4(%rax,%rcx,4)
	movl	-16(%rbp), %eax
	addl	%eax, %eax
	addl	%eax, -20(%rbp)
	jmp	.LBB4_3
.LBB4_6:
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movl	$0, -4(%rax,%rcx,4)
	movl	-8(%rbp), %eax
	sarl	%eax
	movl	%eax, -4(%rbp)
	jmp	.LBB4_7
	.p2align	4
.LBB4_11:                               #   in Loop: Header=BB4_7 Depth=1
	sarl	-4(%rbp)
.LBB4_7:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_9 Depth 2
	cmpl	$0, -4(%rbp)
	jle	.LBB4_12
# %bb.8:                                #   in Loop: Header=BB4_7 Depth=1
	movl	$0, -12(%rbp)
	.p2align	4
.LBB4_9:                                #   Parent Loop BB4_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.LBB4_11
# %bb.10:                               #   in Loop: Header=BB4_9 Depth=2
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	leaq	(%rcx,%rdx), %rsi
	movl	-4(%rax,%rsi,4), %edi
	movl	%edi, -36(%rbp)
	leaq	(%rcx,%rdx,2), %rcx
	movl	-4(%rax,%rcx,4), %ecx
	movl	%ecx, -4(%rax,%rsi,4)
	movl	-36(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movslq	-4(%rbp), %rsi
	leaq	(%rdx,%rsi,2), %rdx
	addl	%eax, -4(%rcx,%rdx,4)
	movl	-4(%rbp), %eax
	addl	%eax, %eax
	addl	%eax, -12(%rbp)
	jmp	.LBB4_9
.LBB4_12:
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	prefix_sum, .Lfunc_end4-prefix_sum
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2, 0x0                          # -- Begin function main
.LCPI5_0:
	.long	0x3a000000                      # float 4.8828125E-4
.LCPI5_1:
	.long	0xbf800000                      # float -1
.LCPI5_4:
	.long	0x3c23d70a                      # float 0.00999999977
.LCPI5_5:
	.long	0x3ca3d70a                      # float 0.0199999996
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.LCPI5_2:
	.quad	0x4073a28c59d5433b              # double 314.15926535897933
.LCPI5_3:
	.quad	0x3f30000000000000              # double 2.44140625E-4
	.text
	.globl	main
	.p2align	4
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	$0, -60(%rbp)
	movl	$0, -16(%rbp)
	movss	.LCPI5_5(%rip), %xmm0           # xmm0 = [1.99999996E-2,0.0E+0,0.0E+0,0.0E+0]
	jmp	.LBB5_1
	.p2align	4
.LBB5_8:                                #   in Loop: Header=BB5_1 Depth=1
	incl	-16(%rbp)
.LBB5_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_3 Depth 2
                                        #       Child Loop BB5_6 Depth 3
	cmpl	$63, -16(%rbp)
	jg	.LBB5_9
# %bb.2:                                #   in Loop: Header=BB5_1 Depth=1
	movl	$0, -12(%rbp)
	jmp	.LBB5_3
	.p2align	4
.LBB5_7:                                #   in Loop: Header=BB5_3 Depth=2
	incl	-12(%rbp)
.LBB5_3:                                #   Parent Loop BB5_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_6 Depth 3
	cmpl	$63, -12(%rbp)
	jg	.LBB5_8
# %bb.4:                                #   in Loop: Header=BB5_3 Depth=2
	movl	$0, -8(%rbp)
	cmpl	$63, -8(%rbp)
	jg	.LBB5_7
	.p2align	4
.LBB5_6:                                #   Parent Loop BB5_1 Depth=1
                                        #     Parent Loop BB5_3 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	-16(%rbp), %rax
	movslq	-12(%rbp), %rcx
	leal	(%rcx,%rax), %edx
	movslq	-8(%rbp), %rsi
	addl	%esi, %edx
	andl	$7, %edx
	xorps	%xmm1, %xmm1
	cvtsi2ss	%edx, %xmm1
	mulss	.LCPI5_4(%rip), %xmm1
	shlq	$14, %rax
	shlq	$8, %rcx
	addq	%rax, %rcx
	movss	%xmm1, main.A(%rcx,%rsi,4)
	movslq	-16(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	%eax, %edx
	subl	%ecx, %edx
	movslq	-8(%rbp), %rsi
	addl	%esi, %edx
	andl	$3, %edx
	xorps	%xmm1, %xmm1
	cvtsi2ss	%edx, %xmm1
	mulss	%xmm0, %xmm1
	shlq	$14, %rax
	shlq	$8, %rcx
	addq	%rax, %rcx
	movss	%xmm1, main.B(%rcx,%rsi,4)
	incl	-8(%rbp)
	cmpl	$63, -8(%rbp)
	jle	.LBB5_6
	jmp	.LBB5_7
.LBB5_9:
	movl	$main.A, %edi
	movl	$main.B, %esi
	movl	$main.C, %edx
	callq	batched_gemm
	movss	main.C(%rip), %xmm0             # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str, %edi
	movb	$1, %al
	callq	printf@PLT
	movss	.LCPI5_4(%rip), %xmm1           # xmm1 = [9.99999977E-3,0.0E+0,0.0E+0,0.0E+0]
	movl	$0, -36(%rbp)
	jmp	.LBB5_10
	.p2align	4
.LBB5_17:                               #   in Loop: Header=BB5_10 Depth=1
	incl	-36(%rbp)
.LBB5_10:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_12 Depth 2
                                        #       Child Loop BB5_15 Depth 3
	cmpl	$15, -36(%rbp)
	jg	.LBB5_18
# %bb.11:                               #   in Loop: Header=BB5_10 Depth=1
	movl	$0, -32(%rbp)
	jmp	.LBB5_12
	.p2align	4
.LBB5_16:                               #   in Loop: Header=BB5_12 Depth=2
	incl	-32(%rbp)
.LBB5_12:                               #   Parent Loop BB5_10 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_15 Depth 3
	cmpl	$4, -32(%rbp)
	jg	.LBB5_17
# %bb.13:                               #   in Loop: Header=BB5_12 Depth=2
	movl	$0, -28(%rbp)
	cmpl	$4, -28(%rbp)
	jg	.LBB5_16
	.p2align	4
.LBB5_15:                               #   Parent Loop BB5_10 Depth=1
                                        #     Parent Loop BB5_12 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	-36(%rbp), %rax
	movslq	-32(%rbp), %rcx
	leal	(%rcx,%rax), %edx
	movslq	-28(%rbp), %rsi
	addl	%esi, %edx
	xorps	%xmm0, %xmm0
	cvtsi2ss	%edx, %xmm0
	mulss	%xmm1, %xmm0
	imulq	$100, %rax, %rax
	leaq	(%rcx,%rcx,4), %rcx
	leaq	(%rax,%rcx,4), %rax
	movss	%xmm0, main.Wt(%rax,%rsi,4)
	incl	-28(%rbp)
	cmpl	$4, -28(%rbp)
	jle	.LBB5_15
	jmp	.LBB5_16
.LBB5_18:
	movl	$main.IN, %edi
	movl	$main.Wt, %esi
	movl	$main.O, %edx
	callq	conv2d
	movss	main.O(%rip), %xmm0             # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.1, %edi
	movb	$1, %al
	callq	printf@PLT
	movl	$0, -4(%rbp)
	cmpl	$4095, -4(%rbp)                 # imm = 0xFFF
	jg	.LBB5_21
	.p2align	4
.LBB5_20:                               # =>This Inner Loop Header: Depth=1
	xorps	%xmm0, %xmm0
	cvtsi2sdl	-4(%rbp), %xmm0
	mulsd	.LCPI5_2(%rip), %xmm0
	mulsd	.LCPI5_3(%rip), %xmm0
	callq	sin@PLT
	cvtsd2ss	%xmm0, %xmm0
	movslq	-4(%rbp), %rax
	movss	%xmm0, main.sig(,%rax,8)
	movl	$0, main.sig+4(,%rax,8)
	incl	-4(%rbp)
	cmpl	$4095, -4(%rbp)                 # imm = 0xFFF
	jle	.LBB5_20
.LBB5_21:
	movl	$main.sig, %edi
	callq	fft_4096
	movss	main.sig+8(%rip), %xmm0         # xmm0 = mem[0],zero,zero,zero
	movss	main.sig+12(%rip), %xmm1        # xmm1 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	cvtss2sd	%xmm1, %xmm1
	movl	$.L.str.2, %edi
	movb	$2, %al
	callq	printf@PLT
	movl	$16384, %edi                    # imm = 0x4000
	callq	malloc@PLT
	movq	%rax, -56(%rbp)
	movl	$0, -24(%rbp)
	movss	.LCPI5_0(%rip), %xmm0           # xmm0 = [4.8828125E-4,0.0E+0,0.0E+0,0.0E+0]
	movss	.LCPI5_1(%rip), %xmm1           # xmm1 = [-1.0E+0,0.0E+0,0.0E+0,0.0E+0]
	cmpl	$4095, -24(%rbp)                # imm = 0xFFF
	jg	.LBB5_24
	.p2align	4
.LBB5_23:                               # =>This Inner Loop Header: Depth=1
	movslq	-24(%rbp), %rax
	xorps	%xmm2, %xmm2
	cvtsi2ss	%eax, %xmm2
	mulss	%xmm0, %xmm2
	addss	%xmm1, %xmm2
	movq	-56(%rbp), %rcx
	movss	%xmm2, (%rcx,%rax,4)
	incl	-24(%rbp)
	cmpl	$4095, -24(%rbp)                # imm = 0xFFF
	jle	.LBB5_23
.LBB5_24:
	movq	-56(%rbp), %rdi
	movl	$4096, %esi                     # imm = 0x1000
	callq	gelu_layernorm
	movq	-56(%rbp), %rax
	movss	(%rax), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str.3, %edi
	movb	$1, %al
	callq	printf@PLT
	movl	$16384, %edi                    # imm = 0x4000
	callq	malloc@PLT
	movq	%rax, -48(%rbp)
	movl	$0, -20(%rbp)
	cmpl	$4095, -20(%rbp)                # imm = 0xFFF
	jg	.LBB5_27
	.p2align	4
.LBB5_26:                               # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$1, (%rax,%rcx,4)
	incl	-20(%rbp)
	cmpl	$4095, -20(%rbp)                # imm = 0xFFF
	jle	.LBB5_26
.LBB5_27:
	movq	-48(%rbp), %rdi
	movl	$4096, %esi                     # imm = 0x1000
	callq	prefix_sum
	movq	-48(%rbp), %rax
	movl	16380(%rax), %edx
	movl	$.L.str.4, %edi
	movl	$4095, %esi                     # imm = 0xFFF
	xorl	%eax, %eax
	callq	printf@PLT
	movq	-56(%rbp), %rdi
	callq	free@PLT
	movq	-48(%rbp), %rdi
	callq	free@PLT
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
	.cfi_endproc
                                        # -- End function
	.type	main.A,@object                  # @main.A
	.local	main.A
	.comm	main.A,1048576,16
	.type	main.B,@object                  # @main.B
	.local	main.B
	.comm	main.B,1048576,16
	.type	main.C,@object                  # @main.C
	.local	main.C
	.comm	main.C,1048576,16
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"C[0][0][0]=%f\n"
	.size	.L.str, 15

	.type	main.IN,@object                 # @main.IN
	.local	main.IN
	.comm	main.IN,82944,16
	.type	main.Wt,@object                 # @main.Wt
	.local	main.Wt
	.comm	main.Wt,1600,16
	.type	main.O,@object                  # @main.O
	.local	main.O
	.comm	main.O,4096,16
	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"O[0][0]=%f\n"
	.size	.L.str.1, 12

	.type	main.sig,@object                # @main.sig
	.local	main.sig
	.comm	main.sig,32768,16
	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"FFT[1]=%f%+fi\n"
	.size	.L.str.2, 15

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"vec[0]=%f\n"
	.size	.L.str.3, 11

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"scan[%d]=%d\n"
	.size	.L.str.4, 13

	.ident	"clang version 21.0.0git (https://github.com/llvm/llvm-project.git 8e104d69fc4a7fa6e93fd543208f184628d1d2ae)"
	.section	".note.GNU-stack","",@progbits

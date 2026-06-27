	.file	"register_pressure.cpp"
	.text
	.globl	_Z23heavy_register_pressureiiiiiiiiiiiiiiiib # -- Begin function _Z23heavy_register_pressureiiiiiiiiiiiiiiiib
	.p2align	4
	.type	_Z23heavy_register_pressureiiiiiiiiiiiiiiiib,@function
_Z23heavy_register_pressureiiiiiiiiiiiiiiiib: # @_Z23heavy_register_pressureiiiiiiiiiiiiiiiib
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%r8d, %r12d
	movl	%edx, %ebx
	movl	%esi, %r11d
	movl	280(%rsp), %esi
	movl	272(%rsp), %r10d
	movl	264(%rsp), %r14d
	movl	256(%rsp), %r15d
	movl	%esi, -128(%rsp)                # 4-byte Spill
	movslq	%esi, %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	xorl	%r10d, %esi
	movl	%esi, -32(%rsp)                 # 4-byte Spill
	movslq	%r10d, %rax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	xorl	%r14d, %r10d
	movl	%r10d, -28(%rsp)                # 4-byte Spill
	movslq	%r14d, %rsi
	movq	%rsi, 24(%rsp)                  # 8-byte Spill
	xorl	%r15d, %r14d
	movl	%r14d, -36(%rsp)                # 4-byte Spill
	movslq	%r15d, %rsi
	movq	%rsi, 16(%rsp)                  # 8-byte Spill
	movl	248(%rsp), %r8d
	xorl	%r8d, %r15d
	movslq	%r8d, %rsi
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	movl	240(%rsp), %r10d
	xorl	%r10d, %r8d
	movslq	%r10d, %rsi
	movq	%rsi, (%rsp)                    # 8-byte Spill
	movl	232(%rsp), %eax
	xorl	%eax, %r10d
	movslq	%eax, %rsi
	movq	%rsi, -56(%rsp)                 # 8-byte Spill
	movl	224(%rsp), %r14d
	xorl	%r14d, %eax
	movslq	%r14d, %rdx
	movq	%rdx, -48(%rsp)                 # 8-byte Spill
	movl	216(%rsp), %esi
	xorl	%esi, %r14d
	movslq	%esi, %rdx
	movq	%rdx, -64(%rsp)                 # 8-byte Spill
	movl	208(%rsp), %r13d
	xorl	%r13d, %esi
	movslq	%r13d, %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	xorl	%r9d, %r13d
	movslq	%r9d, %rdx
	movq	%rdx, -80(%rsp)                 # 8-byte Spill
	xorl	%r12d, %r9d
	movslq	%r12d, %rdx
	movq	%rdx, -88(%rsp)                 # 8-byte Spill
	xorl	%ecx, %r12d
	movslq	%ecx, %rdx
	movq	%rdx, -96(%rsp)                 # 8-byte Spill
	xorl	%ebx, %ecx
	movslq	%ebx, %rdx
	movq	%rdx, -104(%rsp)                # 8-byte Spill
	xorl	%r11d, %ebx
	movslq	%r11d, %rdx
	xorl	%edi, %r11d
	movl	-128(%rsp), %ebp                # 4-byte Reload
	xorl	%edi, %ebp
	cmpb	$0, 288(%rsp)
	movslq	%edi, %rdi
	movq	%rdi, -128(%rsp)                # 8-byte Spill
	movslq	%r11d, %rdi
	movq	%rdi, 40(%rsp)                  # 8-byte Spill
	movslq	%ebx, %rdi
	movq	%rdi, 48(%rsp)                  # 8-byte Spill
	movslq	%ecx, %rdi
	movq	%rdi, 56(%rsp)                  # 8-byte Spill
	movslq	%r12d, %rdi
	movq	%rdi, 64(%rsp)                  # 8-byte Spill
	movslq	%r9d, %rdi
	movq	%rdi, 72(%rsp)                  # 8-byte Spill
	movslq	%r13d, %rdi
	movq	%rdi, 80(%rsp)                  # 8-byte Spill
	movslq	%esi, %rdi
	movq	%rdi, 88(%rsp)                  # 8-byte Spill
	movslq	%r14d, %rdi
	movq	%rdi, 136(%rsp)                 # 8-byte Spill
	movl	%eax, -116(%rsp)                # 4-byte Spill
	movslq	%eax, %rdi
	movq	%rdi, 96(%rsp)                  # 8-byte Spill
	movl	%r10d, -40(%rsp)                # 4-byte Spill
	movslq	%r10d, %rdi
	movl	-32(%rsp), %r10d                # 4-byte Reload
	movq	%rdi, -8(%rsp)                  # 8-byte Spill
	movl	%r8d, -112(%rsp)                # 4-byte Spill
	movslq	%r8d, %rdi
	movq	%rdi, 104(%rsp)                 # 8-byte Spill
	movl	%r15d, -108(%rsp)               # 4-byte Spill
	movslq	%r15d, %rdi
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	movl	-36(%rsp), %edi                 # 4-byte Reload
	movl	%edi, %eax
	movslq	%edi, %rdi
	movq	%rdi, 120(%rsp)                 # 8-byte Spill
	movl	-28(%rsp), %edi                 # 4-byte Reload
	movl	%edi, %r15d
	movslq	%edi, %rdi
	movq	%rdi, 128(%rsp)                 # 8-byte Spill
	movslq	%r10d, %rdi
	movq	%rdi, 144(%rsp)                 # 8-byte Spill
	movslq	%ebp, %rdi
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	je	.LBB0_2
# %bb.1:                                # %if.then
	movq	80(%rsp), %rsi                  # 8-byte Reload
	imulq	72(%rsp), %rsi                  # 8-byte Folded Reload
	movq	136(%rsp), %rcx                 # 8-byte Reload
	imulq	88(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%rsi, %rcx
	movq	-88(%rsp), %rsi                 # 8-byte Reload
	movq	-128(%rsp), %rbx                # 8-byte Reload
	imulq	%rbx, %rsi
	movq	-80(%rsp), %r8                  # 8-byte Reload
	imulq	%rdx, %r8
	addq	%rsi, %r8
	movq	48(%rsp), %rsi                  # 8-byte Reload
	imulq	40(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rsi, %r8
	movq	64(%rsp), %rsi                  # 8-byte Reload
	imulq	56(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rsi, %r8
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	imulq	-104(%rsp), %rsi                # 8-byte Folded Reload
	addq	%r8, %rsi
	movq	-64(%rsp), %r8                  # 8-byte Reload
	movq	-96(%rsp), %r15                 # 8-byte Reload
	imulq	%r15, %r8
	addq	%rsi, %r8
	movq	-8(%rsp), %rdi                  # 8-byte Reload
	movq	%rdi, %rsi
	imulq	96(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rcx, %r8
	movq	16(%rsp), %r12                  # 8-byte Reload
	movq	%r12, %rcx
	imulq	-48(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rsi, %rcx
	movq	24(%rsp), %r14                  # 8-byte Reload
	movq	%r14, %rsi
	imulq	-56(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%rcx, %rsi
	movq	112(%rsp), %rcx                 # 8-byte Reload
	imulq	104(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r8, %rsi
	movq	-24(%rsp), %rax                 # 8-byte Reload
	movq	%rax, %r8
	movq	(%rsp), %rbp                    # 8-byte Reload
	imulq	%rbp, %r8
	addq	%rcx, %r8
	movq	32(%rsp), %r9                   # 8-byte Reload
	movq	%r9, %r11
	movq	8(%rsp), %r13                   # 8-byte Reload
	imulq	%r13, %r11
	addq	%r8, %r11
	movq	128(%rsp), %rcx                 # 8-byte Reload
	imulq	120(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rcx, %r11
	movl	%edx, %r10d
	imull	%ebx, %r10d
	addq	%rsi, %r11
	movq	144(%rsp), %rcx                 # 8-byte Reload
	movq	-16(%rsp), %r8                  # 8-byte Reload
	imulq	%r8, %rcx
	addq	%rcx, %r11
	movl	%r15d, %ebx
	imull	-104(%rsp), %ebx                # 4-byte Folded Reload
	jmp	.LBB0_3
.LBB0_2:                                # %if.else
	xorl	%r11d, -116(%rsp)               # 4-byte Folded Spill
	movl	-40(%rsp), %r11d                # 4-byte Reload
	xorl	%ebx, %r11d
	xorl	%ecx, -112(%rsp)                # 4-byte Folded Spill
	xorl	%r12d, -108(%rsp)               # 4-byte Folded Spill
	xorl	%r9d, %eax
	xorl	%r13d, %r15d
	movslq	%eax, %rcx
	movslq	%r15d, %r8
	addq	%rcx, %r8
	xorl	%esi, %r10d
	movslq	%r10d, %rcx
	addq	%r8, %rcx
	xorl	%r14d, %ebp
	movslq	%ebp, %rsi
	addq	%rcx, %rsi
	movl	%edx, %r10d
	movq	-128(%rsp), %r8                 # 8-byte Reload
	imull	%r8d, %r10d
	movslq	%r10d, %rcx
	movq	-96(%rsp), %r9                  # 8-byte Reload
	movl	%r9d, %ebx
	movq	-104(%rsp), %rdi                # 8-byte Reload
	imull	%edi, %ebx
	addq	%rdx, %r8
	addq	%rdi, %r8
	addq	%r9, %r8
	addq	%rcx, %r8
	movslq	%ebx, %rcx
	addq	-88(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r8, %rcx
	addq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	movq	-64(%rsp), %r8                  # 8-byte Reload
	movq	-72(%rsp), %r9                  # 8-byte Reload
	addq	%r9, %r8
	addq	%r8, %rcx
	movq	-48(%rsp), %r8                  # 8-byte Reload
	movq	-56(%rsp), %r9                  # 8-byte Reload
	addq	%r9, %r8
	movq	(%rsp), %rbp                    # 8-byte Reload
	addq	%rbp, %r8
	addq	%rcx, %r8
	movslq	-116(%rsp), %rcx                # 4-byte Folded Reload
	movq	8(%rsp), %r13                   # 8-byte Reload
	addq	%r13, %rcx
	addq	%r8, %rcx
	movslq	%r11d, %r8
	movq	16(%rsp), %r12                  # 8-byte Reload
	addq	%r12, %r8
	movq	24(%rsp), %r14                  # 8-byte Reload
	addq	%r14, %r8
	addq	%rcx, %r8
	movslq	-112(%rsp), %r11                # 4-byte Folded Reload
	movslq	-108(%rsp), %rcx                # 4-byte Folded Reload
	movq	-24(%rsp), %rax                 # 8-byte Reload
	addq	%rax, %r11
	addq	%rcx, %r11
	movq	32(%rsp), %r9                   # 8-byte Reload
	addq	%r9, %r11
	addq	%r8, %r11
	addq	%rsi, %r11
	movq	-16(%rsp), %r8                  # 8-byte Reload
	movq	-8(%rsp), %rdi                  # 8-byte Reload
.LBB0_3:                                # %if.end
	addq	-128(%rsp), %rdx                # 8-byte Folded Reload
	addq	-104(%rsp), %rdx                # 8-byte Folded Reload
	addq	40(%rsp), %rdx                  # 8-byte Folded Reload
	movslq	%r10d, %rcx
	addq	%rcx, %rdx
	movq	-96(%rsp), %rsi                 # 8-byte Reload
	addq	48(%rsp), %rsi                  # 8-byte Folded Reload
	addq	-88(%rsp), %rsi                 # 8-byte Folded Reload
	addq	56(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rdx, %rsi
	movslq	%ebx, %rcx
	addq	-80(%rsp), %rcx                 # 8-byte Folded Reload
	addq	64(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%rsi, %rcx
	movq	-72(%rsp), %rsi                 # 8-byte Reload
	addq	72(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%rcx, %rsi
	movq	-64(%rsp), %rdx                 # 8-byte Reload
	addq	80(%rsp), %rdx                  # 8-byte Folded Reload
	addq	%rsi, %rdx
	movq	-48(%rsp), %rcx                 # 8-byte Reload
	addq	88(%rsp), %rcx                  # 8-byte Folded Reload
	addq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rdx, %rcx
	movq	136(%rsp), %rdx                 # 8-byte Reload
	addq	%rbp, %rdx
	addq	96(%rsp), %rdx                  # 8-byte Folded Reload
	addq	%r13, %rdx
	addq	%rcx, %rdx
	addq	%r12, %rdi
	addq	104(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%r14, %rdi
	addq	112(%rsp), %rdi                 # 8-byte Folded Reload
	addq	%rdx, %rdi
	addq	120(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r9, %rax
	addq	128(%rsp), %rax                 # 8-byte Folded Reload
	addq	144(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r8, %rax
	addq	%rdi, %rax
	addq	%r11, %rax
	addq	$152, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_Z23heavy_register_pressureiiiiiiiiiiiiiiiib, .Lfunc_end0-_Z23heavy_register_pressureiiiiiiiiiiiiiiiib
	.cfi_endproc
                                        # -- End function
	.globl	_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii # -- Begin function _Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii
	.p2align	4
	.type	_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii,@function
_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii: # @_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%edi, -128(%rsp)                # 4-byte Spill
	movl	72(%rsp), %eax
	movl	64(%rsp), %ebp
	movl	%esi, %r10d
	xorl	%edi, %r10d
	movl	%r10d, -96(%rsp)                # 4-byte Spill
	movl	%r10d, %edi
	xorl	%edx, %edi
	movl	%edi, -88(%rsp)                 # 4-byte Spill
	movl	%edx, %edi
	movl	%esi, -116(%rsp)                # 4-byte Spill
	xorl	%esi, %edi
	xorl	%ecx, %edi
	movl	%edi, -104(%rsp)                # 4-byte Spill
	movl	%ecx, %esi
	movl	%edx, -124(%rsp)                # 4-byte Spill
	xorl	%edx, %esi
	xorl	%r8d, %esi
	movl	%esi, %edx
	movl	%r8d, %r15d
	movl	%ecx, -120(%rsp)                # 4-byte Spill
	xorl	%ecx, %r15d
	xorl	%r9d, %r15d
	movl	%r9d, %ebx
	movl	%r8d, -108(%rsp)                # 4-byte Spill
	xorl	%r8d, %ebx
	xorl	%ebp, %ebx
	movl	%ebp, %r12d
	movl	%r9d, -112(%rsp)                # 4-byte Spill
	xorl	%r9d, %r12d
	xorl	%eax, %r12d
	movl	%eax, %r13d
	xorl	%ebp, %r13d
	movl	80(%rsp), %ecx
	xorl	%ecx, %r13d
	movl	%ecx, %ebp
	xorl	%eax, %ebp
	movl	88(%rsp), %eax
	xorl	%eax, %ebp
	movl	%eax, %r11d
	xorl	%ecx, %r11d
	movl	96(%rsp), %ecx
	xorl	%ecx, %r11d
	movl	%ecx, %r9d
	xorl	%eax, %r9d
	movl	104(%rsp), %eax
	xorl	%eax, %r9d
	movl	%eax, %r14d
	xorl	%ecx, %r14d
	movl	112(%rsp), %ecx
	xorl	%ecx, %r14d
	movl	%ecx, %r8d
	xorl	%eax, %r8d
	movl	120(%rsp), %eax
	xorl	%eax, %r8d
	movl	%eax, %esi
	xorl	%ecx, %esi
	movl	128(%rsp), %r10d
	xorl	%r10d, %esi
	movl	%r10d, %ecx
	xorl	%eax, %ecx
	movl	136(%rsp), %edi
	xorl	%edi, %ecx
	movl	%edi, %eax
	xorl	-128(%rsp), %eax                # 4-byte Folded Reload
	xorl	%r10d, %eax
	movl	-96(%rsp), %r10d                # 4-byte Reload
	xorl	%edi, %r10d
	movslq	-88(%rsp), %rdi                 # 4-byte Folded Reload
	movq	%rdi, -80(%rsp)                 # 8-byte Spill
	movslq	-104(%rsp), %rdi                # 4-byte Folded Reload
	movq	%rdi, -72(%rsp)                 # 8-byte Spill
	movslq	%edx, %rdi
	movq	%rdi, -64(%rsp)                 # 8-byte Spill
	movslq	%r15d, %rdi
	movq	%rdi, -104(%rsp)                # 8-byte Spill
	movslq	%ebx, %rdi
	movq	%rdi, -96(%rsp)                 # 8-byte Spill
	movslq	%r12d, %rdi
	movq	%rdi, -88(%rsp)                 # 8-byte Spill
	movslq	%r13d, %rdi
	movslq	%ebp, %rbx
	movslq	%r11d, %rbp
	movslq	%r9d, %r9
	movslq	%r14d, %r12
	movslq	%r8d, %r13
	movslq	%esi, %r11
	movslq	%ecx, %r14
	movslq	%eax, %r15
	movslq	%r10d, %r8
	movl	144(%rsp), %eax
	cmpl	$1, %eax
	movq	%r11, (%rsp)                    # 8-byte Spill
	movq	%r8, -8(%rsp)                   # 8-byte Spill
	movq	%r15, -16(%rsp)                 # 8-byte Spill
	movq	%rdi, -24(%rsp)                 # 8-byte Spill
	movq	%r14, -32(%rsp)                 # 8-byte Spill
	movq	%r13, -40(%rsp)                 # 8-byte Spill
	movq	%r12, -48(%rsp)                 # 8-byte Spill
	movq	%rbp, -56(%rsp)                 # 8-byte Spill
	je	.LBB1_3
# %bb.1:                                # %entry
	testl	%eax, %eax
	jne	.LBB1_5
# %bb.2:                                # %if.then
	movq	%r15, %rax
	imulq	-72(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r14, %rcx
	imulq	-64(%rsp), %rcx                 # 8-byte Folded Reload
	movq	%r11, %rdx
	imulq	-104(%rsp), %rdx                # 8-byte Folded Reload
	addq	%rcx, %rdx
	addq	%rax, %rdx
	movq	%r13, %rax
	imulq	-96(%rsp), %rax                 # 8-byte Folded Reload
	movq	%r12, %rcx
	imulq	-88(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rax, %rcx
	movq	%r9, %rax
	imulq	%rdi, %rax
	movq	%rbp, %r11
	imulq	%rbx, %r11
	addq	%rax, %r11
	addq	%rcx, %r11
	movl	-116(%rsp), %eax                # 4-byte Reload
	movl	%eax, %esi
	imull	-128(%rsp), %esi                # 4-byte Folded Reload
	addq	%rdx, %r11
	movl	%eax, %edx
	movq	%r8, %rax
	movq	-80(%rsp), %r13                 # 8-byte Reload
	imulq	%r13, %rax
	addq	%rax, %r11
	movl	-124(%rsp), %ecx                # 4-byte Reload
	imull	-120(%rsp), %ecx                # 4-byte Folded Reload
	jmp	.LBB1_4
.LBB1_3:                                # %if.then62
	movl	-116(%rsp), %edx                # 4-byte Reload
	movl	%edx, %esi
	imull	-128(%rsp), %esi                # 4-byte Folded Reload
	movslq	%esi, %rax
	movl	-120(%rsp), %ecx                # 4-byte Reload
	imull	-124(%rsp), %ecx                # 4-byte Folded Reload
	movslq	%ecx, %r11
	movq	-80(%rsp), %r13                 # 8-byte Reload
	addq	%r13, %rax
	addq	-72(%rsp), %r11                 # 8-byte Folded Reload
	addq	%rax, %r11
	movq	-104(%rsp), %rax                # 8-byte Reload
	movq	-64(%rsp), %r12                 # 8-byte Reload
	addq	%r12, %rax
	addq	%rax, %r11
	addq	-96(%rsp), %r11                 # 8-byte Folded Reload
	addq	-88(%rsp), %r11                 # 8-byte Folded Reload
	addq	%rdi, %r11
	addq	%rbx, %r11
.LBB1_4:                                # %if.end108
	movl	72(%rsp), %edi
	movl	64(%rsp), %r8d
	movl	-108(%rsp), %r10d               # 4-byte Reload
	movl	-112(%rsp), %ebp                # 4-byte Reload
	movl	80(%rsp), %r14d
	movl	88(%rsp), %r15d
	movl	136(%rsp), %r12d
	jmp	.LBB1_6
.LBB1_5:                                # %if.else85
	movl	-116(%rsp), %edi                # 4-byte Reload
	movl	%edi, %esi
	imull	-128(%rsp), %esi                # 4-byte Folded Reload
	movslq	%esi, %rax
	movl	-120(%rsp), %ecx                # 4-byte Reload
	imull	-124(%rsp), %ecx                # 4-byte Folded Reload
	movslq	%ecx, %rdx
	addq	%rax, %rdx
	addq	%rbp, %rdx
	addq	%r9, %rdx
	addq	%r12, %rdx
	addq	%r13, %r11
	addq	%r14, %r11
	addq	%rdx, %r11
	movl	%edi, %edx
	addq	%r15, %r11
	addq	%r8, %r11
	movl	72(%rsp), %edi
	movl	64(%rsp), %r8d
	movl	-108(%rsp), %r10d               # 4-byte Reload
	movl	-112(%rsp), %ebp                # 4-byte Reload
	movl	80(%rsp), %r14d
	movl	88(%rsp), %r15d
	movl	136(%rsp), %r12d
	movq	-80(%rsp), %r13                 # 8-byte Reload
.LBB1_6:                                # %if.end108
	movslq	-128(%rsp), %rax                # 4-byte Folded Reload
	movslq	%edx, %rdx
	addq	%rax, %rdx
	movslq	-124(%rsp), %rax                # 4-byte Folded Reload
	addq	%rdx, %rax
	movslq	-120(%rsp), %rdx                # 4-byte Folded Reload
	addq	%rax, %rdx
	movslq	%esi, %rax
	addq	%rax, %rdx
	movslq	%ecx, %rax
	movslq	%ebp, %rcx
	addq	%rax, %rcx
	movslq	%r10d, %rax
	addq	%rax, %r13
	addq	-72(%rsp), %r13                 # 8-byte Folded Reload
	addq	%rdx, %r13
	addq	-64(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%r13, %rcx
	movslq	%r8d, %rax
	addq	-104(%rsp), %rax                # 8-byte Folded Reload
	addq	%rcx, %rax
	movslq	%edi, %rcx
	addq	-96(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rax, %rcx
	movslq	%r14d, %rax
	addq	-88(%rsp), %rax                 # 8-byte Folded Reload
	addq	%rcx, %rax
	movslq	%r15d, %rcx
	addq	-24(%rsp), %rcx                 # 8-byte Folded Reload
	movslq	96(%rsp), %rdx
	addq	%rdx, %rcx
	addq	%rax, %rcx
	movslq	104(%rsp), %rax
	addq	%rax, %rbx
	addq	-56(%rsp), %rbx                 # 8-byte Folded Reload
	movslq	112(%rsp), %rax
	addq	%rax, %rbx
	addq	%rcx, %rbx
	movslq	120(%rsp), %rax
	addq	%rax, %r9
	addq	-48(%rsp), %r9                  # 8-byte Folded Reload
	movslq	128(%rsp), %rax
	addq	%rax, %r9
	addq	-40(%rsp), %r9                  # 8-byte Folded Reload
	addq	%rbx, %r9
	movslq	%r12d, %rax
	addq	(%rsp), %rax                    # 8-byte Folded Reload
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	addq	-8(%rsp), %rax                  # 8-byte Folded Reload
	addq	%r11, %rax
	addq	%r9, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii, .Lfunc_end1-_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$152, %rsp
	.cfi_def_cfa_offset 208
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$7, %eax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	cmpl	$2, %edi
	jl	.LBB2_2
# %bb.1:                                # %cond.true
	movq	8(%rsi), %rdi
	xorl	%esi, %esi
	movl	$10, %edx
	callq	__isoc23_strtol@PLT
	movq	%rax, 32(%rsp)                  # 8-byte Spill
.LBB2_2:                                # %cond.end
	movq	$0, 40(%rsp)
	movq	32(%rsp), %rcx                  # 8-byte Reload
	imull	$206, %ecx, %eax
	movl	%eax, 68(%rsp)                  # 4-byte Spill
	movl	%ecx, %eax
	shll	$6, %eax
	leal	(%rax,%rcx,4), %eax
	movl	%eax, 64(%rsp)                  # 4-byte Spill
	leal	(%rcx,%rcx,2), %eax
	leal	(%rcx,%rax,4), %eax
	movl	%eax, 60(%rsp)                  # 4-byte Spill
	imull	$193, %ecx, %eax
	movl	%eax, 56(%rsp)                  # 4-byte Spill
	imull	$67, %ecx, %eax
	movl	%eax, 52(%rsp)                  # 4-byte Spill
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	xorl	%edi, %edi
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	xorl	%r13d, %r13d
	.p2align	4
.LBB2_3:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	%r10d, 92(%rsp)                 # 4-byte Spill
	movl	%r9d, 96(%rsp)                  # 4-byte Spill
	movl	%r8d, 100(%rsp)                 # 4-byte Spill
	movl	%edi, 20(%rsp)                  # 4-byte Spill
	movl	%esi, 24(%rsp)                  # 4-byte Spill
	movl	%ecx, 28(%rsp)                  # 4-byte Spill
	movl	%r13d, %eax
	movl	$2863311531, %edx               # imm = 0xAAAAAAAB
	imulq	%rdx, %rax
	shrq	$33, %rax
	leal	(%rax,%rax,2), %eax
	movl	%eax, 88(%rsp)                  # 4-byte Spill
	movzbl	%cl, %ebx
	movzbl	%r8b, %eax
	movl	%eax, 16(%rsp)                  # 4-byte Spill
	movzbl	%sil, %r15d
	movzbl	%dil, %eax
	movl	%eax, 12(%rsp)                  # 4-byte Spill
	movl	28(%rsp), %ecx                  # 4-byte Reload
	movq	32(%rsp), %r11                  # 8-byte Reload
	xorl	%r11d, %ecx
	movzbl	%cl, %ebp
	movl	%r8d, %edx
	xorl	%r11d, %edx
	movzbl	%dl, %eax
	movl	24(%rsp), %esi                  # 4-byte Reload
	xorl	%r11d, %esi
	movzbl	%sil, %r8d
	movl	20(%rsp), %edi                  # 4-byte Reload
	xorl	%r11d, %edi
	movzbl	%dil, %r11d
	movq	%r11, 104(%rsp)                 # 8-byte Spill
                                        # kill: def $r9d killed $r9d def $r9
	andl	$252, %r9d
	movq	%r9, 136(%rsp)                  # 8-byte Spill
	movl	%r10d, %r9d
	andl	$254, %r9d
	movq	%r9, 128(%rsp)                  # 8-byte Spill
	addl	%ecx, %edx
	movzbl	%dl, %ecx
	movq	%rcx, 120(%rsp)                 # 8-byte Spill
	addl	%esi, %edi
	movzbl	%dil, %ecx
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	movl	%ebx, %edi
	movl	%ebx, 80(%rsp)                  # 4-byte Spill
	movl	%ebx, %r14d
	movl	%r15d, %edx
	movl	%r15d, 76(%rsp)                 # 4-byte Spill
	xorl	%r15d, %r14d
	movl	%r13d, %r12d
	subl	88(%rsp), %r12d                 # 4-byte Folded Reload
	movl	12(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %ebx
	movl	16(%rsp), %esi                  # 4-byte Reload
	xorl	%esi, %ebx
	movl	%ebp, %r9d
	movl	%ebp, 84(%rsp)                  # 4-byte Spill
	movl	%ebp, %r15d
	movq	%r8, %r10
	movq	%r8, 144(%rsp)                  # 8-byte Spill
	xorl	%r10d, %r15d
	movl	%r11d, %ebp
	movl	%eax, %r11d
	movl	%eax, 72(%rsp)                  # 4-byte Spill
	xorl	%eax, %ebp
	movl	%r13d, %eax
	andl	$1, %eax
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movl	%r9d, %r8d
	movl	%r11d, %r9d
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	pushq	%rbp
	.cfi_adjust_cfa_offset 8
	pushq	%r15
	.cfi_adjust_cfa_offset 8
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	pushq	%r14
	.cfi_adjust_cfa_offset 8
	pushq	160(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	176(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	192(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	208(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	184(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	callq	_Z23heavy_register_pressureiiiiiiiiiiiiiiiib
	addq	$96, %rsp
	.cfi_adjust_cfa_offset -96
	addq	%rax, 40(%rsp)
	subq	$8, %rsp
	.cfi_adjust_cfa_offset 8
	movl	88(%rsp), %edi                  # 4-byte Reload
	movl	24(%rsp), %esi                  # 4-byte Reload
	movl	84(%rsp), %edx                  # 4-byte Reload
	movl	20(%rsp), %ecx                  # 4-byte Reload
	movl	92(%rsp), %r8d                  # 4-byte Reload
	movl	80(%rsp), %r9d                  # 4-byte Reload
	pushq	%r12
	.cfi_adjust_cfa_offset 8
	pushq	%rbp
	.cfi_adjust_cfa_offset 8
	pushq	%r15
	.cfi_adjust_cfa_offset 8
	pushq	%rbx
	.cfi_adjust_cfa_offset 8
	pushq	%r14
	.cfi_adjust_cfa_offset 8
	pushq	160(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	176(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	192(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	208(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	184(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	pushq	232(%rsp)                       # 8-byte Folded Reload
	.cfi_adjust_cfa_offset 8
	callq	_Z28heavy_register_pressure_3wayiiiiiiiiiiiiiiiii
	movl	188(%rsp), %r10d                # 4-byte Reload
	movl	192(%rsp), %r9d                 # 4-byte Reload
	movl	196(%rsp), %r8d                 # 4-byte Reload
	movl	116(%rsp), %edi                 # 4-byte Reload
	movl	120(%rsp), %esi                 # 4-byte Reload
	movl	124(%rsp), %ecx                 # 4-byte Reload
	addq	$96, %rsp
	.cfi_adjust_cfa_offset -96
	addq	%rax, 40(%rsp)
	incl	%r13d
	addl	68(%rsp), %r10d                 # 4-byte Folded Reload
	addl	64(%rsp), %r9d                  # 4-byte Folded Reload
	addl	32(%rsp), %r8d                  # 4-byte Folded Reload
	addl	60(%rsp), %edi                  # 4-byte Folded Reload
	addl	56(%rsp), %esi                  # 4-byte Folded Reload
	addl	52(%rsp), %ecx                  # 4-byte Folded Reload
	cmpl	$30000000, %r13d                # imm = 0x1C9C380
	jne	.LBB2_3
# %bb.4:                                # %for.cond.cleanup
	movq	40(%rsp), %rsi
	leaq	.L.str(%rip), %rdi
	xorl	%eax, %eax
	callq	printf@PLT
	xorl	%eax, %eax
	addq	$152, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Result: %lld\n"
	.size	.L.str, 14

	.ident	"clang version 22.1.7 (https://github.com/Vchair44/llvm-project.git e07c6f974658af8b726142ee191a369b486e300c)"
	.section	".note.GNU-stack","",@progbits
	.addrsig

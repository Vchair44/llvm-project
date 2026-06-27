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
	subq	$80, %rsp
	.cfi_def_cfa_offset 136
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	%r9d, %ebx
	movl	144(%rsp), %r11d
	movl	136(%rsp), %r10d
	movl	%esi, %r15d
	xorl	%edi, %r15d
	movl	%edx, %r9d
	xorl	%esi, %r9d
	movl	%ecx, %eax
	movl	%edx, -120(%rsp)                # 4-byte Spill
	xorl	%edx, %eax
	movl	%eax, -80(%rsp)                 # 4-byte Spill
	movl	%r8d, %eax
	xorl	%ecx, %eax
	movl	%eax, -88(%rsp)                 # 4-byte Spill
	movl	%ebx, %r12d
	xorl	%r8d, %r12d
	movl	%r10d, %r14d
	xorl	%ebx, %r14d
	movl	%r11d, %ebp
	xorl	%r10d, %ebp
	movl	152(%rsp), %r10d
	movl	%r10d, %r13d
	xorl	%r11d, %r13d
	movl	160(%rsp), %edx
	movl	%edx, %eax
	xorl	%r10d, %eax
	movl	%eax, -112(%rsp)                # 4-byte Spill
	movl	168(%rsp), %r10d
	movl	%r10d, %eax
	xorl	%edx, %eax
	movl	%eax, -96(%rsp)                 # 4-byte Spill
	movl	176(%rsp), %edx
	movl	%edx, %eax
	xorl	%r10d, %eax
	movl	%eax, -72(%rsp)                 # 4-byte Spill
	movl	184(%rsp), %r11d
	movl	%r11d, %eax
	xorl	%edx, %eax
	movl	%eax, -52(%rsp)                 # 4-byte Spill
	movl	192(%rsp), %r10d
	movl	%r10d, %edx
	xorl	%r11d, %edx
	movl	200(%rsp), %r11d
	movl	%r11d, %eax
	xorl	%r10d, %eax
	movl	%eax, -104(%rsp)                # 4-byte Spill
	movl	208(%rsp), %eax
	movl	%eax, %r10d
	xorl	%r11d, %r10d
	xorl	%edi, %eax
	movl	%eax, -124(%rsp)                # 4-byte Spill
	cmpb	$0, 216(%rsp)
	movl	%edx, -56(%rsp)                 # 4-byte Spill
	movl	%r10d, -60(%rsp)                # 4-byte Spill
	je	.LBB0_2
# %bb.1:                                # %if.then
	movslq	%r12d, %rdx
	movslq	%r14d, %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	imulq	%rdx, %rax
	movslq	%ebp, %rdx
	movq	%rdx, (%rsp)                    # 8-byte Spill
	movslq	%r13d, %r14
	movq	%r14, -8(%rsp)                  # 8-byte Spill
	movl	%r9d, %r11d
	movq	%r14, %r9
	imulq	%rdx, %r9
	addq	%rax, %r9
	movslq	%r8d, %r8
	movslq	%edi, %rax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	movq	%r8, 72(%rsp)                   # 8-byte Spill
	imulq	%rax, %r8
	movslq	%ebx, %rdx
	movslq	%esi, %rax
	movq	%rdx, %r10
	imulq	%rax, %r10
	addq	%r8, %r10
	movslq	%r15d, %rbx
	movslq	%r11d, %r8
	movq	%r8, -40(%rsp)                  # 8-byte Spill
	movq	%rbx, -32(%rsp)                 # 8-byte Spill
	imulq	%rbx, %r8
	addq	%r8, %r10
	movslq	-80(%rsp), %rbx                 # 4-byte Folded Reload
	movslq	-88(%rsp), %r8                  # 4-byte Folded Reload
	movq	%r8, -88(%rsp)                  # 8-byte Spill
	movq	%rbx, -80(%rsp)                 # 8-byte Spill
	imulq	%rbx, %r8
	addq	%r8, %r10
	movslq	136(%rsp), %r8
	movslq	-120(%rsp), %rbx                # 4-byte Folded Reload
	movq	%r8, 56(%rsp)                   # 8-byte Spill
	movq	%rbx, 64(%rsp)                  # 8-byte Spill
	imulq	%rbx, %r8
	addq	%r10, %r8
	movslq	144(%rsp), %r11
	movslq	%ecx, %r10
	movq	%r11, 48(%rsp)                  # 8-byte Spill
	imulq	%r10, %r11
	addq	%r8, %r11
	addq	%r9, %r11
	movslq	-112(%rsp), %r9                 # 4-byte Folded Reload
	movslq	-96(%rsp), %r8                  # 4-byte Folded Reload
	movq	%r8, -96(%rsp)                  # 8-byte Spill
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	imulq	%r9, %r8
	movslq	152(%rsp), %rbx
	movslq	184(%rsp), %rbp
	movq	%rbp, %r9
	imulq	%rbx, %r9
	addq	%r8, %r9
	movslq	160(%rsp), %r8
	movslq	192(%rsp), %r15
	movq	%r15, 32(%rsp)                  # 8-byte Spill
	movq	%r8, 40(%rsp)                   # 8-byte Spill
	imulq	%r8, %r15
	addq	%r9, %r15
	addq	%r11, %r15
	movslq	-72(%rsp), %r8                  # 4-byte Folded Reload
	movslq	-52(%rsp), %r9                  # 4-byte Folded Reload
	movq	%r9, -72(%rsp)                  # 8-byte Spill
	movq	%r8, -48(%rsp)                  # 8-byte Spill
	imulq	%r8, %r9
	movslq	168(%rsp), %r8
	movslq	200(%rsp), %r13
	movq	%r13, %r14
	imulq	%r8, %r14
	addq	%r9, %r14
	movslq	176(%rsp), %r9
	movslq	208(%rsp), %r11
	movq	%r11, 16(%rsp)                  # 8-byte Spill
	movq	%r9, 24(%rsp)                   # 8-byte Spill
	imulq	%r9, %r11
	addq	%r14, %r11
	movslq	-56(%rsp), %r14                 # 4-byte Folded Reload
	movslq	-104(%rsp), %r12                # 4-byte Folded Reload
	movq	%r12, -104(%rsp)                # 8-byte Spill
	imulq	%r14, %r12
	addq	%r12, %r11
	addq	%r15, %r11
	movslq	-60(%rsp), %r9                  # 4-byte Folded Reload
	movslq	-124(%rsp), %r15                # 4-byte Folded Reload
	movq	%r9, %r12
	imulq	%r15, %r12
	addq	%r12, %r11
	movq	-8(%rsp), %r12                  # 8-byte Reload
	imull	%edi, %esi
	movq	(%rsp), %rdi                    # 8-byte Reload
	imull	-120(%rsp), %ecx                # 4-byte Folded Reload
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	movslq	%esi, %rsi
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	movq	8(%rsp), %rsi                   # 8-byte Reload
	movslq	%ecx, %rcx
	jmp	.LBB0_3
.LBB0_2:                                # %if.else
	movl	%edx, %eax
	movl	%r12d, -24(%rsp)                # 4-byte Spill
	xorl	%r12d, %eax
	cltq
	movl	-104(%rsp), %edx                # 4-byte Reload
	xorl	%r14d, %edx
	movslq	%edx, %rdx
	addq	%rax, %rdx
	movl	%r10d, %eax
	movl	%ebp, -48(%rsp)                 # 4-byte Spill
	xorl	%ebp, %eax
	cltq
	addq	%rdx, %rax
	movl	-124(%rsp), %edx                # 4-byte Reload
	movl	%r13d, -8(%rsp)                 # 4-byte Spill
	xorl	%r13d, %edx
	movslq	%edx, %rdx
	addq	%rax, %rdx
	movq	%rdx, -32(%rsp)                 # 8-byte Spill
	movslq	%edi, %rdx
	movslq	%esi, %rax
	addq	%rdx, %rax
	imull	%edi, %esi
	movslq	%ecx, %r10
	movl	-120(%rsp), %r13d               # 4-byte Reload
	imull	%r13d, %ecx
	movslq	%r13d, %rdi
	movslq	%r8d, %rdx
	movslq	%esi, %rsi
	movslq	%ecx, %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	movq	%rdi, 64(%rsp)                  # 8-byte Spill
	addq	%rax, %rdi
	addq	%r10, %rdi
	movq	%rsi, -120(%rsp)                # 8-byte Spill
	addq	%rsi, %rdi
	movq	%rdx, 72(%rsp)                  # 8-byte Spill
	addq	%rcx, %rdx
	addq	%rdx, %rdi
	movslq	%ebx, %rcx
	movq	%rcx, (%rsp)                    # 8-byte Spill
	movslq	136(%rsp), %rsi
	movslq	144(%rsp), %r8
	addq	%rcx, %rdi
	movq	%rsi, 56(%rsp)                  # 8-byte Spill
	movq	%r8, 48(%rsp)                   # 8-byte Spill
	addq	%rsi, %r8
	addq	%r8, %rdi
	movslq	152(%rsp), %rdx
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	movslq	160(%rsp), %rcx
	movslq	168(%rsp), %r8
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	leaq	(%rdx,%rcx), %r11
	addq	%r8, %r11
	addq	%rdi, %r11
	movl	-112(%rsp), %edi                # 4-byte Reload
	xorl	%r15d, %edi
	movslq	%edi, %rdi
	movslq	176(%rsp), %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	addq	%rcx, %rdi
	addq	%r11, %rdi
	movl	-96(%rsp), %ebx                 # 4-byte Reload
	movl	%ebx, %r11d
	xorl	%r9d, %r11d
	movslq	%r11d, %rsi
	movslq	184(%rsp), %rbp
	movslq	192(%rsp), %rcx
	addq	%rbp, %rsi
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	addq	%rcx, %rsi
	addq	%rdi, %rsi
	movl	-72(%rsp), %ecx                 # 4-byte Reload
	movl	%ecx, %edi
	movl	%r9d, -40(%rsp)                 # 4-byte Spill
	movl	%r15d, %r9d
	movl	-88(%rsp), %r15d                # 4-byte Reload
	movl	-80(%rsp), %r12d                # 4-byte Reload
	xorl	%r12d, %edi
	movslq	%edi, %r11
	movl	-52(%rsp), %edx                 # 4-byte Reload
	movl	%edx, %edi
	xorl	%r15d, %edi
	movslq	%edi, %rdi
	movslq	200(%rsp), %r13
	addq	%r13, %r11
	addq	%rdi, %r11
	movslq	208(%rsp), %rdi
	movq	%rdi, 16(%rsp)                  # 8-byte Spill
	addq	%rdi, %r11
	addq	%rsi, %r11
	addq	-32(%rsp), %r11                 # 8-byte Folded Reload
	movslq	%r9d, %rsi
	movq	%rsi, -32(%rsp)                 # 8-byte Spill
	movslq	-40(%rsp), %rsi                 # 4-byte Folded Reload
	movq	%rsi, -40(%rsp)                 # 8-byte Spill
	movslq	%r12d, %rsi
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	movslq	%r15d, %rsi
	movq	%rsi, -88(%rsp)                 # 8-byte Spill
	movslq	-24(%rsp), %rsi                 # 4-byte Folded Reload
	movq	%rsi, -24(%rsp)                 # 8-byte Spill
	movslq	%r14d, %rsi
	movslq	-48(%rsp), %rdi                 # 4-byte Folded Reload
	movslq	-8(%rsp), %r12                  # 4-byte Folded Reload
	movslq	-112(%rsp), %r9                 # 4-byte Folded Reload
	movq	%r9, -112(%rsp)                 # 8-byte Spill
	movslq	%ebx, %r9
	movq	%r9, -96(%rsp)                  # 8-byte Spill
	movq	-16(%rsp), %rbx                 # 8-byte Reload
	movslq	%ecx, %rcx
	movq	%rcx, -48(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %rcx                   # 8-byte Reload
	movslq	%edx, %rdx
	movq	%rdx, -72(%rsp)                 # 8-byte Spill
	movq	(%rsp), %rdx                    # 8-byte Reload
	movslq	-56(%rsp), %r14                 # 4-byte Folded Reload
	movslq	-104(%rsp), %r9                 # 4-byte Folded Reload
	movq	%r9, -104(%rsp)                 # 8-byte Spill
	movslq	-60(%rsp), %r9                  # 4-byte Folded Reload
	movslq	-124(%rsp), %r15                # 4-byte Folded Reload
.LBB0_3:                                # %if.end
	addq	%r14, %r13
	addq	16(%rsp), %r13                  # 8-byte Folded Reload
	addq	-104(%rsp), %r13                # 8-byte Folded Reload
	addq	%r9, %r13
	addq	%r15, %r13
	addq	-96(%rsp), %rbp                 # 8-byte Folded Reload
	addq	-48(%rsp), %rbp                 # 8-byte Folded Reload
	addq	32(%rsp), %rbp                  # 8-byte Folded Reload
	addq	-72(%rsp), %rbp                 # 8-byte Folded Reload
	addq	%r12, %r8
	addq	-112(%rsp), %r8                 # 8-byte Folded Reload
	addq	24(%rsp), %r8                   # 8-byte Folded Reload
	addq	%rdi, %rbx
	addq	40(%rsp), %rbx                  # 8-byte Folded Reload
	movq	48(%rsp), %rdi                  # 8-byte Reload
	addq	%rsi, %rdi
	movq	56(%rsp), %rsi                  # 8-byte Reload
	addq	-24(%rsp), %rsi                 # 8-byte Folded Reload
	addq	%rcx, %rdx
	addq	-88(%rsp), %rdx                 # 8-byte Folded Reload
	addq	-40(%rsp), %r10                 # 8-byte Folded Reload
	addq	72(%rsp), %r10                  # 8-byte Folded Reload
	addq	-80(%rsp), %r10                 # 8-byte Folded Reload
	addq	64(%rsp), %rax                  # 8-byte Folded Reload
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	addq	-120(%rsp), %rax                # 8-byte Folded Reload
	addq	%r10, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	addq	%rdi, %rax
	addq	%rbx, %rax
	addq	%r8, %rax
	addq	%rbp, %rax
	addq	%r13, %rax
	addq	%r11, %rax
	addq	$80, %rsp
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
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	64(%rsp), %r10d
	movl	56(%rsp), %r11d
	movl	%esi, %eax
	xorl	%edi, %eax
	movl	%eax, %ebx
	xorl	%edx, %ebx
	movl	%ebx, -84(%rsp)                 # 4-byte Spill
	movl	%edx, %r14d
	movl	%esi, -112(%rsp)                # 4-byte Spill
	xorl	%esi, %r14d
	xorl	%ecx, %r14d
	movl	%ecx, %r12d
	movl	%edx, -76(%rsp)                 # 4-byte Spill
	xorl	%edx, %r12d
	xorl	%r8d, %r12d
	movl	%r8d, %r15d
	movl	%ecx, -108(%rsp)                # 4-byte Spill
	xorl	%ecx, %r15d
	xorl	%r9d, %r15d
	movl	%r9d, %ecx
	movl	%r8d, -8(%rsp)                  # 4-byte Spill
	xorl	%r8d, %ecx
	xorl	%r11d, %ecx
	movl	%ecx, -96(%rsp)                 # 4-byte Spill
	movl	%r11d, %ecx
	movl	%r9d, -4(%rsp)                  # 4-byte Spill
	xorl	%r9d, %ecx
	xorl	%r10d, %ecx
	movl	%ecx, -104(%rsp)                # 4-byte Spill
	movl	%r10d, %edx
	xorl	%r11d, %edx
	movl	72(%rsp), %ecx
	xorl	%ecx, %edx
	movl	%edx, -92(%rsp)                 # 4-byte Spill
	movl	%ecx, %esi
	xorl	%r10d, %esi
	movl	80(%rsp), %edx
	xorl	%edx, %esi
	movl	%esi, -88(%rsp)                 # 4-byte Spill
	movl	%edx, %ebp
	xorl	%ecx, %ebp
	movl	88(%rsp), %ecx
	xorl	%ecx, %ebp
	movl	%ecx, %r9d
	xorl	%edx, %r9d
	movl	96(%rsp), %edx
	xorl	%edx, %r9d
	movl	%edx, %ebx
	xorl	%ecx, %ebx
	movl	104(%rsp), %ecx
	xorl	%ecx, %ebx
	movl	%ecx, %r13d
	xorl	%edx, %r13d
	movl	112(%rsp), %edx
	xorl	%edx, %r13d
	movl	%edx, %r8d
	xorl	%ecx, %r8d
	movl	120(%rsp), %r11d
	xorl	%r11d, %r8d
	movl	%r11d, %esi
	xorl	%edx, %esi
	movl	128(%rsp), %ecx
	xorl	%ecx, %esi
	movl	%ecx, %r10d
	movl	%edi, -116(%rsp)                # 4-byte Spill
	xorl	%edi, %r10d
	xorl	%r11d, %r10d
	xorl	%ecx, %eax
	movl	%eax, -80(%rsp)                 # 4-byte Spill
	movl	136(%rsp), %r11d
	cmpl	$1, %r11d
	je	.LBB1_3
# %bb.1:                                # %entry
	testl	%r11d, %r11d
	jne	.LBB1_4
# %bb.2:                                # %if.then
	movslq	%r12d, %rax
	movslq	%esi, %rdi
	movq	%rdi, %rsi
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	imulq	%rax, %rsi
	movslq	%r15d, %rax
	movslq	%r8d, %r8
	movq	%r8, %rcx
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	imulq	%rax, %rcx
	addq	%rsi, %rcx
	movslq	%r14d, %rax
	movslq	%r10d, %r10
	movq	%r10, %rdx
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	imulq	%rax, %rdx
	addq	%rdx, %rcx
	movslq	-96(%rsp), %rax                 # 4-byte Folded Reload
	movslq	%r13d, %rdx
	movq	%rdi, %r13
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	imulq	%rax, %rdx
	movslq	-104(%rsp), %rdi                # 4-byte Folded Reload
	movslq	%ebx, %r14
	movq	%r14, %rsi
	movq	%rdi, -104(%rsp)                # 8-byte Spill
	imulq	%rdi, %rsi
	addq	%rdx, %rsi
	movslq	-92(%rsp), %r12                 # 4-byte Folded Reload
	movslq	%r9d, %rdx
	movq	%r8, %r9
	movq	%rdx, -16(%rsp)                 # 8-byte Spill
	imulq	%r12, %rdx
	movslq	-88(%rsp), %r15                 # 4-byte Folded Reload
	movslq	%ebp, %r11
	movq	%r11, -32(%rsp)                 # 8-byte Spill
	imulq	%r15, %r11
	addq	%rdx, %r11
	addq	%rsi, %r11
	addq	%rcx, %r11
	movslq	-84(%rsp), %rbx                 # 4-byte Folded Reload
	movslq	-80(%rsp), %rsi                 # 4-byte Folded Reload
	movq	%rsi, %rcx
	imulq	%rbx, %rcx
	addq	%rcx, %r11
	movl	-112(%rsp), %ecx                # 4-byte Reload
	movl	-116(%rsp), %r8d                # 4-byte Reload
	imull	%r8d, %ecx
	movslq	%ecx, %rcx
	movq	%rcx, -72(%rsp)                 # 8-byte Spill
	movl	-108(%rsp), %ecx                # 4-byte Reload
	movl	-76(%rsp), %ebp                 # 4-byte Reload
	imull	%ebp, %ecx
	movslq	%ecx, %rcx
	movq	%rcx, -64(%rsp)                 # 8-byte Spill
	jmp	.LBB1_5
.LBB1_3:                                # %if.then62
	movslq	-84(%rsp), %rcx                 # 4-byte Folded Reload
	movslq	%r14d, %rdi
	movl	-112(%rsp), %edx                # 4-byte Reload
	imull	-116(%rsp), %edx                # 4-byte Folded Reload
	movslq	%edx, %rax
	movl	-108(%rsp), %edx                # 4-byte Reload
	movl	-76(%rsp), %r14d                # 4-byte Reload
	imull	%r14d, %edx
	movslq	%edx, %r11
	movq	%rax, -72(%rsp)                 # 8-byte Spill
	movq	%rcx, %rdx
	addq	%rcx, %rax
	movq	%rdi, -40(%rsp)                 # 8-byte Spill
	movq	%r11, -64(%rsp)                 # 8-byte Spill
	addq	%rdi, %r11
	addq	%rax, %r11
	movslq	%r12d, %rax
	movslq	%r15d, %rcx
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movq	%rcx, -56(%rsp)                 # 8-byte Spill
	addq	%rax, %rcx
	addq	%rcx, %r11
	movslq	-96(%rsp), %rax                 # 4-byte Folded Reload
	movslq	-104(%rsp), %rcx                # 4-byte Folded Reload
	movslq	-92(%rsp), %r12                 # 4-byte Folded Reload
	movslq	-88(%rsp), %r15                 # 4-byte Folded Reload
	addq	%rax, %r11
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	addq	%rcx, %r11
	addq	%r12, %r11
	addq	%r15, %r11
	movslq	%ebp, %rcx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movl	%r14d, %ebp
	movslq	%r9d, %rcx
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	movslq	%ebx, %r14
	movq	%rdx, %rbx
	movslq	%r13d, %rcx
	movq	%rcx, -24(%rsp)                 # 8-byte Spill
	movslq	%r8d, %r9
	movl	-116(%rsp), %r8d                # 4-byte Reload
	movslq	%esi, %r13
	movslq	%r10d, %r10
	movslq	-80(%rsp), %rsi                 # 4-byte Folded Reload
	jmp	.LBB1_5
.LBB1_4:                                # %if.else85
	movslq	%ebp, %r11
	movslq	%r9d, %rdi
	movslq	%ebx, %rdx
	movl	-112(%rsp), %r9d                # 4-byte Reload
	movl	-116(%rsp), %ecx                # 4-byte Reload
	imull	%ecx, %r9d
	movslq	%r9d, %rbx
	movl	-108(%rsp), %r9d                # 4-byte Reload
	movl	-76(%rsp), %ebp                 # 4-byte Reload
	imull	%ebp, %r9d
	movslq	%r9d, %rax
	movq	%rax, -64(%rsp)                 # 8-byte Spill
	movq	%rbx, -72(%rsp)                 # 8-byte Spill
	leaq	(%rax,%rbx), %r9
	movq	%r11, -32(%rsp)                 # 8-byte Spill
	addq	%r11, %r9
	movq	%rdi, -16(%rsp)                 # 8-byte Spill
	addq	%rdi, %r9
	addq	%rdx, %r9
	movslq	%r13d, %r11
	movslq	%r8d, %rdi
	movslq	%esi, %r13
	movq	%r11, -24(%rsp)                 # 8-byte Spill
	addq	%rdi, %r11
	addq	%r13, %r11
	addq	%r9, %r11
	movq	%rdi, %r9
	movslq	%r10d, %r10
	movslq	-80(%rsp), %rsi                 # 4-byte Folded Reload
	addq	%r10, %r11
	addq	%rsi, %r11
	movl	%ecx, %r8d
	movslq	-84(%rsp), %rbx                 # 4-byte Folded Reload
	movslq	%r14d, %rax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movq	%rdx, %r14
	movslq	%r12d, %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movslq	%r15d, %rax
	movq	%rax, -56(%rsp)                 # 8-byte Spill
	movslq	-96(%rsp), %rax                 # 4-byte Folded Reload
	movslq	-104(%rsp), %rcx                # 4-byte Folded Reload
	movq	%rcx, -104(%rsp)                # 8-byte Spill
	movslq	-92(%rsp), %r12                 # 4-byte Folded Reload
	movslq	-88(%rsp), %r15                 # 4-byte Folded Reload
.LBB1_5:                                # %if.end108
	movl	72(%rsp), %edi
	movslq	%r8d, %rcx
	movslq	-112(%rsp), %rdx                # 4-byte Folded Reload
	addq	%rcx, %rdx
	movslq	%ebp, %rcx
	addq	%rdx, %rcx
	movslq	-108(%rsp), %rdx                # 4-byte Folded Reload
	addq	%rcx, %rdx
	addq	-72(%rsp), %rdx                 # 8-byte Folded Reload
	movslq	-8(%rsp), %rcx                  # 4-byte Folded Reload
	addq	%rbx, %rcx
	addq	-40(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rdx, %rcx
	movslq	-4(%rsp), %rdx                  # 4-byte Folded Reload
	addq	-64(%rsp), %rdx                 # 8-byte Folded Reload
	addq	-48(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rcx, %rdx
	movslq	56(%rsp), %rcx
	addq	-56(%rsp), %rcx                 # 8-byte Folded Reload
	addq	%rdx, %rcx
	movslq	64(%rsp), %rdx
	addq	%rax, %rdx
	addq	%rcx, %rdx
	movslq	%edi, %rax
	addq	-104(%rsp), %rax                # 8-byte Folded Reload
	addq	%rdx, %rax
	movslq	80(%rsp), %rcx
	addq	%r12, %rcx
	movslq	88(%rsp), %rdx
	addq	%rcx, %rdx
	addq	%rax, %rdx
	movslq	96(%rsp), %rax
	addq	%r15, %rax
	addq	-32(%rsp), %rax                 # 8-byte Folded Reload
	movslq	104(%rsp), %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	movslq	112(%rsp), %rax
	addq	-16(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r14, %rax
	movslq	120(%rsp), %rdx
	addq	%rax, %rdx
	addq	-24(%rsp), %rdx                 # 8-byte Folded Reload
	addq	%rcx, %rdx
	movslq	128(%rsp), %rax
	addq	%r9, %rax
	addq	%r13, %rax
	addq	%r10, %rax
	addq	%rsi, %rax
	addq	%r11, %rax
	addq	%rdx, %rax
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

	.file	"benches.cpp"
	.text
	.p2align 4
	.globl	_Z9naive_sumPij
	.type	_Z9naive_sumPij, @function
_Z9naive_sumPij:
.LFB3284:
	.cfi_startproc
	endbr64
	movl	%esi, %eax
	testl	%esi, %esi
	je	.L4
	leaq	(%rdi,%rax,4), %rcx
	xorl	%eax, %eax
	.p2align 4
	.p2align 3
.L3:
	movslq	(%rdi), %rdx
	addq	$4, %rdi
	addq	%rdx, %rax
	cmpq	%rdi, %rcx
	jne	.L3
	ret
	.p2align 4
	.p2align 3
.L4:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE3284:
	.size	_Z9naive_sumPij, .-_Z9naive_sumPij
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB3286:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rsi, %rbx
	subq	$48, %rsp
	.cfi_def_cfa_offset 64
	movl	%edi, 12(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	movabsq	$8241989088176924002, %rax
	movw	$107, 38(%rsp)
	movq	%rax, 30(%rsp)
	leaq	30(%rsp), %rax
	movq	%rax, 16(%rsp)
	testq	%rsi, %rsi
	je	.L14
.L8:
	movq	_ZN9benchmark16PrintDefaultHelpEv@GOTPCREL(%rip), %rdx
	leaq	12(%rsp), %rdi
	movq	%rbx, %rsi
	call	_ZN9benchmark10InitializeEPiPPcPFvvE@PLT
	movl	12(%rsp), %edi
	movq	%rbx, %rsi
	call	_ZN9benchmark27ReportUnrecognizedArgumentsEiPPc@PLT
	movl	%eax, %edx
	movl	$1, %eax
	testb	%dl, %dl
	jne	.L7
	call	_ZN9benchmark22RunSpecifiedBenchmarksEv@PLT
	call	_ZN9benchmark8ShutdownEv@PLT
	xorl	%eax, %eax
.L7:
	movq	40(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L15
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L14:
	.cfi_restore_state
	movl	$1, 12(%rsp)
	leaq	16(%rsp), %rbx
	jmp	.L8
.L15:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE3286:
	.size	main, .-main
	.section	.rodata._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"basic_string: construction from null is not valid"
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_:
.LFB3603:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	16(%rdi), %r13
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movq	%r13, (%rdi)
	testq	%rsi, %rsi
	je	.L30
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	movq	%rsi, %r12
	call	strlen@PLT
	movq	%rax, %rbp
	movq	%rax, (%rsp)
	cmpq	$15, %rax
	ja	.L31
	cmpq	$1, %rax
	jne	.L21
	movzbl	(%r12), %edx
	movb	%dl, 16(%rbx)
.L22:
	movq	%rax, 8(%rbx)
	movb	$0, 0(%r13,%rax)
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L29
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4
	.p2align 3
.L21:
	.cfi_restore_state
	testq	%rax, %rax
	je	.L22
	jmp	.L20
	.p2align 4
	.p2align 3
.L31:
	movq	%rsp, %rsi
	xorl	%edx, %edx
	movq	%rbx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT
	movq	%rax, %r13
	movq	%rax, (%rbx)
	movq	(%rsp), %rax
	movq	%rax, 16(%rbx)
.L20:
	movq	%r13, %rdi
	movq	%rbp, %rdx
	movq	%r12, %rsi
	call	memcpy@PLT
	movq	(%rsp), %rax
	movq	(%rbx), %r13
	jmp	.L22
.L29:
	call	__stack_chk_fail@PLT
.L30:
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L29
	leaq	.LC0(%rip), %rdi
	call	_ZSt19__throw_logic_errorPKc@PLT
	.cfi_endproc
.LFE3603:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
	.set	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.section	.text._ZNSt6vectorIiSaIiEED2Ev,"axG",@progbits,_ZNSt6vectorIiSaIiEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEED2Ev
	.type	_ZNSt6vectorIiSaIiEED2Ev, @function
_ZNSt6vectorIiSaIiEED2Ev:
.LFB3687:
	.cfi_startproc
	endbr64
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L34
	movq	16(%rdi), %rsi
	movq	%rax, %rdi
	subq	%rax, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4
	.p2align 3
.L34:
	ret
	.cfi_endproc
.LFE3687:
	.size	_ZNSt6vectorIiSaIiEED2Ev, .-_ZNSt6vectorIiSaIiEED2Ev
	.weak	_ZNSt6vectorIiSaIiEED1Ev
	.set	_ZNSt6vectorIiSaIiEED1Ev,_ZNSt6vectorIiSaIiEED2Ev
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"int64_t benchmark::State::range(std::size_t) const"
	.align 8
.LC2:
	.string	"/usr/include/benchmark/benchmark.h"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"range_.size() > pos"
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"cannot create std::vector larger than max_size()"
	.align 8
.LC7:
	.string	"benchmark::State::StateIterator& benchmark::State::StateIterator::operator++()"
	.section	.rodata.str1.1
.LC8:
	.string	"cached_ > 0"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB10:
	.text
.LHOTB10:
	.p2align 4
	.type	_ZL8SumNaiveRN9benchmark5StateE, @function
_ZL8SumNaiveRN9benchmark5StateE:
.LFB3285:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3285
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	movq	32(%rdi), %rax
	cmpq	%rax, 40(%rdi)
	je	.L83
	movq	(%rax), %rax
	movq	%rax, %rcx
	shrq	$61, %rcx
	jne	.L84
	vpxor	%xmm0, %xmm0, %xmm0
	movq	%rdi, %rbx
	vmovdqu	%xmm0, 8(%rsp)
	testq	%rax, %rax
	je	.L85
	leaq	0(,%rax,4), %r12
	movq	%r12, %rdi
.LEHB0:
	call	_Znwm@PLT
.LEHE0:
	movq	%rax, %r13
	leaq	(%rax,%r12), %rcx
	movq	%rax, (%rsp)
	leaq	-4(%r12), %rax
	movq	%rcx, 16(%rsp)
	movq	%rax, %rsi
	shrq	$2, %rsi
	cmpq	$24, %rax
	movq	%r13, %rax
	leaq	1(%rsi), %r8
	jbe	.L56
	movq	%r8, %rdi
	movl	$1, %edx
	shrq	$3, %rdi
	vmovd	%edx, %xmm0
	salq	$5, %rdi
	vpbroadcastd	%xmm0, %ymm0
	leaq	(%rdi,%r13), %r9
	andl	$32, %edi
	je	.L42
	leaq	32(%r13), %rax
	vmovdqu	%ymm0, 0(%r13)
	cmpq	%r9, %rax
	je	.L77
	.p2align 4
	.p2align 3
.L42:
	vmovdqu	%ymm0, (%rax)
	vmovdqu	%ymm0, 32(%rax)
	addq	$64, %rax
	cmpq	%r9, %rax
	jne	.L42
.L77:
	movq	%r8, %rdx
	andq	$-8, %rdx
	andl	$7, %r8d
	leaq	0(%r13,%rdx,4), %rax
	je	.L86
	vzeroupper
.L41:
	subq	%rdx, %rsi
	leaq	1(%rsi), %rdi
	cmpq	$2, %rsi
	jbe	.L44
	movl	$1, %esi
	vmovd	%esi, %xmm0
	vpshufd	$0, %xmm0, %xmm0
	vmovdqu	%xmm0, 0(%r13,%rdx,4)
	movq	%rdi, %rdx
	andq	$-4, %rdx
	andl	$3, %edi
	leaq	(%rax,%rdx,4), %rax
	je	.L40
.L44:
	leaq	4(%rax), %rdx
	movl	$1, (%rax)
	cmpq	%rdx, %rcx
	je	.L40
	leaq	8(%rax), %rdx
	movl	$1, 4(%rax)
	cmpq	%rdx, %rcx
	je	.L40
	movl	$1, 8(%rax)
.L40:
	movl	28(%rbx), %eax
	movq	%rcx, 8(%rsp)
	testl	%eax, %eax
	je	.L46
	movq	%rbx, %rdi
.LEHB1:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L47:
	movq	%rbx, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	movq	(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L35
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L82
	movq	16(%rsp), %rsi
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	subq	%rdi, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4
	.p2align 3
.L46:
	.cfi_restore_state
	movq	%rbx, %rdi
	movq	16(%rbx), %r12
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE1:
	testq	%r12, %r12
	jne	.L48
	jmp	.L47
	.p2align 4
	.p2align 3
.L49:
	decq	%r12
	je	.L47
	movq	(%rsp), %r13
.L48:
	movq	(%rsp), %rdi
	movq	8(%rsp), %rsi
	subq	%rdi, %rsi
	sarq	$2, %rsi
	call	_Z9naive_sumPij
	testq	%r12, %r12
	jg	.L49
	leaq	.LC7(%rip), %rcx
	movl	$1046, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC8(%rip), %rdi
	call	__assert_fail@PLT
	.p2align 4
	.p2align 3
.L85:
	movq	$0, (%rsp)
	movq	$0, 16(%rsp)
	xorl	%r13d, %r13d
	xorl	%ecx, %ecx
	jmp	.L40
	.p2align 4
	.p2align 3
.L35:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L82
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L86:
	.cfi_restore_state
	vzeroupper
	jmp	.L40
.L56:
	xorl	%edx, %edx
	jmp	.L41
.L84:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L82
	leaq	.LC4(%rip), %rdi
.LEHB2:
	call	_ZSt20__throw_length_errorPKc@PLT
.LEHE2:
.L82:
	call	__stack_chk_fail@PLT
.L83:
	leaq	.LC1(%rip), %rcx
	movl	$907, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	__assert_fail@PLT
.L57:
	endbr64
	movq	%rax, %rbx
	jmp	.L53
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA3285:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3285-.LLSDACSB3285
.LLSDACSB3285:
	.uleb128 .LEHB0-.LFB3285
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB3285
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L57-.LFB3285
	.uleb128 0
	.uleb128 .LEHB2-.LFB3285
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSE3285:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC3285
	.type	_ZL8SumNaiveRN9benchmark5StateE.cold, @function
_ZL8SumNaiveRN9benchmark5StateE.cold:
.LFSB3285:
.L53:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -40
	.cfi_offset 6, -16
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	movq	%rsp, %rdi
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L87
	movq	%rbx, %rdi
.LEHB3:
	call	_Unwind_Resume@PLT
.LEHE3:
.L87:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE3285:
	.section	.gcc_except_table
.LLSDAC3285:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC3285-.LLSDACSBC3285
.LLSDACSBC3285:
	.uleb128 .LEHB3-.LCOLDB10
	.uleb128 .LEHE3-.LEHB3
	.uleb128 0
	.uleb128 0
.LLSDACSEC3285:
	.section	.text.unlikely
	.text
	.size	_ZL8SumNaiveRN9benchmark5StateE, .-_ZL8SumNaiveRN9benchmark5StateE
	.section	.text.unlikely
	.size	_ZL8SumNaiveRN9benchmark5StateE.cold, .-_ZL8SumNaiveRN9benchmark5StateE.cold
.LCOLDE10:
	.text
.LHOTE10:
	.section	.text.unlikely
.LCOLDB11:
	.text
.LHOTB11:
	.p2align 4
	.type	_ZL13SumAccumulateRN9benchmark5StateE, @function
_ZL13SumAccumulateRN9benchmark5StateE:
.LFB3280:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3280
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$32, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	movq	32(%rdi), %rax
	cmpq	%rax, 40(%rdi)
	je	.L143
	movq	(%rax), %rax
	movq	%rax, %rbx
	shrq	$61, %rbx
	jne	.L144
	vpxor	%xmm0, %xmm0, %xmm0
	movq	%rdi, %r12
	vmovdqu	%xmm0, 8(%rsp)
	testq	%rax, %rax
	je	.L145
	leaq	0(,%rax,4), %rbx
	movq	%rbx, %rdi
.LEHB4:
	call	_Znwm@PLT
.LEHE4:
	movq	%rax, %r13
	leaq	(%rax,%rbx), %rcx
	movq	%rax, (%rsp)
	leaq	-4(%rbx), %rax
	movq	%rcx, 16(%rsp)
	movq	%rax, %rsi
	shrq	$2, %rsi
	cmpq	$24, %rax
	movq	%r13, %rax
	leaq	1(%rsi), %r8
	jbe	.L113
	movq	%r8, %rdi
	movl	$1, %edx
	shrq	$3, %rdi
	vmovd	%edx, %xmm0
	salq	$5, %rdi
	vpbroadcastd	%xmm0, %ymm0
	leaq	(%rdi,%r13), %r9
	andl	$32, %edi
	je	.L95
	leaq	32(%r13), %rax
	vmovdqu	%ymm0, 0(%r13)
	cmpq	%rax, %r9
	je	.L136
	.p2align 4
	.p2align 3
.L95:
	vmovdqu	%ymm0, (%rax)
	vmovdqu	%ymm0, 32(%rax)
	addq	$64, %rax
	cmpq	%rax, %r9
	jne	.L95
.L136:
	movq	%r8, %rdx
	andq	$-8, %rdx
	andl	$7, %r8d
	leaq	0(%r13,%rdx,4), %rax
	je	.L146
	vzeroupper
.L94:
	subq	%rdx, %rsi
	leaq	1(%rsi), %rdi
	cmpq	$2, %rsi
	jbe	.L97
	movl	$1, %ebx
	vmovd	%ebx, %xmm0
	vpshufd	$0, %xmm0, %xmm0
	vmovdqu	%xmm0, 0(%r13,%rdx,4)
	movq	%rdi, %rdx
	andq	$-4, %rdx
	andl	$3, %edi
	leaq	(%rax,%rdx,4), %rax
	je	.L93
.L97:
	leaq	4(%rax), %rdx
	movl	$1, (%rax)
	cmpq	%rdx, %rcx
	je	.L93
	leaq	8(%rax), %rdx
	movl	$1, 4(%rax)
	cmpq	%rdx, %rcx
	je	.L93
	movl	$1, 8(%rax)
.L93:
	movl	28(%r12), %eax
	movq	%rcx, 8(%rsp)
	testl	%eax, %eax
	je	.L99
	movq	%r12, %rdi
.LEHB5:
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.L100:
	movq	%r12, %rdi
	call	_ZN9benchmark5State17FinishKeepRunningEv@PLT
	movq	(%rsp), %rdi
	testq	%rdi, %rdi
	je	.L88
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L142
	movq	16(%rsp), %rsi
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	subq	%rdi, %rsi
	jmp	_ZdlPvm@PLT
.L99:
	.cfi_restore_state
	movq	%r12, %rdi
	movq	16(%r12), %rbx
	call	_ZN9benchmark5State16StartKeepRunningEv@PLT
.LEHE5:
	testq	%rbx, %rbx
	je	.L100
	.p2align 4
	.p2align 3
.L101:
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdx
	xorl	%eax, %eax
	cmpq	%rsi, %rdx
	je	.L107
	leaq	-4(%rsi), %rcx
	movq	%rdx, %rax
	subq	%rdx, %rcx
	movq	%rcx, %rdi
	shrq	$2, %rdi
	incq	%rdi
	cmpq	$24, %rcx
	jbe	.L114
	movq	%rdi, %rcx
	vpxor	%xmm1, %xmm1, %xmm1
	shrq	$3, %rcx
	salq	$5, %rcx
	addq	%rdx, %rcx
	.p2align 4
	.p2align 3
.L103:
	vpaddd	(%rax), %ymm1, %ymm1
	addq	$32, %rax
	cmpq	%rcx, %rax
	jne	.L103
	vmovdqa	%xmm1, %xmm0
	vextracti128	$0x1, %ymm1, %xmm1
	movq	%rdi, %rcx
	vpaddd	%xmm1, %xmm0, %xmm0
	andq	$-8, %rcx
	andl	$7, %edi
	vpsrldq	$8, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	leaq	(%rdx,%rcx,4), %rdx
	vpsrldq	$4, %xmm0, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vmovd	%xmm0, %eax
	je	.L107
.L102:
	leaq	4(%rdx), %rcx
	addl	(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	leaq	8(%rdx), %rcx
	addl	4(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	leaq	12(%rdx), %rcx
	addl	8(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	leaq	16(%rdx), %rcx
	addl	12(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	leaq	20(%rdx), %rcx
	addl	16(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	leaq	24(%rdx), %rcx
	addl	20(%rdx), %eax
	cmpq	%rcx, %rsi
	je	.L107
	addl	24(%rdx), %eax
.L107:
	testq	%rbx, %rbx
	jle	.L147
	decq	%rbx
	je	.L138
	movq	(%rsp), %r13
	jmp	.L101
	.p2align 4
	.p2align 3
.L138:
	vzeroupper
	jmp	.L100
.L114:
	xorl	%eax, %eax
	jmp	.L102
.L145:
	movq	$0, (%rsp)
	movq	$0, 16(%rsp)
	xorl	%r13d, %r13d
	xorl	%ecx, %ecx
	jmp	.L93
.L88:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L142
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L146:
	.cfi_restore_state
	vzeroupper
	jmp	.L93
.L113:
	xorl	%edx, %edx
	jmp	.L94
.L147:
	leaq	.LC7(%rip), %rcx
	movl	$1046, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC8(%rip), %rdi
	vzeroupper
	call	__assert_fail@PLT
.L144:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L142
	leaq	.LC4(%rip), %rdi
.LEHB6:
	call	_ZSt20__throw_length_errorPKc@PLT
.LEHE6:
.L142:
	call	__stack_chk_fail@PLT
.L143:
	leaq	.LC1(%rip), %rcx
	movl	$907, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	__assert_fail@PLT
.L115:
	endbr64
	movq	%rax, %rbx
	jmp	.L110
	.section	.gcc_except_table
.LLSDA3280:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3280-.LLSDACSB3280
.LLSDACSB3280:
	.uleb128 .LEHB4-.LFB3280
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB3280
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L115-.LFB3280
	.uleb128 0
	.uleb128 .LEHB6-.LFB3280
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE3280:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC3280
	.type	_ZL13SumAccumulateRN9benchmark5StateE.cold, @function
_ZL13SumAccumulateRN9benchmark5StateE.cold:
.LFSB3280:
.L110:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -40
	.cfi_offset 6, -16
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	movq	%rsp, %rdi
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L148
	movq	%rbx, %rdi
.LEHB7:
	call	_Unwind_Resume@PLT
.LEHE7:
.L148:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE3280:
	.section	.gcc_except_table
.LLSDAC3280:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC3280-.LLSDACSBC3280
.LLSDACSBC3280:
	.uleb128 .LEHB7-.LCOLDB11
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSEC3280:
	.section	.text.unlikely
	.text
	.size	_ZL13SumAccumulateRN9benchmark5StateE, .-_ZL13SumAccumulateRN9benchmark5StateE
	.section	.text.unlikely
	.size	_ZL13SumAccumulateRN9benchmark5StateE.cold, .-_ZL13SumAccumulateRN9benchmark5StateE.cold
.LCOLDE11:
	.text
.LHOTE11:
	.section	.rodata.str1.1
.LC12:
	.string	"SumAccumulate"
.LC13:
	.string	"SumNaive"
	.section	.text.unlikely
.LCOLDB14:
	.section	.text.startup
.LHOTB14:
	.p2align 4
	.type	_GLOBAL__sub_I__Z9naive_sumPij, @function
_GLOBAL__sub_I__Z9naive_sumPij:
.LFB4331:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4331
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	leaq	15(%rsp), %r13
.LEHB8:
	call	_ZN9benchmark8internal17InitializeStreamsEv@PLT
	leaq	16(%rsp), %rbx
	movl	$232, %edi
	call	_Znwm@PLT
.LEHE8:
	movq	%r13, %rdx
	leaq	.LC12(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rbp
.LEHB9:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
.LEHE9:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
.LEHB10:
	call	_ZN9benchmark8internal9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE10:
	leaq	16+_ZTVN9benchmark8internal17FunctionBenchmarkE(%rip), %r12
	leaq	_ZL13SumAccumulateRN9benchmark5StateE(%rip), %rax
	movq	%rbp, %rdi
	movq	%r12, 0(%rbp)
	movq	%rax, 224(%rbp)
.LEHB11:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalEPNS0_9BenchmarkE@PLT
.LEHE11:
	movq	%rax, %rdi
	movl	$1024, %esi
.LEHB12:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE12:
	movq	%rax, %rdi
	movl	$1048576, %esi
.LEHB13:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE13:
	movq	%rax, %rdi
	movl	$16777216, %esi
.LEHB14:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE14:
	movq	%rbx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	movl	$232, %edi
.LEHB15:
	call	_Znwm@PLT
.LEHE15:
	movq	%r13, %rdx
	leaq	.LC13(%rip), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rbp
.LEHB16:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
.LEHE16:
	movq	%rbx, %rsi
	movq	%rbp, %rdi
.LEHB17:
	call	_ZN9benchmark8internal9BenchmarkC2ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT
.LEHE17:
	leaq	_ZL8SumNaiveRN9benchmark5StateE(%rip), %rax
	movq	%r12, 0(%rbp)
	movq	%rbp, %rdi
	movq	%rax, 224(%rbp)
.LEHB18:
	call	_ZN9benchmark8internal25RegisterBenchmarkInternalEPNS0_9BenchmarkE@PLT
.LEHE18:
	movq	%rax, %rdi
	movl	$1024, %esi
.LEHB19:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE19:
	movq	%rax, %rdi
	movl	$1048576, %esi
.LEHB20:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE20:
	movq	%rax, %rdi
	movl	$16777216, %esi
.LEHB21:
	call	_ZN9benchmark8internal9Benchmark3ArgEl@PLT
.LEHE21:
	movq	%rbx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L204
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L204:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
.L188:
	endbr64
	movq	%rax, %r12
	jmp	.L167
.L180:
	endbr64
	movq	%rax, %r12
	jmp	.L167
.L186:
	endbr64
	movq	%rax, %r12
	jmp	.L167
.L187:
	endbr64
	movq	%rax, %r12
	jmp	.L167
.L185:
	endbr64
	movq	%rax, %r12
	jmp	.L172
.L179:
	endbr64
	movq	%rax, %r12
	vzeroupper
	jmp	.L174
.L182:
	endbr64
	movq	%rax, %r12
	jmp	.L158
.L183:
	endbr64
	movq	%rax, %r12
	jmp	.L158
.L181:
	endbr64
	movq	%rax, %r12
	jmp	.L168
.L177:
	endbr64
	movq	%rax, %r12
	vzeroupper
	jmp	.L170
.L184:
	endbr64
	movq	%rax, %r12
	jmp	.L158
.L178:
	endbr64
	movq	%rax, %r12
	jmp	.L158
	.section	.gcc_except_table
.LLSDA4331:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4331-.LLSDACSB4331
.LLSDACSB4331:
	.uleb128 .LEHB8-.LFB4331
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB9-.LFB4331
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L177-.LFB4331
	.uleb128 0
	.uleb128 .LEHB10-.LFB4331
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L181-.LFB4331
	.uleb128 0
	.uleb128 .LEHB11-.LFB4331
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L183-.LFB4331
	.uleb128 0
	.uleb128 .LEHB12-.LFB4331
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L182-.LFB4331
	.uleb128 0
	.uleb128 .LEHB13-.LFB4331
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L178-.LFB4331
	.uleb128 0
	.uleb128 .LEHB14-.LFB4331
	.uleb128 .LEHE14-.LEHB14
	.uleb128 .L184-.LFB4331
	.uleb128 0
	.uleb128 .LEHB15-.LFB4331
	.uleb128 .LEHE15-.LEHB15
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB16-.LFB4331
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L179-.LFB4331
	.uleb128 0
	.uleb128 .LEHB17-.LFB4331
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L185-.LFB4331
	.uleb128 0
	.uleb128 .LEHB18-.LFB4331
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L187-.LFB4331
	.uleb128 0
	.uleb128 .LEHB19-.LFB4331
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L186-.LFB4331
	.uleb128 0
	.uleb128 .LEHB20-.LFB4331
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L180-.LFB4331
	.uleb128 0
	.uleb128 .LEHB21-.LFB4331
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L188-.LFB4331
	.uleb128 0
.LLSDACSE4331:
	.section	.text.startup
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC4331
	.type	_GLOBAL__sub_I__Z9naive_sumPij.cold, @function
_GLOBAL__sub_I__Z9naive_sumPij.cold:
.LFSB4331:
.L167:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	xorl	%r13d, %r13d
.L161:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	testb	%r13b, %r13b
	je	.L173
.L174:
	movl	$232, %esi
	movq	%rbp, %rdi
	call	_ZdlPvm@PLT
.L173:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L205
	movq	%r12, %rdi
.LEHB22:
	call	_Unwind_Resume@PLT
.L172:
	movl	$1, %r13d
	jmp	.L161
.L158:
	xorl	%r13d, %r13d
.L152:
	movq	%rbx, %rdi
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
	testb	%r13b, %r13b
	je	.L169
.L170:
	movl	$232, %esi
	movq	%rbp, %rdi
	call	_ZdlPvm@PLT
.L169:
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L206
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.LEHE22:
.L168:
	movl	$1, %r13d
	jmp	.L152
.L205:
	call	__stack_chk_fail@PLT
.L206:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE4331:
	.section	.gcc_except_table
.LLSDAC4331:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC4331-.LLSDACSBC4331
.LLSDACSBC4331:
	.uleb128 .LEHB22-.LCOLDB14
	.uleb128 .LEHE22-.LEHB22
	.uleb128 0
	.uleb128 0
.LLSDACSEC4331:
	.section	.text.unlikely
	.section	.text.startup
	.size	_GLOBAL__sub_I__Z9naive_sumPij, .-_GLOBAL__sub_I__Z9naive_sumPij
	.section	.text.unlikely
	.size	_GLOBAL__sub_I__Z9naive_sumPij.cold, .-_GLOBAL__sub_I__Z9naive_sumPij.cold
.LCOLDE14:
	.section	.text.startup
.LHOTE14:
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__Z9naive_sumPij
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

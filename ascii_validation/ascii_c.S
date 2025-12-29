	.file	"ascii_c.c"
	.text
	.p2align 4
	.globl	validate_ascii_c
	.type	validate_ascii_c, @function
validate_ascii_c:
	endbr64
	pushq	%rbx
	subq	$96, %rsp
	movq	%rdi, 8(%rsp)
	leaq	16(%rsp), %rdx
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	movq	Caml_state(%rip), %rax
	movq	$1, 32(%rsp)
	movq	$1, 24(%rsp)
	movq	288(%rax), %rbx
	movq	%rdx, 288(%rax)
	leaq	8(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	%rbx, 16(%rsp)
	call	caml_string_length@PLT
	testl	%eax, %eax
	jle	.L2
	leal	-1(%rax), %edx
	movq	8(%rsp), %rax
	leaq	1(%rax,%rdx), %rdx
	jmp	.L5
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L3:
	addq	$1, %rax
	cmpq	%rdx, %rax
	je	.L2
.L5:
	cmpb	$0, (%rax)
	jns	.L3
	movq	Caml_state(%rip), %rax
	movq	%rbx, 288(%rax)
	movl	$1, %eax
	jmp	.L1
	.p2align 4,,10
	.p2align 3
.L2:
	movq	Caml_state(%rip), %rax
	movq	%rbx, 288(%rax)
	movl	$3, %eax
.L1:
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L10
	addq	$96, %rsp
	popq	%rbx
	ret
.L10:
	call	__stack_chk_fail@PLT
	.size	validate_ascii_c, .-validate_ascii_c
	.ident	"GCC: (Ubuntu 15.2.0-4ubuntu4) 15.2.0"
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

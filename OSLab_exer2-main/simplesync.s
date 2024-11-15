	.file	"simplesync.c"
	.text
.Ltext0:
	.file 0 "/home/ebilias/Desktop/Classes/Operation Systems/Exer2/OSLab_exer2" "simplesync.c"
	.globl	mutex
	.bss
	.align 32
	.type	mutex, @object
	.size	mutex, 40
mutex:
	.zero	40
	.section	.rodata
	.align 8
.LC0:
	.string	"About to increase variable %d times\n"
.LC1:
	.string	"Done increasing variable.\n"
	.text
	.globl	increase_fn
	.type	increase_fn, @function
increase_fn:
.LFB6:
	.file 1 "simplesync.c"
	.loc 1 41 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 43 16
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 44 2
	movl	$0, %esi
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_init@PLT
	.loc 1 46 2
	movq	stderr(%rip), %rax
	movl	$10000000, %edx
	leaq	.LC0(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	.loc 1 47 9
	movl	$0, -12(%rbp)
	.loc 1 47 2
	jmp	.L2
.L3:
	.loc 1 55 4
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_lock@PLT
	.loc 1 57 7
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 57 4
	leal	1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 59 4
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 47 22 discriminator 2
	addl	$1, -12(%rbp)
.L2:
	.loc 1 47 16 discriminator 1
	cmpl	$9999999, -12(%rbp)
	jle	.L3
	.loc 1 62 2
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	.loc 1 64 9
	movl	$0, %eax
	.loc 1 65 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	increase_fn, .-increase_fn
	.section	.rodata
	.align 8
.LC2:
	.string	"About to decrease variable %d times\n"
.LC3:
	.string	"Done decreasing variable.\n"
	.text
	.globl	decrease_fn
	.type	decrease_fn, @function
decrease_fn:
.LFB7:
	.loc 1 68 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 70 16
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 72 2
	movq	stderr(%rip), %rax
	movl	$10000000, %edx
	leaq	.LC2(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	.loc 1 73 9
	movl	$0, -12(%rbp)
	.loc 1 73 2
	jmp	.L6
.L7:
	.loc 1 81 4
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_lock@PLT
	.loc 1 83 7
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 83 4
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	.loc 1 85 4
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 73 22 discriminator 2
	addl	$1, -12(%rbp)
.L6:
	.loc 1 73 16 discriminator 1
	cmpl	$9999999, -12(%rbp)
	jle	.L7
	.loc 1 88 2
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	.loc 1 90 9
	movl	$0, %eax
	.loc 1 91 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	decrease_fn, .-decrease_fn
	.section	.rodata
.LC4:
	.string	"pthread_create"
.LC5:
	.string	"pthread_join"
.LC6:
	.string	""
.LC7:
	.string	"NOT "
.LC8:
	.string	"%sOK, val = %d.\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.loc 1 95 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	.loc 1 95 1
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 102 6
	movl	$0, -36(%rbp)
	.loc 1 107 8
	leaq	-36(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %rcx
	leaq	increase_fn(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movl	%eax, -32(%rbp)
	.loc 1 108 5
	cmpl	$0, -32(%rbp)
	je	.L10
	.loc 1 109 3
	call	__errno_location@PLT
	.loc 1 109 3 is_stmt 0 discriminator 1
	movl	-32(%rbp), %edx
	movl	%edx, (%rax)
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	.loc 1 110 3 is_stmt 1
	movl	$1, %edi
	call	exit@PLT
.L10:
	.loc 1 112 8
	leaq	-36(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rcx
	leaq	decrease_fn(%rip), %rdx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create@PLT
	movl	%eax, -32(%rbp)
	.loc 1 113 5
	cmpl	$0, -32(%rbp)
	je	.L11
	.loc 1 114 3
	call	__errno_location@PLT
	.loc 1 114 3 is_stmt 0 discriminator 1
	movl	-32(%rbp), %edx
	movl	%edx, (%rax)
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	.loc 1 115 3 is_stmt 1
	movl	$1, %edi
	call	exit@PLT
.L11:
	.loc 1 121 8
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movl	%eax, -32(%rbp)
	.loc 1 122 5
	cmpl	$0, -32(%rbp)
	je	.L12
	.loc 1 123 3
	call	__errno_location@PLT
	.loc 1 123 3 is_stmt 0 discriminator 1
	movl	-32(%rbp), %edx
	movl	%edx, (%rax)
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L12:
	.loc 1 124 8 is_stmt 1
	movq	-16(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join@PLT
	movl	%eax, -32(%rbp)
	.loc 1 125 5
	cmpl	$0, -32(%rbp)
	je	.L13
	.loc 1 126 3
	call	__errno_location@PLT
	.loc 1 126 3 is_stmt 0 discriminator 1
	movl	-32(%rbp), %edx
	movl	%edx, (%rax)
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
.L13:
	.loc 1 129 2 is_stmt 1
	leaq	mutex(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_destroy@PLT
	.loc 1 134 12
	movl	-36(%rbp), %eax
	testl	%eax, %eax
	sete	%al
	.loc 1 134 5
	movzbl	%al, %eax
	movl	%eax, -28(%rbp)
	.loc 1 136 2
	movl	-36(%rbp), %edx
	cmpl	$0, -28(%rbp)
	je	.L14
	.loc 1 136 2 is_stmt 0 discriminator 1
	leaq	.LC6(%rip), %rax
	jmp	.L15
.L14:
	.loc 1 136 2 discriminator 2
	leaq	.LC7(%rip), %rax
.L15:
	.loc 1 136 2 discriminator 4
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	.loc 1 138 9 is_stmt 1
	movl	-28(%rbp), %eax
	.loc 1 139 1
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L17
	call	__stack_chk_fail@PLT
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/13/include/stddef.h"
	.file 3 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 4 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 6 "/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/struct_mutex.h"
	.file 8 "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h"
	.file 9 "/usr/include/stdio.h"
	.file 10 "/usr/include/pthread.h"
	.file 11 "/usr/include/stdlib.h"
	.file 12 "/usr/include/errno.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x6a3
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x15
	.long	.LASF84
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x5
	.long	.LASF9
	.byte	0x2
	.byte	0xd6
	.byte	0x17
	.long	0x3a
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x16
	.byte	0x8
	.uleb128 0x9
	.long	0x48
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x17
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x18
	.long	0x6b
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x5
	.long	.LASF10
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x77
	.uleb128 0x5
	.long	.LASF11
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x77
	.uleb128 0x2
	.long	0x9b
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0xc
	.long	0x9b
	.uleb128 0xa
	.long	0x9b
	.long	0xb7
	.uleb128 0xb
	.long	0x3a
	.byte	0x3
	.byte	0
	.uleb128 0xd
	.long	.LASF48
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.long	0x23e
	.uleb128 0x1
	.long	.LASF13
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x6b
	.byte	0
	.uleb128 0x1
	.long	.LASF14
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x96
	.byte	0x8
	.uleb128 0x1
	.long	.LASF15
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x96
	.byte	0x10
	.uleb128 0x1
	.long	.LASF16
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x96
	.byte	0x18
	.uleb128 0x1
	.long	.LASF17
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x96
	.byte	0x20
	.uleb128 0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x96
	.byte	0x28
	.uleb128 0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x96
	.byte	0x30
	.uleb128 0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x96
	.byte	0x38
	.uleb128 0x1
	.long	.LASF21
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x96
	.byte	0x40
	.uleb128 0x1
	.long	.LASF22
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x96
	.byte	0x48
	.uleb128 0x1
	.long	.LASF23
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x96
	.byte	0x50
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x96
	.byte	0x58
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x257
	.byte	0x60
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x25c
	.byte	0x68
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x6b
	.byte	0x70
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x6b
	.byte	0x74
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x7e
	.byte	0x78
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x56
	.byte	0x80
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x5d
	.byte	0x82
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x261
	.byte	0x83
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x271
	.byte	0x88
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x8a
	.byte	0x90
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x27b
	.byte	0x98
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x285
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x25c
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x48
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2e
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x6b
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x28a
	.byte	0xc4
	.byte	0
	.uleb128 0x5
	.long	.LASF42
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xb7
	.uleb128 0x19
	.long	.LASF85
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xe
	.long	.LASF43
	.uleb128 0x2
	.long	0x252
	.uleb128 0x2
	.long	0xb7
	.uleb128 0xa
	.long	0x9b
	.long	0x271
	.uleb128 0xb
	.long	0x3a
	.byte	0
	.byte	0
	.uleb128 0x2
	.long	0x24a
	.uleb128 0xe
	.long	.LASF44
	.uleb128 0x2
	.long	0x276
	.uleb128 0xe
	.long	.LASF45
	.uleb128 0x2
	.long	0x280
	.uleb128 0xa
	.long	0x9b
	.long	0x29a
	.uleb128 0xb
	.long	0x3a
	.byte	0x13
	.byte	0
	.uleb128 0x2
	.long	0xa2
	.uleb128 0x9
	.long	0x29a
	.uleb128 0x2
	.long	0x23e
	.uleb128 0x9
	.long	0x2a4
	.uleb128 0x1a
	.long	.LASF69
	.byte	0x9
	.byte	0x97
	.byte	0xe
	.long	0x2a4
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF46
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF47
	.uleb128 0xd
	.long	.LASF49
	.byte	0x10
	.byte	0x6
	.byte	0x33
	.byte	0x10
	.long	0x2f0
	.uleb128 0x1
	.long	.LASF50
	.byte	0x6
	.byte	0x35
	.byte	0x23
	.long	0x2f0
	.byte	0
	.uleb128 0x1
	.long	.LASF51
	.byte	0x6
	.byte	0x36
	.byte	0x23
	.long	0x2f0
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.long	0x2c8
	.uleb128 0x5
	.long	.LASF52
	.byte	0x6
	.byte	0x37
	.byte	0x3
	.long	0x2c8
	.uleb128 0xd
	.long	.LASF53
	.byte	0x28
	.byte	0x7
	.byte	0x16
	.byte	0x8
	.long	0x377
	.uleb128 0x1
	.long	.LASF54
	.byte	0x7
	.byte	0x18
	.byte	0x7
	.long	0x6b
	.byte	0
	.uleb128 0x1
	.long	.LASF55
	.byte	0x7
	.byte	0x19
	.byte	0x10
	.long	0x41
	.byte	0x4
	.uleb128 0x1
	.long	.LASF56
	.byte	0x7
	.byte	0x1a
	.byte	0x7
	.long	0x6b
	.byte	0x8
	.uleb128 0x1
	.long	.LASF57
	.byte	0x7
	.byte	0x1c
	.byte	0x10
	.long	0x41
	.byte	0xc
	.uleb128 0x1
	.long	.LASF58
	.byte	0x7
	.byte	0x20
	.byte	0x7
	.long	0x6b
	.byte	0x10
	.uleb128 0x1
	.long	.LASF59
	.byte	0x7
	.byte	0x22
	.byte	0x9
	.long	0x64
	.byte	0x14
	.uleb128 0x1
	.long	.LASF60
	.byte	0x7
	.byte	0x23
	.byte	0x9
	.long	0x64
	.byte	0x16
	.uleb128 0x1
	.long	.LASF61
	.byte	0x7
	.byte	0x24
	.byte	0x14
	.long	0x2f5
	.byte	0x18
	.byte	0
	.uleb128 0x5
	.long	.LASF62
	.byte	0x8
	.byte	0x1b
	.byte	0x1b
	.long	0x3a
	.uleb128 0xf
	.byte	0x4
	.byte	0x20
	.long	0x3a1
	.uleb128 0x7
	.long	.LASF63
	.byte	0x22
	.byte	0x8
	.long	0xa7
	.uleb128 0x7
	.long	.LASF64
	.byte	0x23
	.byte	0x7
	.long	0x6b
	.byte	0
	.uleb128 0x5
	.long	.LASF65
	.byte	0x8
	.byte	0x24
	.byte	0x3
	.long	0x383
	.uleb128 0xc
	.long	0x3a1
	.uleb128 0x1b
	.long	.LASF66
	.byte	0x38
	.byte	0x8
	.byte	0x38
	.byte	0x7
	.long	0x3d6
	.uleb128 0x7
	.long	.LASF63
	.byte	0x3a
	.byte	0x8
	.long	0x3d6
	.uleb128 0x7
	.long	.LASF64
	.byte	0x3b
	.byte	0xc
	.long	0x77
	.byte	0
	.uleb128 0xa
	.long	0x9b
	.long	0x3e6
	.uleb128 0xb
	.long	0x3a
	.byte	0x37
	.byte	0
	.uleb128 0x5
	.long	.LASF66
	.byte	0x8
	.byte	0x3e
	.byte	0x1e
	.long	0x3b2
	.uleb128 0xc
	.long	0x3e6
	.uleb128 0xf
	.byte	0x28
	.byte	0x43
	.long	0x420
	.uleb128 0x7
	.long	.LASF67
	.byte	0x45
	.byte	0x1c
	.long	0x301
	.uleb128 0x7
	.long	.LASF63
	.byte	0x46
	.byte	0x8
	.long	0x420
	.uleb128 0x7
	.long	.LASF64
	.byte	0x47
	.byte	0xc
	.long	0x77
	.byte	0
	.uleb128 0xa
	.long	0x9b
	.long	0x430
	.uleb128 0xb
	.long	0x3a
	.byte	0x27
	.byte	0
	.uleb128 0x5
	.long	.LASF68
	.byte	0x8
	.byte	0x48
	.byte	0x3
	.long	0x3f7
	.uleb128 0x2
	.long	0x96
	.uleb128 0x1c
	.long	.LASF70
	.byte	0x1
	.byte	0x1d
	.byte	0x11
	.long	0x430
	.uleb128 0x9
	.byte	0x3
	.quad	mutex
	.uleb128 0x8
	.long	.LASF71
	.byte	0x9
	.value	0x16b
	.long	0x6b
	.long	0x46e
	.uleb128 0x3
	.long	0x29a
	.uleb128 0x10
	.byte	0
	.uleb128 0x8
	.long	.LASF72
	.byte	0xa
	.value	0x312
	.long	0x6b
	.long	0x484
	.uleb128 0x3
	.long	0x484
	.byte	0
	.uleb128 0x2
	.long	0x430
	.uleb128 0x11
	.long	.LASF73
	.byte	0xdb
	.long	0x6b
	.long	0x4a2
	.uleb128 0x3
	.long	0x377
	.uleb128 0x3
	.long	0x4a2
	.byte	0
	.uleb128 0x2
	.long	0x48
	.uleb128 0x1d
	.long	.LASF74
	.byte	0xb
	.value	0x2f4
	.byte	0xd
	.long	0x4ba
	.uleb128 0x3
	.long	0x6b
	.byte	0
	.uleb128 0x1e
	.long	.LASF86
	.byte	0x9
	.value	0x36e
	.byte	0xd
	.long	0x4cd
	.uleb128 0x3
	.long	0x29a
	.byte	0
	.uleb128 0x1f
	.long	.LASF87
	.byte	0xc
	.byte	0x25
	.byte	0xd
	.long	0x4d9
	.uleb128 0x2
	.long	0x6b
	.uleb128 0x11
	.long	.LASF75
	.byte	0xca
	.long	0x6b
	.long	0x501
	.uleb128 0x3
	.long	0x506
	.uleb128 0x3
	.long	0x510
	.uleb128 0x3
	.long	0x515
	.uleb128 0x3
	.long	0x4a
	.byte	0
	.uleb128 0x2
	.long	0x377
	.uleb128 0x9
	.long	0x501
	.uleb128 0x2
	.long	0x3f2
	.uleb128 0x9
	.long	0x50b
	.uleb128 0x2
	.long	0x51a
	.uleb128 0x20
	.long	0x48
	.long	0x529
	.uleb128 0x3
	.long	0x48
	.byte	0
	.uleb128 0x8
	.long	.LASF76
	.byte	0xa
	.value	0x343
	.long	0x6b
	.long	0x53f
	.uleb128 0x3
	.long	0x484
	.byte	0
	.uleb128 0x8
	.long	.LASF77
	.byte	0xa
	.value	0x31a
	.long	0x6b
	.long	0x555
	.uleb128 0x3
	.long	0x484
	.byte	0
	.uleb128 0x8
	.long	.LASF78
	.byte	0x9
	.value	0x165
	.long	0x6b
	.long	0x571
	.uleb128 0x3
	.long	0x2a9
	.uleb128 0x3
	.long	0x29f
	.uleb128 0x10
	.byte	0
	.uleb128 0x8
	.long	.LASF79
	.byte	0xa
	.value	0x30d
	.long	0x6b
	.long	0x58c
	.uleb128 0x3
	.long	0x484
	.uleb128 0x3
	.long	0x58c
	.byte	0
	.uleb128 0x2
	.long	0x3ad
	.uleb128 0x12
	.long	.LASF82
	.byte	0x5e
	.byte	0x5
	.long	0x6b
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x614
	.uleb128 0x13
	.long	.LASF80
	.byte	0x5e
	.byte	0xe
	.long	0x6b
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x13
	.long	.LASF81
	.byte	0x5e
	.byte	0x1a
	.long	0x43c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x6
	.string	"val"
	.byte	0x60
	.byte	0x6
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x6
	.string	"ret"
	.byte	0x60
	.byte	0xb
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x6
	.string	"ok"
	.byte	0x60
	.byte	0x10
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.uleb128 0x6
	.string	"t1"
	.byte	0x61
	.byte	0xc
	.long	0x377
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x6
	.string	"t2"
	.byte	0x61
	.byte	0x10
	.long	0x377
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x12
	.long	.LASF83
	.byte	0x43
	.byte	0x7
	.long	0x48
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x65c
	.uleb128 0x14
	.string	"arg"
	.byte	0x43
	.long	0x48
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x6
	.string	"i"
	.byte	0x45
	.byte	0x6
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x6
	.string	"ip"
	.byte	0x46
	.byte	0x10
	.long	0x65c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x2
	.long	0x72
	.uleb128 0x21
	.long	.LASF88
	.byte	0x1
	.byte	0x28
	.byte	0x7
	.long	0x48
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x14
	.string	"arg"
	.byte	0x28
	.long	0x48
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x6
	.string	"i"
	.byte	0x2a
	.byte	0x6
	.long	0x6b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x6
	.string	"ip"
	.byte	0x2b
	.byte	0x10
	.long	0x65c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 10
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 25
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF87:
	.string	"__errno_location"
.LASF67:
	.string	"__data"
.LASF48:
	.string	"_IO_FILE"
.LASF24:
	.string	"_IO_save_end"
.LASF7:
	.string	"short int"
.LASF9:
	.string	"size_t"
.LASF34:
	.string	"_offset"
.LASF49:
	.string	"__pthread_internal_list"
.LASF18:
	.string	"_IO_write_ptr"
.LASF13:
	.string	"_flags"
.LASF68:
	.string	"pthread_mutex_t"
.LASF50:
	.string	"__prev"
.LASF55:
	.string	"__count"
.LASF33:
	.string	"_lock"
.LASF64:
	.string	"__align"
.LASF25:
	.string	"_markers"
.LASF15:
	.string	"_IO_read_end"
.LASF84:
	.string	"GNU C17 13.2.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF38:
	.string	"_freeres_buf"
.LASF79:
	.string	"pthread_mutex_init"
.LASF77:
	.string	"pthread_mutex_lock"
.LASF51:
	.string	"__next"
.LASF69:
	.string	"stderr"
.LASF58:
	.string	"__kind"
.LASF46:
	.string	"long long int"
.LASF73:
	.string	"pthread_join"
.LASF75:
	.string	"pthread_create"
.LASF8:
	.string	"long int"
.LASF71:
	.string	"printf"
.LASF30:
	.string	"_cur_column"
.LASF86:
	.string	"perror"
.LASF65:
	.string	"pthread_mutexattr_t"
.LASF59:
	.string	"__spins"
.LASF81:
	.string	"argv"
.LASF74:
	.string	"exit"
.LASF29:
	.string	"_old_offset"
.LASF4:
	.string	"unsigned char"
.LASF80:
	.string	"argc"
.LASF72:
	.string	"pthread_mutex_destroy"
.LASF6:
	.string	"signed char"
.LASF35:
	.string	"_codecvt"
.LASF47:
	.string	"long long unsigned int"
.LASF83:
	.string	"decrease_fn"
.LASF3:
	.string	"unsigned int"
.LASF43:
	.string	"_IO_marker"
.LASF32:
	.string	"_shortbuf"
.LASF17:
	.string	"_IO_write_base"
.LASF41:
	.string	"_unused2"
.LASF14:
	.string	"_IO_read_ptr"
.LASF70:
	.string	"mutex"
.LASF63:
	.string	"__size"
.LASF21:
	.string	"_IO_buf_end"
.LASF12:
	.string	"char"
.LASF57:
	.string	"__nusers"
.LASF82:
	.string	"main"
.LASF36:
	.string	"_wide_data"
.LASF37:
	.string	"_freeres_list"
.LASF39:
	.string	"__pad5"
.LASF76:
	.string	"pthread_mutex_unlock"
.LASF54:
	.string	"__lock"
.LASF56:
	.string	"__owner"
.LASF5:
	.string	"short unsigned int"
.LASF88:
	.string	"increase_fn"
.LASF53:
	.string	"__pthread_mutex_s"
.LASF2:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_end"
.LASF11:
	.string	"__off64_t"
.LASF60:
	.string	"__elision"
.LASF27:
	.string	"_fileno"
.LASF26:
	.string	"_chain"
.LASF52:
	.string	"__pthread_list_t"
.LASF40:
	.string	"_mode"
.LASF10:
	.string	"__off_t"
.LASF23:
	.string	"_IO_backup_base"
.LASF20:
	.string	"_IO_buf_base"
.LASF28:
	.string	"_flags2"
.LASF44:
	.string	"_IO_codecvt"
.LASF16:
	.string	"_IO_read_base"
.LASF61:
	.string	"__list"
.LASF31:
	.string	"_vtable_offset"
.LASF45:
	.string	"_IO_wide_data"
.LASF22:
	.string	"_IO_save_base"
.LASF42:
	.string	"FILE"
.LASF66:
	.string	"pthread_attr_t"
.LASF62:
	.string	"pthread_t"
.LASF78:
	.string	"fprintf"
.LASF85:
	.string	"_IO_lock_t"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"simplesync.c"
.LASF1:
	.string	"/home/ebilias/Desktop/Classes/Operation Systems/Exer2/OSLab_exer2"
	.ident	"GCC: (Ubuntu 13.2.0-23ubuntu4) 13.2.0"
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

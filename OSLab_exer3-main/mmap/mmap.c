/*
 * mmap.c
 *
 * Examining the virtual memory of processes.
 *
 * Operating Systems course, CSLab, ECE, NTUA
 *
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>

#include <fcntl.h>
#include <errno.h>
#include <stdint.h>
#include <signal.h>

#include "help.h"

#define RED     "\033[31m"
#define RESET   "\033[0m"


char *heap_private_buf;
char *heap_shared_buf;

char *file_shared_buf;

uint64_t buffer_size;


/*
 * Child process' entry point.
 */
void child(void)
{
	uint64_t pa;

	
	
	

	

	

	
	
	
}

/*
 * Parent process' entry point.
 */
void parent(pid_t child_pid)
{
	uint64_t pa;
	int status;

	

	
	
	

	

	
}




int main(void)
{	
	pid_t mypid, p;
	int fd = -1;
	uint64_t pa;
	
	int fop = open("./file.txt", O_RDONLY);
	struct stat sb;
	mypid = getpid();
	buffer_size = 1 * get_page_size();


	



	if (-1 == close(fop)) 
	{
		perror("close");
	}

	return 0;
}


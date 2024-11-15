#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

void explain_wait_status(pid_t pid, int status) 
{
	if(WIFEXITED(status)) 
	{
		fprintf(stderr, "Child with PID = %ld terminated normally, exit status = %d\n", (long)pid, WEXITSTATUS(status));	
	}
	else if(WIFSIGNALED(status)) 
	{
		fprintf(stderr, "Child with PID = %ld was terminated by a signal, signo = %d\n", (long)pid, WTERMSIG(status));
	}
	else if(WIFSTOPPED(status)) 
	{
		fprintf(stderr, "Child with PID = %ld has been stopped by a signal, signo = %d\n", (long)pid, WSTOPSIG(status));
	}
	else 
	{
		fprintf(stderr, "%s: Internal error: Unhandled case, PID = %ld, status = %d\n", __func__, (long)pid, status);
	}
	fflush(stderr);
}

int main(int argc, char **argv) 
{
	
	pid_t p;
	int status;
	char *args[] = {"./a1.1", argv[1], argv[2], argv[3], NULL};
	
	p = fork();

	if (p < 0) 
	{
		perror("fork");
		exit(1);
	}
	else if (p == 0) 
	{
	
		execv(args[0], args);

	}
	else 
	{	
		p = wait(&status);
                explain_wait_status(p, status);
	}

	return 0;		
}

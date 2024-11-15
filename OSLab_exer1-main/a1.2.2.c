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

void child(pid_t child_pid, pid_t parent_pid, int var) 
{
	printf("Child: Hello! I'm %d son of %d\n", child_pid, parent_pid);
	printf("Child: My x=%d\n", var);
}

void father(pid_t child_pid, int var) 
{
	printf("Father: Hello! I'm %d's father\n", child_pid);
	printf("Father: My x=%d\n", var);
}

int main(int argc, char **argv) 
{
	
	int x = 0;

	pid_t p, mypid, myppid;
	mypid = -1;
	myppid = -1;
	
	int status;
		
	p = fork();

	if (p < 0) 
	{
		perror("fork");
		exit(1);
	}
	else if (p == 0) 
	{	
		x = 1;
		mypid = getpid();
		myppid = getppid();
		child(mypid, myppid, x);
		
	} 	
	else 
	{
		x = 2;
		father(p, x);	
		p = wait(&status);
		explain_wait_status(p, status);
	}
	
	return 0;		
}

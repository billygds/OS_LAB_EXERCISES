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

void child(pid_t child_pid, pid_t parent_pid, int x) 
{
	printf("Child: Hello! I'm %d son of %d\n", child_pid, parent_pid);
	printf("Child: My x=%d\n", x);
}

void father(pid_t child_pid, int x) 
{
	printf("Father: I'm %d's father\n", child_pid);
	printf("Father: My x=%d\n", x);
}

int main(int argc, char **argv) 
{
	
	int x = 0;

	pid_t p, mypid, myppid;
	mypid = -1;
	myppid = -1;
	
	int status;
	
	int fpr, fpw;
        int counter = 0;

        char sc = argv[3][0];
        char buff[1024];

        ssize_t rcnt;
        ssize_t wcnt;
        size_t len, idx;

        int oflags = O_CREAT | O_WRONLY | O_TRUNC;
        int mode = S_IRUSR | S_IWUSR;

	 
       	fpr = open(argv[1],O_RDONLY);
       	if(fpr == -1) 
	{
               	perror("open");
               	exit(1);
       	}

       	fpw = open(argv[2], oflags, mode);
       	if(fpw == -1) 
	{
               	perror("open");
               	exit(1);
       	}


	
	
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
		
		for(;;) 
		{
		
			rcnt = read(fpr, buff, sizeof(buff) - 1);
			if(rcnt == 0)
			{
				break;
			}
			if(rcnt == -1) 
			{
				return 1;
			}
			
			int i;
			for(i = 0; i < rcnt; i++) 
			{
				if(buff[i] == sc) 
				{
					counter++;
				}
			}
			buff[rcnt] = '\0';
		}
		char message[1024];
		sprintf(message, "The requested character '%c' has appeared %d times in the file %s\n", sc, counter, argv[1]);
		len = strlen(message);
		idx = 0;		
		
		while(idx < len) 
		{
			wcnt = write(fpw, message + idx, len - idx);
			if(wcnt = -1) 
			{
				perror("write");
				exit(1);
			}
			idx += wcnt;
		}
	} 	
	else 
	{
		x = 2;
		father(p, x);	
	
		p = wait(&status);
		explain_wait_status(p, status);
	
		close(fpr);
		close(fpw);
	}

	return 0;		
}

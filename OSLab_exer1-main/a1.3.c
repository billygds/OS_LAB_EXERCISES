#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>
#include <signal.h>

int n = 12;

void handler(int num)
{
	num = n;
	fprintf(stderr, "\nThere are currently %d processes running\n", num);	}

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

	int fpr, fpw;
	int counter = 0;
	
	char sc = argv[3][0];
	char buff[1024];

        ssize_t rcnt;
        ssize_t wcnt;
        size_t len, idx;

        int oflags = O_CREAT | O_WRONLY | O_TRUNC;
        int mode = S_IRUSR | S_IWUSR;
	
	pid_t p, mypid, myppid;
	mypid = -1;
	myppid = -1;
	
	int status;
	int i;

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
	
	int pfd[n][2];
	
	signal(SIGINT, handler);

	for(i = 0; i < n; i++)
	{
		if(pipe(pfd[i]) < 0)
		{
			perror("pipe");
			exit(1);
		}
		
		p = fork();
		mypid = getpid();
		myppid = getppid();
		if(p < 0)
		{
			perror("fork");
			exit(1);
		}
		else if(p == 0)
		{	
			close(pfd[i][0]);
			signal(SIGINT, SIG_IGN);
			int j;
			for(;;)
			{
				rcnt = read(fpr, buff, sizeof(buff) -1);
				if(rcnt == 0) 
				{
					break;
				}
				if(rcnt == -1) 
				{
					return 1;
				}
				for(j = 0; j < rcnt; j++) 
				{
					if(buff[j] == sc) 
					{
						counter++;
					}
				}
				buff[rcnt] = '\0';
			}
			
			if(write(pfd[i][1], &counter, sizeof(counter)) != sizeof(counter))
			{
				perror("write to pipe");
				exit(1);
			}

			sleep (1);
			exit(0);
		}
		else
		{
			close(pfd[i][1]);
			p = wait(&status);
        		explain_wait_status(p, status);

		}
		
	}
			
	int count = 0;	

	for(i = 0; i < n; i++)
	{
		
		if(read(pfd[i][0], &counter, sizeof(counter)) != sizeof(counter))
		{
			perror("read from pipe");
			exit(1);
		}
		count += counter;
	}

	char message[1024];
	sprintf(message, "The requested character '%c' has appeared %d times in the file %s\n", sc, count, argv[1]);

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


	close(fpr);
	close(fpw);

	return 0;		
}

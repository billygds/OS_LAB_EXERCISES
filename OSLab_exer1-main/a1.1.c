#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char **argv) 
{

	int fpr, fpw;
	int count = 0;

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
	
	
	for(;;) 
	{
		rcnt = read(fpr, buff, sizeof(buff)-1);
		
		if(rcnt == 0) 
		{
			break;
		}
		if(rcnt == -1) 
		{
			return 1;
		}
		
		int i;

		for(i=0; i < rcnt; i++) 
		{
			if(buff[i] == sc) 
			{
				count++;
			}
		}

		buff[rcnt] = '\0';
	}
	
	char message [1024];
	sprintf(message, "The requested character '%c' has appeared %d times in the file %s\n", sc, count, argv[1]);
	
	 len = strlen(message);
   	 idx = 0;
	
         while (idx < len) 
	{
         	wcnt = write(fpw, message + idx, len - idx);
         	if (wcnt == -1) 
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

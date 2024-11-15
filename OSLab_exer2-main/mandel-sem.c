/*
 * mandel.c
 *
 * A program to draw the Mandelbrot Set on a 256-color xterm.
 *
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

#include <assert.h>
#include <string.h>
#include <math.h>

#include <semaphore.h>
#include <pthread.h>

#include "mandel-lib.h"

#define MANDEL_MAX_ITERATION 100000

/* 
 * POSIX thread functions do not return error numbers in errno,
 * but in the actual return value of the function call instead.
 * This macro helps with error reporting in this case.
 */
#define perror_pthread(ret, msg) \
        do { errno = ret; perror(msg); } while (0)

/*******************************************************
 * Creating Signal Handler for Reseting terminal color *
 *******************************************************/

void handler() 
{
	reset_xterm_color(1);
	printf("\nReseting Terminal Color and Terminating the program\n");
	exit(1);
}

/*******************************************************
 * Creating Safe Atoi, Safe Malloc and Usage Functions *
 *******************************************************/

int safe_atoi(char *s, int *val)
{
	long l;
	char *endp;

	l = strtol(s, &endp, 10);
	if (s != endp && *endp == '\0') {
		*val = l;
		return 0;
	} else
		return -1;
}

void *safe_malloc(size_t size)
{
	void *p;

	if ((p = malloc(size)) == NULL) {
		fprintf(stderr, "Out of memory, failed to allocate %zd bytes\n",
			size);
		exit(1);
	}

	return p;
}

void usage(char *argv0)
{
        fprintf(stderr, "Usage: %s thread_count\n\n"
                "Exactly one argument required:\n"
                "    thread_count: The number of threads to create.\n", 
		argv0);
        exit(1);
}


/***********************
 *  Thread Info Object *
 ***********************/

struct thread_info_struct 
{
	pthread_t tid;
	sem_t *sem;

	int thread_id;
	int thread_count;
};



/***************************
 * Compile-time parameters *
 ***************************/

/*
 * Output at the terminal is is x_chars wide by y_chars long
*/
int y_chars = 50;
int x_chars = 90;

/*
 * The part of the complex plane to be drawn:
 * upper left corner is (xmin, ymax), lower right corner is (xmax, ymin)
*/
double xmin = -1.8, xmax = 1.0;
double ymin = -1.0, ymax = 1.0;
	
/*
 * Every character in the final output is
 * xstep x ystep units wide on the complex plane.
 */
double xstep;
double ystep;

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */
void compute_mandel_line(int line, int color_val[])
{
	/*
	 * x and y traverse the complex plane.
	 */
	double x, y;

	int n;
	int val;

	/* Find out the y value corresponding to this line */
	y = ymax - ystep * line;

	/* and iterate for all points on this line */
	for (x = xmin, n = 0; n < x_chars; x+= xstep, n++) {

		/* Compute the point's color value */
		val = mandel_iterations_at_point(x, y, MANDEL_MAX_ITERATION);
		if (val > 255)
			val = 255;

		/* And store it in the color_val[] array */
		val = xterm_color(val);
		color_val[n] = val;
	}
}

/*
 * This function outputs an array of x_char color values
 * to a 256-color xterm.
 */
void output_mandel_line(int fd, int color_val[])
{
	int i;
	
	char point ='@';
	char newline='\n';

	for (i = 0; i < x_chars; i++) {
		/* Set the current color, then output the point */
		set_xterm_color(fd, color_val[i]);
		if (write(fd, &point, 1) != 1) {
			perror("compute_and_output_mandel_line: write point");
			exit(1);
		}
	}

	/* Now that the line is done, output a newline character */
	if (write(fd, &newline, 1) != 1) {
		perror("compute_and_output_mandel_line: write newline");
		exit(1);
	}
}

void *compute_and_output_mandel_line(void *arg)
{	
	struct thread_info_struct *thr = arg;

	/*
	 * A temporary array, used to hold color values for the line being drawn
	 */
	
	int color_val[x_chars];

	for (int i = thr->thread_id; i  < y_chars; i += thr->thread_count) 
	{	
		int t_num = i % thr->thread_count;
		int next_t_num = (i + 1) % thr->thread_count;

		compute_mandel_line(i, color_val);
		
		sem_wait(&thr->sem[t_num]);
		
		output_mandel_line(1, color_val);
		
		//printf("Thread ID =  %ld\n", pthread_self());	
		
		sem_post(&thr->sem[next_t_num]);
	}
	return 0;
}

int main(int argc, char *argv[])
{
	int num_threads, ret;
	
	signal(SIGINT, handler);

	/******************
	 * Error Handling *
	 ******************/

	if(argc != 2)
	{
		usage(argv[0]);
	}
	if(safe_atoi(argv[1], &num_threads) < 0 || num_threads <= 0) 
	{
		fprintf(stderr, "`%s' is not valid for `thread_count'\n", argv[1]);
		exit(1);
	}

	/**************************************************
	 * Allocate and initialize semaphores and threads *
	 **************************************************/

	struct thread_info_struct *thread; 
	thread = safe_malloc(num_threads * sizeof(*thread));
	
	sem_t *sem;
	sem = safe_malloc(num_threads * sizeof(*sem));


	xstep = (xmax - xmin) / x_chars;
        ystep = (ymax - ymin) / y_chars;

	/******************************************
	 * Create N Semaphores, Lines and Threads *
	 ******************************************/

	for(int j = 1; j < num_threads; j++)
	{	
		sem_init(&sem[j], 0, 0);
	}
	
	sem_init(&sem[0], 0, 1);

	for(int i = 0; i < num_threads; i++)
        {
                thread[i].thread_id = i;
                thread[i].thread_count = num_threads;
		
		thread[i].sem = sem;
                ret = pthread_create(&thread[i].tid, NULL, &compute_and_output_mandel_line, &thread[i]);
        	if(ret)
		{
			perror_pthread(ret, "pthread_create");
                        exit(1);
		}
	}


	/***************************************
	 * Join Threads and destroy semaphores *
	 ***************************************/

	for(int k = 0; k < num_threads; k++)
	{
		ret = pthread_join(thread[k].tid, NULL);
		if(ret)
		{
			perror_pthread(ret, "pthread_join");
			exit(1);
		}
		sem_destroy(&sem[k]);
	}
	
	free(thread);
	free(sem);
	reset_xterm_color(1);
	return 0;
}

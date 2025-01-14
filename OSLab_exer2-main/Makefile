#
# Makefile
# 

CC = gcc

# CAUTION: Always use '-pthread' when compiling POSIX threads-based
# applications, instead of linking with "-lpthread" directly.
CFLAGS = -Wall -O2 -pthread
LIBS = 

all: pthread-test simplesync-mutex simplesync-atomic mandel mandel-sem mandel-conv

## Pthread test
pthread-test: pthread-test.o
	$(CC) $(CFLAGS) -o pthread-test pthread-test.o $(LIBS)

pthread-test.o: pthread-test.c
	$(CC) $(CFLAGS) -c -o pthread-test.o pthread-test.c

## Simple sync (two versions)
simplesync-mutex: simplesync-mutex.o
	$(CC) $(CFLAGS) -o simplesync-mutex simplesync-mutex.o $(LIBS)

simplesync-atomic: simplesync-atomic.o
	$(CC) $(CFLAGS) -o simplesync-atomic simplesync-atomic.o $(LIBS)

simplesync-mutex.o: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_MUTEX -c -o simplesync-mutex.o simplesync.c

simplesync-atomic.o: simplesync.c
	$(CC) $(CFLAGS) -DSYNC_ATOMIC -c -o simplesync-atomic.o simplesync.c

## Mandel
mandel: mandel-lib.o mandel.o
	$(CC) $(CFLAGS) -o mandel mandel-lib.o mandel.o $(LIBS)

mandel-sem: mandel-lib.o mandel-sem.o
	$(CC) $(CFLAGS) -o mandel-sem mandel-lib.o mandel-sem.o $(LIBS)

mandel-conv: mandel-lib.o mandel-conv.o
	$(CC) $(CFLAGS) -o mandel-conv mandel-lib.o mandel-conv.o $(LIBS)

mandel-lib.o: mandel-lib.h mandel-lib.c
	$(CC) $(CFLAGS) -c -o mandel-lib.o mandel-lib.c $(LIBS)

mandel.o: mandel.c
	$(CC) $(CFLAGS) -c -o mandel.o mandel.c $(LIBS)

mandel-sem.o: mandel-sem.c
	$(CC) $(CFLAGS) -c -o mandel-sem.o mandel-sem.c $(LIBS)

mandel-conv.o: mandel-conv.c
	$(CC) $(CFLAGS) -c -o mandel-conv.o mandel-conv.c $(LIBS)

clean:
	rm -f *.s *.o pthread-test simplesync-atomic simplesync-mutex mandel mandel-sem mandel-conv

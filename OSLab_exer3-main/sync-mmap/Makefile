#
# Makefile
# 

CC = gcc

# CAUTION: Always use '-pthread' when compiling POSIX threads-based
# applications, instead of linking with "-lpthread" directly.
CFLAGS = -Wall -O2 -pthread
LIBS = 

all: mandel-fork mandel-buf


## Mandel

mandel-fork: mandel-lib.o mandel-fork.o
	$(CC) $(CFLAGS) -o mandel-fork mandel-lib.o mandel-fork.o $(LIBS)

mandel-buf: mandel-lib.o mandel-buf.o
	$(CC) $(CFLAGS) -o mandel-buf mandel-lib.o mandel-buf.o $(LIBS)

mandel-lib.o: mandel-lib.h mandel-lib.c
	$(CC) $(CFLAGS) -c -o mandel-lib.o mandel-lib.c $(LIBS)

mandel-fork.o: mandel-fork.c
	$(CC) $(CFLAGS) -c -o mandel-fork.o mandel-fork.c $(LIBS)

mandel-buf.o: mandel-buf.c
	$(CC) $(CFLAGS) -c -o mandel-buf.o mandel-buf.c $(LIBS)
clean:
	rm -f *.s *.o mandel-fork mandel-buf

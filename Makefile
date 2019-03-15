# General NVCC Makefile
CC		= /usr/local/cuda-10.0/bin/nvcc #Points to NVCC on lab computers
LDFLAGS = -L /usr/local/cuda-10.0/lib64 #Included Libraries
IFLAGS 	= -I/usr/local/cuda-10.0/samples/common/inc #Included sample Files

all: histogram

histogram: histo_main.cu
	$(CC) histo_main.cu $(LDFLAGS) $(IFLAGS) -c $<
	$(CC) histo_main.o  $(LDFLAGS) $(IFLAGS) -o histogram

# target_name: object_name.cu
	#$(CC) object_name.cu $(LDFLAGS) $(IFLAGS) -c $<
	#$(CC) object_name.o $(LDFLAGS) $(IFLAGS) -o target_name

clean:
	$(RM) histogram *.o *.~ #add target_name

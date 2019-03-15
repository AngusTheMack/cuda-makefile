# Makefile for Cuda
1. `git clone https://github.com/AngusTheMack/cuda-makefile` - clone the repo
2. `cd cuda-makefile` - change into the directory
3. `make` - run the make command
4. `./histogram` - run the executable

I haven't touched the code in `histo_main.cu`, so it will likely say something is false. However, the code compiled without having to move files around or adding `nvcc` to the path - which is what this makefile helps with.

# Changes Made
The initial document was [histo_main_before.cu](histo_main_before.cu), and the problem was that it had dependencies laid out with relative paths - which are frustrating to setup when working on different lab machines.

The relative paths are the second and third lines below:
```C++
// CUDA Runtime
#include <cuda_runtime.h>
#include "../common/helper_cuda.h"
#include "../common/helper_functions.h" 
```
By changing these to `<...>` and getting rid of the relative paths, we tell the preprocessor to search the directories we have included with the `-I` flag. It looks as follows:
```C++
// CUDA Runtime
#include <cuda_runtime.h>
#include <helper_cuda.h>
#include <helper_functions.h>
```

# Makefile structure
The makefile sets the compiler (`CC`) to the `nvcc` executable on the lab computers. This is a faster than having to add the executable location to the path everytime.

It then sets the library flag (`LDFLAGS`) to the library files for Cuda on the lab computers.

On line three the `IFLAGS`, includes the location of the `.h` files that are required for compiling `histo_main.cu`.
```makefile
CC  = /usr/local/cuda-10.0/bin/nvcc
LDFLAGS = -L /usr/local/cuda-10.0/lib64
IFLAGS 	= -I/usr/local/cuda-10.0/samples/common/inc

all: histogram

histogram: histo_main.cu
	$(CC) histo_main.cu $(LDFLAGS) $(IFLAGS) -c $<
	$(CC) histo_main.o  $(LDFLAGS) $(IFLAGS) -o histogram
```
Then the `histogram` target is compiled with all the necessary flags, and output (`-o`) to an executable called `histogram`. Check out [this](https://renenyffenegger.ch/notes/development/make/index) page if you are confused by makefiles.


# Notes
This makefile will only work for the Lab computers at wits, and it won't work for every program. If you want to run a different `.cu` file you will have to change the related objects and targets. You may also have to change the `-I` flag (or add more) to point to different header files depending on what the other files have `#included`.
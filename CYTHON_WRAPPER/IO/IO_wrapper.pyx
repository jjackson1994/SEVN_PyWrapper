# distutils: language = c++
# distutils: sources = IO.cpp

from IO_header cimport IO

cdef class PyIO:

cdef IO* C_inst   # Hold a heap-allocated C++ instance which we're wrapping



def __init__(self):
	self.C_inst = new IO()


def __dealloc__(self):
	if self.C_inst != NULL:
		del self.C_inst







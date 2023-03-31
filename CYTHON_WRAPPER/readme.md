

# Progress step by step :


1. The first step was to get to know cython, and c++. An elementry to intermediate knowledge of c++ was essential, since a good understanding of functions and memory allocations would help us to better convert and understand the code implemented in cython. Moreover, although Cython is a python-like language, it uses most of the c and c++ syntax. We also found this [book](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/blob/main/CYTHON_WRAPPER/Info/Cython%20-%20A%20guide%20for%20Python%20programme...%20(z-lib.org).pdf) very useful for programming in cython.



2. The second step we took was to wrap utilities.h which is located in [include](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/include). we wrapped some functions and members to get to know cython better. The result can be found in the [utilities](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/utilities) file.

3. The third task was to wrap the class Binstar (or Binstar.h again in [include](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/include)). The **cython wrapper** for this class can be found in [Binstar](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/Binstar) file. This class had many dependencies on different classes and functions defined in various headers. At first we were facing a lot of problems finding these dependecies but my colleage [Jake Jackson](https://github.com/jjackson1994) wrote [this code](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/PY_TOOL) to help us find all of these dependecies. 


4. We also started wrapping the IO class, but it is still under developement. The result can be found in [IO](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/IO) file.


5. There is also an [error](https://github.com/Melikakmm/SEVN_PYTHON_WRAPPER/tree/main/CYTHON_WRAPPER/Errors) file that explains the reasons of some errors and warnings we faced during compiling the cython code.





# A Brief Introduction To Cython : 

Cython is a programming language that is designed to combine the power and speed of C and C++ with the ease and flexibility of Python. One of the main applications of Cython is to wrap C++ libraries in a way that makes them accessible to Python code. wrapping C++ libraries with Cython allows Python developers to leverage the power of C++ without having to learn an entirely new programming language or deal with the complexity of C++ directly. This makes it easier to write high-performance code for scientific and numerical computing applications, ultimately improving the speed and efficiency of data analysis and processing.


Cython documentation can be found [here](https://cython.readthedocs.io/en/latest/).





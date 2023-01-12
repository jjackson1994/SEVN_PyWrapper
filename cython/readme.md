# Cython Information

We are going to first wrap the file  sevn/include/general/utils/utilities.h  
The corropsonding cpp code is sevn/src/general/utils/utilities.cpp

To wrap create a [pyx file](https://github.com/jjackson1994/SVEN_py_wrapper/blob/main/cython/cython_wrapper.pyx)

Example of a single wrapped function

```Python
python3 setup.py build_ext --inplace
```

# or
### Use pyximport for interactive compilation of Cython file in any notebooks.


# Cython in jupyter notebook

```Python
%load_ext cython 
```

```Python
%%cython
#write dow the cython code here.
```

# the differences between def, cdef, cpdef:


def: is a dynamic define in python

cdef: is a static define in c/c++.

cpdef: if we define a function with cpdef, it both creates the c-level function and the python wrapper automatically, which can be called from python as well. when we call it in Cython we call the c-only version, while from python, the wrapper is called with underneath c/c++ performance.

#### its arguments and returns should be compatible with both python and c types.


#### Any python object can be represented at the c-levels, but not all c-types can be represented in Python. so we cannot use void, c pointers, or C arrays as the arguments or return types in cpdef functions.



# Cython extension types and Pure python classes:

Cython can enhance Python classes as well. Before we learn the specifics, we must first review the difference between Python classes and extension types, which will help us understand the what and why of Cython’s approach.


In python everything is an objects nad an object has 3 things:


1. identity: which distingushes the object from all others.

2. value: data associated to it.

3. type: which specifies the behaviors that an object of that type exhibits, and these behaviours are accessible through special functions called methods. A type is responsible for creating and destroying its objects, initializing them, and updating their values when methods are called on the object.



Python allows us to create new types, in Python code, with the class statement.

We can also create our own types at the C level directly using the Python/C API; these are known as extension types.



When we call methods on extension type instances, we are running compiled and statically typed code. In particular, the extension type has fast C-level access to the type’s methods and the instance’s data. this fast C-level access can lead to significant performance improvements.



##### Usage-wise, built-in types behave just like regular Python classes defined with the class statement, and the Python type system treats built-in types just like regular classes.



## how to make extensions in Cython:


Consider a simple class meant to model particles. Each particle has a mass, an x position, and a velocity. A simple Particle class in pure Python would look something like:

### The python class:

```Python
class Particle(object): 
  """Simple Particle type."""
  def __init__(self, m, p, v):
            self.mass = m
            self.position = p
            self.velocity = v
  def get_momentum(self):
            return self.mass * self.velocity
```


##### This class can be defined in pure Python at the interpreted level, or it can be compiled by Cython. An instance of Particle has a mass, a position, and a velocity, and users can call its get_momentum method. All attributes are readable and writeable, and users are free to assign other attributes to Particle objects outside the class body.


When we compile the Particle class to C with cython, the resulting class is just a regular Python class, not an extension type. When Cython compiles it to C, it is still imple‐ mented with general Python objects using dynamic dispatch for all operations. The generated code uses the Python/C API heavily and makes the same calls that the inter‐ preter would if this class were defined in pure Python. Because the interpreter overhead is removed, the Cython version of Particle will have a small performance boost. But it does not benefit from any static typing, so the Cython code still has to fall back on dynamic dispatch to resolve types at runtime.



### The extension type :

```Python
cdef class Particle:
  """Simple Particle extension type.""" 
  cdef double mass, position, velocity
  # ...
```


### The two additions:

1. cdef is added befroe the class statement.

2. the static cdef declarations are added in the class body, one for each instance attribute assigned to _init_. The _init_ and the get_momentum method remain unchanged.



### We’ll put our cdef class Particle in a file cython_particle.pyx, and the regular class Particle in a file python_particle.py. Then, from IPython:


```Python
In [1]: import pyximport; pyximport.install()
Out[1]: (None, <pyximport.pyximport.PyxImporter at 0x101c64290>)


#Here we use pyximport to compile the cython_particle.pyx file automatically at import time. We can inspect the two Particle types.



In [2]: import cython_particle
In [3]: import python_particle





In [4]: python_particle.Particle?

Type:       type
String Form:<class 'python_particle.Particle'>
File:       [...]/python_particle.py
Docstring:  Simple Particle type.
Constructor information:
Definition:python_particle.Particle(self, m, p, v)



In [5]: cython_particle.Particle?

Type:       type
String Form:<type 'cython_particle.Particle'>
File:       [...]/cython_particle.so
Docstring:  Simple Particle extension type.

#And we see that, besides the fact that the Cython version comes from a compiled library, they are very similar.





#The two types have identical initializers, so creation is the same:
In [6]: py_particle = python_particle.Particle(1.0, 2.0, 3.0)
In [7]: cy_particle = cython_particle.Particle(1.0, 2.0, 3.0)



#We can access all of the py_particle’s attributes:
In [10]: py_particle.mass, py_particle.position, py_particle.velocity
Out[10]: (1.0, 2.0, 3.0)


#!!!!!!!!!but none of cy_particle’s!!!!!!!!!: (not readable)
In [11]: cy_particle.mass, cy_particle.position, cy_particle.velocity
Traceback (most recent call last)
[...]
AttributeError: 'cython_particle.Particle' object has no attribute 'mass'


#Furthermore, we can add new attributes to py_particle on the fly.
#!!!!!!!!but cy_particle is locked down!!!!!!!!!: (new attributes not allowed)


In [13]: py_particle.charge = 12.0
In [14]: cy_particle.charge = 12.0
Traceback (most recent call last)
[...]
AttributeError: 'cython_particle.Particle' object has no attribute 'charge'



```
#### in python classes every change and call is possible, but in cython attributes are private and not readable, and we can't add new attributes, since the extension is locked down and private.

python class ---> a dictionary is allocated



Cython extension ----> a private struct which can be accessible with the methods of a class.



## what if we want to read or add(change) attributes:

```Python

#for reading only:
cdef class Particle:
    """Simple Particle extension type."""
    cdef readonly double mass, position, velocity
    # ...
    
    
#for modifications:
cdef class Particle:
    """Simple Particle extension type."""
    cdef public double mass
    cdef readonly double position
    cdef double velocity
    # ...
    
    
    
   #Here we have made mass readable and writeable with public, position read-only, and velocity private.



```

##### These exist only to allow and control access from Python.




















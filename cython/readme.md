# Cython Information

We are going to first wrap the file  sevn/include/general/utils/utilities.h  
The corropsonding cpp code is sevn/src/general/utils/utilities.cpp

To wrap create a [pyx file](https://github.com/jjackson1994/SVEN_py_wrapper/blob/main/cython/cython_wrapper.pyx)

Example of a single wrapped function

```Python
python3 setup.py build_ext --inplace
```


# Cython extension types and Pure python classes:

Cython can enhance Python classes as well. Before we learn the specifics, we must first review the difference between Python classes and extension types, which will help us understand the what and why of Cython’s approach.


In python everything is an objects nad an object has 3 things:
1.identity: which distingushes the object from all others.

2. value: data associated to it.

3. type: which specifies the behaviors that an object of that type exhibits, and these behaviours are accessible through special functions called methods. A type is responsible for creating and destroying its objects, initializing them, and updating their values when methods are called on the object.



Python allows us to create new types, in Python code, with the class statement.

We can also create our own types at the C level directly using the Python/C API; these are known as extension types.



When we call methods on extension type instances, we are running compiled and statically typed code. In particular, the extension type has fast C-level access to the type’s methods and the instance’s data. this fast C-level access can lead to significant performance improvements.



*** Usage-wise, built-in types behave just like regular Python classes defined with the class statement, and the Python type system treats built-in types just like regular classes.



### how to make extensions in Cython:


Consider a simple class meant to model particles. Each particle has a mass, an x position, and a velocity. A simple Particle class in pure Python would look something like:


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



















## Important stuff:

#### Marshalling:
* Integers store counting numbers. Python stores integers with arbitrary precision, meaning that you can store very, very, large numbers. C specifies the exact sizes of integers. You need to be aware of data sizes when you’re moving between languages to prevent Python integer values from overflowing C integer variables.

* Floating-point numbers are numbers with a decimal place. Python can store much larger (and much smaller) floating-point numbers than C. This means that you’ll also have to pay attention to those values to ensure they stay in range.

* Complex numbers are numbers with an imaginary part. While Python has built-in complex numbers, and C has complex numbers, there’s no built-in method for marshalling between them. To marshal complex numbers, you’ll need to build a struct or class in the C code to manage them.

* Strings are sequences of characters. For being such a common data type, strings will prove to be rather tricky when you’re creating Python bindings. As with other data types, Python and C store strings in quite different formats. (Unlike the other data types, this is an area where C and C++ differ as well, which adds to the fun!) Each of the solutions you’ll examine have slightly different methods for dealing with strings.

* Boolean variables can have only two values. Since they’re supported in C, marshalling them will prove to be fairly straightforward.



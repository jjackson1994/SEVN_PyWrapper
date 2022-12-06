# SVEN Python Wrapper

## Project Outline
The wrapper will have three main goals:
* to help users to run SEVN
* to analyse the output of SEVN (at least, for "standard" analysis)
* to produce some fancy plots.

Since SEVN is written in C++, it will be essential to have a python wrapper, which might attract a much larger number of users. Once we have the wrapper, we can use it for a large  number of scientific applications.

### Task list

* write a basic python wrapper for very basic c++ code 

### Ideas

* Make the most out of python object orientated
* Saving the outputs as CSV and reloading is not the the most computaionaly efficent, going striaght into a paraquet file would be much faster
* Add to anaconda ? 
* Easy plot capablity 
* Function to read the spread files 
* Simple plotting
* default mood and user input. 
 
### Resources
* https://intermediate-and-advanced-software-carpentry.readthedocs.io/en/latest/c++-wrapping.html  
* https://gitlab.com/sevncodes/sevn  
* https://gitlab.com/sevncodes/sevn/-/blob/SEVN/resources/SEVN_userguide.pdf 
* https://docs.gitlab.com/ee/user/ssh.html 
* https://stem.elearning.unipd.it/course/view.php?id=3064
* https://arrow.apache.org/docs/cpp/parquet.html
* https://realpython.com/python-bindings-overview/
* https://mediaspace.unipd.it/media/DEMOBLACK%20group%20meeting/1_mbuhwwra
* https://mediaspace.unipd.it/media/DEMOBLACK%20group%20meeting/1_wa6fmv8n

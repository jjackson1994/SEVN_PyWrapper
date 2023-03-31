

# distutils: language = c++




from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool
#from libcpp cimport tWrap
from libcpp.complex cimport complex
from libc.float cimport float
from libc.stdint cimport uint_fast32_t, uint_fast64_t

#There isn't much particularly special about the c++ iostreams compared to wrapping any other C++ class.
#The only tricky bit was getting access to std::ios_base::binary,
#which I did by telling Cython that std::ios_base was a namespace and not a class.




#cdef extern from "<iostream>" namespace "std":
#    cdef cppclass ostream:
#        ostream& write(const char*, int) except +

# obviously std::ios_base isn't a namespace, but this lets
# Cython generate the correct C++ code





cdef extern from "<iostream>" namespace "std":
    cdef cppclass istringstream[T]:
        pass
    
    cdef cppclass basic_istream[T]:
        pass

    cdef cppclass basic_ostream[T]:
        pass

    ctypedef basic_istream[char] istream

    ctypedef basic_ostream[char] ostream
    
    ctypedef istringstream[char] istringstream
    

    
cdef extern from "<iostream>" namespace "std::ios_base":
    cdef cppclass open_mode:
        pass
    cdef open_mode binary
    # you can define other constants as needed

cdef extern from "<fstream>" namespace "std":
    cdef cppclass ofstream(ostream):
        # constructors
        ofstream(const char*) except +
        ofstream(const char*, open_mode) except+
        
cdef extern from "<fstream>" namespace "std":
    cdef cppclass ifstream(ostream):
        # constructors
        ifstream(const char*) except +
        ifstream(const char*, open_mode) except+
        


cdef extern from "<random>" namespace "std" nogil:
    cdef cppclass random_device:
        ctypedef uint_fast32_t result_type
        random_device() except +
        result_type operator()() except +





cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/general/IO.cpp":
    pass






cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/IO.h":
    cdef cppclass IO:

   #constructors
   #do we have to call functions inside a constructor?

        #1st constructor
        IO() except +
        set_init_variables()

        #2nd constructor
        IO(int argc, char **argv) except +
        void load(int, char**)
        void load_stars()
        string get_output_folder_name()
        void create_folder(string)
        load(argc, argv)
        load_stars()
        #~IO()


    #Methods
        void load_stars()
        void load(int n, char** val)
        string get_logstring()
        #T fill_matrix_test[T](T vector[vector[T]]  &matrix, ifstream &file) except +



        #vector[T] vline;
        string line, value;
        istringstream stream;


        #cout[[" Filling matrix "[[endl;   ??????

        vector[vector[vector[vector[double]]]] tables,tables_HE;
        vector[double] Z, Z_HE;
        vector[vector[double]] allzams, allzams_HE;
        vector[vector[string] ] STARS_MATRIX;

        #random_device rd;

        #TODO Let the user select the output columns (not just what add to the default one)
        vector[string] printcolumns_star;   #![ List of string containing the name of the stellar properties to print in output. It
                                             #is composed by a default lit of columns
                                             # (IO::list_cols_star, defined in IO::load) plus some extra columns selected at runtime by the user with the -scol flag
                                             # see IO::load
        vector[string] printcolumns_binary; #[ As above, but for the properties of the binary system. Use -bcol flag to let the user add more columns
                                             # to the default defined in IO::list_cols_binary

        vector[size_t] printIDs_star;
        vector[size_t] printIDs_binary;


        size_t ntables;





        int         nthreads;
        string output_mode;     # Handle the file output type */
        string binput_mode;     # Handle the  formalism for the input for binaries */
        string winds_mode;      # Formalism for DA and DE in Winds accretion processes */
        string RL_mode;         # Formalism for DA and DE in RL  process */
        string tides_mode;      # Formalism for DA and DE in tidal processes */
        string GW_mode;         # Formalism for DA and DE in GW rad processes */
        string mix_mode;         # Formalism for  mixing processes options */
        string COLL_mode;         # Formalism for  mixing processes options */
        string HARD_mode;         # Formalism for  hardening processes options */
        string CIRC_mode;         # Formalism for  hardening processes options */
        string SNK_mode;         # Formalism for  SN kick processes options */
        string CE_mode;         # Formalism for  Common envelope  processes options */
        string SEVNpath;




        #Parameters call
        #TODO Transform all the paramters to parameters call
        inline bool rseed_provided()


        #SEVNpar svpar;
        int tablesloaded;
        void print_output(vector[vector[double]] &printmatrix, const string &_name, const unsigned long &_rseed, const size_t &_ID, const bool binaryprint=false)
        inline void print_formatted_output(vector[vector[double]] &printmatrix, const string &_name, const unsigned long &_rseed, const size_t &_ID, const bool binaryprint=false)



        void print_evolved_summary(const string &_name, const unsigned long &_rseed, const size_t &_ID)
        void print_failed_summary(const string &_name, const unsigned long &_rseed, const size_t &_ID)
        void print_failed_initilisation_summary(const size_t &_ID)
        inline void print_params(string filename="used_params.svpar")





        string fname;


        void print_log(string filename="logfile.dat");
        void log_put(string& loginfo)

        void create_folder(const string &name)
        inline get_output_folder_name()
        inline string get_SEVNpath() 
        vector[vector[double]] load_auxiliary_table(string name)
        ifstream table_file;
        vector[vector[double]] Matrix;
        




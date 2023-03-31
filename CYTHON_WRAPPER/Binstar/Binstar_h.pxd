









#the libraries needed:

# distutils: language = c++
from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool
#from libcpp cimport tWrap
from libcpp.complex cimport complex
from libc.float cimport float
from libc.stdint cimport uint_fast32_t, uint_fast64_t



#Importing the libraries: 


cdef extern from "<iostream>" namespace "std":
    cdef cppclass istringstream[T]:
        pass
    
    cdef cppclass basic_istream[T]:#what is T?
        pass

    cdef cppclass basic_ostream[T]:
        pass

    ctypedef basic_istream[char] istream

    ctypedef basic_ostream[char] ostream
    
#    ctypedef istringstream[char] istringstream
    
    
    
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

        




#calling the cpp source files:
#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/binstar/binstar.cpp":
#     pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/general/IO.cpp":
#     pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/general/utils/utilities.cpp":
#     pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/star/star.cpp":
#     pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/binstar/Processes.cpp":
#    pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/binstar/BinaryProperty.cpp":
#    pass

#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/star/property.cpp":
#    pass
#cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/src/general/utils/sevnlog.cpp":
#    pass






#calling classes or other dependencies that we need:

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/IO.h" : 
     cdef cppclass IO:
        IO() except + #except + ?
        #IO(int , char) except +


cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/utils/utilities.h" namespace "utilities":
    ctypedef bool bse_evolution
    ctypedef unsigned int sn_explosion



cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/params.h":
    pass


cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/lookup_and_phases.h":
    pass

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/binstar/Orbit.h":
    pass
        
           

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/star/star.h":
     cdef cppclass Star:
        Star() except +
        #Star(IO* , vector[string]& , size_t& , bool , unsigned long) except +



cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h":
    pass



cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/binstar/Processes.h":
    cdef cppclass Process:
        Process() except +
        
        

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/binstar/BinaryProperty.h":
    cdef cppclass BinaryProperty:
        BinaryProperty() except +

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/star/property.h":
    cdef cppclass Property:
        Property() except +

    
cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/utils/sevnlog.h" namespace "sevnstd":
    cdef cppclass SevnLogging:
        SevnLogging() except +
        



cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/binstar/binstar.h":
    cdef cppclass Binstar:
        Binstar() except +
        Binstar(IO* , vector[string]& , size_t& , unsigned long) except +
        
        
        
        
        IO *_io
        vector[string] &params
        size_t &_ID
        unsigned long _rseed
        





        #public:
            
        #MEMBERS:


        bool broken 
        bool onesurvived  
        bool empty
        bool break_at_remnant 
        bool break_at_broken 
        bool repeatstep  
        bool mix 
        bool comenv 
        bool is_swallowed[2] 
        double last_Timestep 
        bool print_all_steps  
        bool print_per_phase  
        bool print_only_end 
        bool print_events 
        bool print_rlo 
        bool disable_e_check 
        bool disable_a_check 
        bool disable_DM_check  
        bool disable_OmegaRem_NS_check 
        bool disable_stellar_rotation_check 
        bool force_tiny_dt 

        #Other variables
        double CE_E_tomatch   

        #Guard
        bool evolution_step_completed



        #Methods:
        inline double getp(const size_t &id) 
        inline double getp_0(const size_t &id) 
        inline string get_name() #this was std::string get_name()
        inline size_t get_ID() 
        inline Star* getstar(const size_t &id)  
        inline Process* getprocess(const size_t &id) 
        inline const vector[Process*]& getprocesses() #this was std::vector<Process*>&
        inline const vector[double] & getstate() #this was std::vector<double> &



        inline double get_last_Timestep()
        inline unsigned  int get_id_more_evolved_star()
        inline Star *get_more_evolved_star()


        double Radx(size_t starID)



        inline double get_svpar_num(string name)
        inline string get_svpar_str(string name)
        inline bool get_svpar_bool(string name)
        inline unsigned long get_rseed()




        void evolve() #this is a virtual function!




        inline bool is_process_ongoing(const size_t &id)
        inline bool processes_alarm(const size_t &id) 

        bool process_alarm_any()#const


        inline void reset_all_processes_alarms()


        inline void reset_events()



        inline double get_event_from_processes()


        bool isoutputtime()

        inline bool printall()
        inline bool notprint()


        void print()



        void print_failed(bool include_in_output=false)


        inline void print_to_log(string& message)


        void init(const vector[string] &params)


        inline vector[double]  get_zams()

        inline vector[double]  get_Z()

        inline void set_tf(const double a, const char* file, const int line)

        inline void set_dtout(const double a, const char* file, const int line)

        inline void evolution_step_done()

        #inline void evolution_guard(const char *file_input = NULL, int line_input = -1)

        inline double  get_tf()

        inline double get_dtout()

        inline string get_id_name()


        sn_explosion check_accretion_on_compact(size_t donorID, size_t accretorID, double DMaccreted)

        void check_accretion_on_compact()



        bool check_and_set_broken()



        #void check_and_set_bavera_xspin()
        #void check_if_applied_bavera_xspin()
        #double SetXspinBavera(const double, const double)








        #Members:
        double tf
        double dtout
        vector[double] state # this was std::vector<double>
        vector[double] combinedstate
        vector[vector[double]] allstates 


        #Methods
        void synchronise_dt_star()
        void check_and_sync_sse()
        void check_and_sync_bse()
        void check_nakedHe_or_nakedCO_after_binary_evolution()
        void check_AngMomSpin_after_binary_evolution()
        void limit_and_correct_mass_transfer_for_donor_from_binary(Star *donor, Star *accretor,
                                                               size_t mass_limiting_property_id)
        bool check_and_set_QHE(Star *accretor)
        void update_derived_properties_star(Star *s)
        inline void reset_evolution_flags()





        SevnLogging svlog




       #MEMBERS
        vector[Process*] process  
        vector[BinaryProperty*] property
        Star *star[2] 
        IO *io     
        size_t ID  
        vector[string] init_params; 
        string name   
        unsigned long rseed  
    

        #METHODS
        bse_evolution evolve_binary()

        inline void resynch(const double &dt)

    

        #Method to clean the heap from all the heap allocated members of this class

        void default_destructor()


        # Call the constructor of the two stars with parameters params_star1 and params_star2.
        # The parameters are Mass, Z, Spin, sn_type, t initial, t final, dt print output.
        # param params_star1  Mass, Z, Spin, sn_type, t initial, t final, dt print output of the first star.
        # param params_star2 Mass, Z, Spin, sn_type, t initial, t final, dt print output of the second star
        #note The random seeds of the stars are set to the same random seed of the binary.
     
        void call_stars_constructor(vector[string] &params_star1, vector[string] &params_star2)

        # Transform the parameter in input it the stardard form needed from the Star constructor and then call the stars constructor
        # NB: This is the version that I like more, but it is different with respect the
        # old SEVN V1 formalism (implemented in init_star_legacy)
        # The constructor is called in the standard way from a init param vector with:
        # Mass, Z, Spin, sn_type, t initial, t final, dt print output.
        # @param params A vector of string with the following orderd parameters:
        # Mass1, Z1, Spin1, sn_type1,  t_1 initial, Mass2, Z2, Spin2, sn_type2,  t_2 initial,  bin_separation, bin_eccentricity, t_final, dt_out
     
        void init_stars(const vector[string] &params)


        # Transform the parameter in input in the standard format needed from the Star constructor and then call the stars constructor.
        # The input format is in the old SEVN1 style.
        # The constructor is called in the standard way from a init param vector with:
        # Mass, Z, Spin, sn_type, t initial, t final, dt print output.
        # @param params A vector of string with the following orderd parameters:
        # Mass1, Mass2, Z1, Z2, Spin1, Spin2, bin_separation, bin_eccentricity, t_final, t_ini, tstep,  sn_type1, sn_type2, dt_out
        # NB: tstep not used at the moment

        void init_stars_legacy(const vector[string] &params)


        # Initialise the Semimajor checking the value
        # @param a_ini Initial value of the Semimajor axis, it should be larger than 0 or the functions throw a critical error
       
        inline void set_initial_semimajor(double a_ini)

    
        # Initialise the Semimajor checking the value
        # param a_ini string with the initial semimajor axis, if the string cannot be transformed to a number the function throw an io error.
        # a_ini has to be larger than 0 or the functions throw a critical error
        #
        inline void set_initial_semimajor(string a_ini)


        # Initialise the Eccentricity checking the value
        # param ecc_ini  Initial value of the eccentricity, it should be lower than 1 and no lower than 0
     
        inline void set_initial_eccentricity(double ecc_ini)


        # Initialise the Eccentricity checking the value
        # param ecc_ini string with the initial eccentricity, if the string cannot be transformed to a number the function throw an io error.
        # The initial value of the eccentricity has to  be lower than 1 and no lower than 0

        inline void set_initial_eccentricity(string ecc_ini)


        # Initialise the binary parameters.
        # param params  A vector of string with the following ordered parameters:
        #          if binput_mode is legacy: Mass1, Mass2, Z1, Z2, Spin1, Spin2, bin_separation, bin_eccentricity, t_final, t_ini, tstep  sn_type1, sn_type2, dt_out
        #          if binput_mode is new: Mass1, Z1, Spin1, sn_type1,  t_1 initial, Mass2, Z2, Spin2, sn_type2,  t_2 initial,  bin_separation, bin_eccentricity, t_final, dt_out

        inline void init_binary_properties(const vector[string] &params)



        # In this function we set the parameters that are already set in each star when we call init_stars or init_stars_legacy.
        # These parameters are: break_at_broken, break_at_remnant, print_all_steps and print_per_phase, tf, dtout.
        # The function just check that  the two stars store the same value for the parameters to set. It this is not true it throws a critical error.
        # note this function should be called after the initialisation of the stars (init_stars or init_stars_legacy).
   
        void  init_other_params()


        # Set time when the tf in input is equal to broken
        # param tf

        void set_break_at_broken(string &tf)

        inline void set_rseed(const unsigned long a, const char* file, const int line)


        # Check if params in input has the expected number of parameters as defined in INPUTMAPBIN and INPUTMAPBIN_PARAM (lookup_and_phases.cpp)
        # param params params to pass to the init function.

        inline void check_init_param(const vector[string] &params)






       #the distructor is not virtual
    
    
    
    
       #private and protected methods are not accessible.













from libcpp cimport bool
from libcpp.vector cimport vector





cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/binstar/binstar.h":
     #the c++ class from Binstar header
        cdef cppclass Binstar:
            bool broken; # If true the binary is broken
            bool onesurvived;  # true if just one star survived else either both stars are present or no stars are present
            bool empty;
            bool break_at_remnant;  # if true stop the evolution when both stars are remnant
            bool break_at_broken; # if true stop the evolution when the binary breaks
            bool repeatstep;  # Control if it is needed to repeat a step of the binary evolution. It is mostly used in BTimestep::evolve
            bool mix; # If true the binary is mixing
            bool comenv; # If true the binary is doing a  ce
            bool is_swallowed[2]; # Array of bool corresponding to the ID of stars in binary. If true, the star has been swallowed
            double last_Timestep; # it stores the last value of the Timestep used in the evolution 


            bool print_all_steps;  #  If true print in output all the steps.
            bool print_per_phase;  # If true print in output in each phase change
            bool print_only_end;  # If true do not print intermediate steps 
            bool print_events; # If true print all the events 
            bool print_rlo; # If true print all the steps during a rlo 


            bool disable_e_check; # If true, the e_check in adpative timestep is disabled 
            bool disable_a_check; # If true, the a_check in adpative timestep is disabled 
            bool disable_DM_check; # If true, the DM_check (from binary evolution) in adpative timestep is disabled 
            bool disable_OmegaRem_NS_check; # If true, the OmegaRem_NS_check (from binary evolution) in adpative timestep is disabled 
            bool disable_stellar_rotation_check; # If true, the OmegaSpin (from binary evolution) in adpative timestep is disabled 
            bool force_tiny_dt; # If true, it forces the next Binary time step to be equal to utilities::TINY 

          #Other variables
            #double CE_––E_tomatch = utilities::NULL_DOUBLE;  

          #Guard
            bool evolution_step_completed;

          #constructures for fake objects
          ####????Binstar(){}

          #Proper constructors
            #Binstar(IO *_io, vector[char] &params, size_t &_ID, unsigned long _rseed=0)


          #Methods
            inline double getp(const size_t &id) 
            inline double getp_0(const size_t &id) 
            inline char get_name() 
            inline size_t get_ID()
            #inline Star getstar(const size_t &id)
            #inline Process #getprocess(const size_t &id)
            #inline const std::vector<Process#>& getprocesses()
            inline const vector [double] & getstate()




            inline unsigned  int get_id_more_evolved_star()
            #inline Star *get_more_evolved_star() 
            unsigned int _id                                      #default value :
                                                                 #unsigned int _id=get_id_more_evolved_star()
            double Radx(size_t starID);
            inline double get_svpar_num(char name)
            inline char get_svpar_str(char name)
            inline bool get_svpar_bool(char name)
            inline unsigned long get_rseed()
            void evolve()
                                                             #default value:
            double twait                                     #double twait=1E30;


            #Star * this_star = star[0];
            #Star * other_star = star[1];



            inline void recordstate_w_timeupdate()
            inline void recordstate()
            inline void recordstate_binary()
            inline void set_broken()
            inline void set_empty()
            inline void set_onesurvived()
            inline bool breaktrigger() 
            inline bool is_process_ongoing(const size_t &id)
            inline bool processes_alarm(const size_t &id)
            bool process_alarm_any() 
            inline void reset_all_processes_alarms()
            inline void reset_events()
            inline double get_event_from_processes()



            bool RLOB_triggered
            bool Merger_triggered
            bool Collision_triggered
            bool CE_triggered
            
            
            
            
            #defaults:
            #bool RLOB_triggered=false;
            #bool Merger_triggered=false;
            #bool Collision_triggered=false;
            #bool CE_triggered=false;
            
            
            double event
            #default :
            #double event=-1.0
            
            
            inline bool isoutputtime()
            inline bool printall()
            inline bool notprint()
            void print()
            void print_failed(bool include_in_output=false)
            inline void print_to_log(char & message) # ???? inline void?
            void init(const vector[char] &params)
            
            inline vector[double]  get_zams() 
            inline vector[double]  get_Z()
            
            inline void set_tf(const double a, const char* file, const int line)
            inline void set_dtout(const double a, const char* file, const int line)
            inline void evolution_step_done()
            inline void evolution_guard(const char *file_input = nullptr, int line_input = -1)
            inline double get_tf()
            inline double get_dtout()
            inline char get_id_name() 
            #utilities::sn_explosion check_accretion_on_compact(size_t donorID, size_t accretorID, double DMaccreted);
            void check_accretion_on_compact()
            

            #default:
            #Star *donor    = star[0];
            #Star *accretor = star[1];
            


            double DM_accretor;


            bool check_and_set_broken()
            void check_and_set_bavera_xspin();
            void check_if_applied_bavera_xspin();
            double SetXspinBavera(const double, const double)






cdef class pBinar:


#we need the IO thng to be wrapped




            
      
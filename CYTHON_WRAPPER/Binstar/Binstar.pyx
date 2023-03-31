# cython: no_override=True

# distutils: language = c++


from cython.operator import dereference as deref

from cpython.array cimport array


from Binstar_h cimport *



cdef class pIO:
    cdef IO* C_IO
    
    
    def __init__(self):
        self.C_IO = new IO()
        
        
    def __dealloc__(self):
        del self.C_IO
        
        

cdef class pSevnLogging:
    
    cdef SevnLogging* C_SevnLogging
    
    
    def __init__(self):
        self.C_SevnLogging = new SevnLogging()
        
        
    def __dealloc__(self):
        del self.C_SevnLogging 
        
        

    
cdef class pProcess:

    cdef Process* C_Process
    
    
    def __init__(self):
        self.C_Process = new Process()
        
    def __dealloc__(self):
        del self.C_Process
        
        
        
cdef class pBinaryProperty:

    cdef BinaryProperty* C_BinaryProperty
    
    
    def __init__(self):
        self.C_BinaryProperty = new BinaryProperty()
        
    def __dealloc__(self):
        del self.C_BinaryProperty
        
        
        
cdef class pStar:

    cdef Star* C_Star
    
    
    def __init__(self):
        self.C_Star = new Star()
        
    def dealloc(self):
        del self.C_Star
        
        
     

    
    
#-----------------------------------------------------------------------------------------------------------------    
    
#Binstar c++ class has two constructors:



cdef class pBinstar:

    cdef Binstar* C_inst# Holds a heap-allocated C++ instance which we're wrapping
    cdef array C_access

    # most of the arguments are still c++ types, we couldn't set them to None nor NULL (because of params)
    #Therefore, we decided to set them to a random arguments as default and change constructors with the 'secondconst'

    def __cinit__(self,pIO _io, vector[string] &params , size_t &_ID = 0,_rseed=0, bool secondconst = 0):  
        #In the given code, _io.C_IO is a reference to a C++ IO object
        #that has been created and wrapped in a Python class pIO using Cython.
        # C_IO is a attribute of pIO class, and is used to hold the reference to the underlying IO object.
        
        
        
        
        #first constructor(nullary constructor):
        if secondconst ==0 :
            self.C_inst = new Binstar()
            if self.C_inst == NULL:
                raise MemoryError('Not enough memory!')

            
            
        else:
        
            #second constructor:
            C_access = array("L", _rseed )
            self.C_inst = new Binstar(_io.C_IO, params, _ID,  deref(C_access.data.as_ulongs))

    def __dealloc__(self):
        if self.C_inst != NULL:
            del self.C_inst
            
            
            
    #Methods        
    def pgetp(self, const size_t &id):
        self.C_inst.getp(id) 
        
        
    def pgetp_0(self, const size_t &id):
        self.C_inst.getp_0(id)
        
        
    def pget_name(self):
        self.C_inst.get_name()
        
    def pget_ID(self):
        self.C_inst.get_ID()
        
    def pgetstar(self, const size_t &id):
        self.C_inst.getstar(id)
        
    def pgetprocess(self, const size_t &id):
        self.C_inst.getprocess(id)
        
    def pgetprocesses(self):
        self.C_inst.getprocesses()
        
    def pgetstate(self):
        self.C_inst.getstate()
        
    def pget_last_Timestep(self):
        self.C_inst.get_last_Timestep()
        
    def pget_id_more_evolved_star(self):
        self.C_inst.get_id_more_evolved_star()
        
    def pget_more_evolved_star(self):
        self.C_inst.get_more_evolved_star()
        
    def pRadx(self, size_t starID):
        self.C_inst.Radx(starID)
        
    def pget_svpar_num(self, string name):
        self.C_inst.get_svpar_num(name)
        
    def pget_svpar_str(self, name):
        self.C_inst.get_svpar_str(name)
        
    def pget_svpar_bool(self, string name):
        self.C_inst.get_svpar_bool(name)
        
    def pget_rseed(self):
        self.C_inst.get_rseed()
        
    def pevolve(self):
        self.C_inst.evolve()
        
    def pis_process_ongoing(self, const size_t &id):
        self.C_inst.processes_alarm(id) 
        
    def pprocesses_alarm(self, const size_t &id):
        self.C_inst.processes_alarm(id) 
        
    def pprocess_alarm_any(self):
        self.C_inst.process_alarm_any()
        
    def preset_all_processes_alarms(self):
        self.C_inst.reset_all_processes_alarms()
        
    def preset_events(self):
        self.C_inst.reset_events()
        
    def pget_event_from_processes(self):
        self.C_inst.get_event_from_processes()
        
    def pisoutputtime(self):
        self.C_inst.isoutputtime()
        
    def pprintall(self):
        self.C_inst.printall()
        
    def pnotprint(self):
        self.C_inst.notprint()
        
    def pprint(self):
        self.C_inst.print()
            
    #def pprint_failed(self, bool include_in_output= False):
    #    self.C_inst.print_failed(include_in_output=False)
        
    def pprint_to_log(self, string& message):
        self.C_inst.print_to_log(message)
        
    def pinit(self, const vector[string] &params):
        self.C_inst.init(params)
        
    def get_zams(self):
        self.C_inst.get_zams()
        
    def get_Z(self):
        self.C_inst.get_Z()
        
    #def pset_tf(self, const double a, const char* file, const int line):
    #    self.C_inst.set_tf(a, file, line)
        
    def pevolution_step_done(self):
        self.C_inst.evolution_step_done()
        
    #def pevolution_guard(self, const char *file_input = NULL, int line_input = -1):
    #    self.C_inst.evolution_guard(file_input = NULL, line_input = -1)
        
    def pget_tf(self):
        self.C_inst.get_tf()
        
    def pget_dtout(self):
        self.C_inst.get_dtout()
        
    def pget_id_name(self):
        self.C_inst.get_id_name()
        
    def pcheck_accretion_on_compact(self, size_t donorID, size_t accretorID, double DMaccreted):
        self.C_inst.check_accretion_on_compact(donorID, accretorID, DMaccreted)
        
    def pcheck_accretion_on_compact(self):
        self.C_inst.check_accretion_on_compact()
        
    def pcheck_and_set_broken(self):
        self.C_inst.check_and_set_broken()
        
    #def pcheck_and_set_bavera_xspin(self):
    #    self.C_inst.check_and_set_bavera_xspin()
        
    #def pcheck_if_applied_bavera_xspin(self):
    #    self.C_inst.check_if_applied_bavera_xspin()
        
    #def pSetXspinBavera(self, const double, const double):
    #    self.C_inst.SetXspinBavera(const double, const double)
    
    
    
    
######## This methods are either protected or private ########
        
    #Second part of the Methods:
    
    #def pevolve_binary(self):
    #    self.C_inst.evolve_binary()
        
    #def presynch(self, const double &dt):
    #    self.C_inst.resynch(dt)
        
    #def pdefault_destructor(self):
    #    self.C_inst.default_destructor()
        
    #def pcall_stars_constructor(self, vector[string] &params_star1, vector[string] &params_star2):
    #    self.C_inst.call_stars_constructor(params_star1, params_star2)
        
    #def pinit_stars(self, const vector[string] &params):
    #    self.C_inst.init_stars(params)
        
    #def pinit_stars_legacy(self, const vector[string] &params):
    #    self.C_inst.init_stars_legacy(params)
        
    #def pset_initial_semimajor(self, double a_ini):
    #    self.C_inst.set_initial_semimajor( a_ini)
        
    #def pset_initial_semimajor(self, string a_ini):
    #    self.C_inst.set_initial_semimajor( a_ini)
        
        
    #def pset_initial_eccentricity(self,double ecc_ini):
    #‰    self.C_inst.set_initial_eccentricity( ecc_ini)
        
    #def pset_initial_eccentricity(self, string ecc_ini):
    #    self.C_inst.set_initial_eccentricity( ecc_ini)
        
    #def pinit_binary_properties(self, const vector[string] &params):
    #    self.C_inst.init_binary_properties(params)
        
    #def pinit_other_params(self):
    #    self.C_inst.init_other_params()
        
    #def pset_break_at_broken(self, string &tf):
    #    self.C_inst.set_break_at_broken(tf)
        
    #def pcheck_init_param(self, const vector[string] &params):
    #    self.C_inst.check_init_param(params)
    

        
        

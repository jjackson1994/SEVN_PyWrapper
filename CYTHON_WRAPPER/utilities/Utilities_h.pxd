

cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/utils/sevnlog.h" namespace "sevnstd":
    cdef cppclass SevnLogging:
        SevnLogging() except +
        
        
cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/utils/errhand.h":
    pass
        


cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/utils/utilities.h":
    pass

    
    
cdef extern from "/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h" namespace "utilities":
    double maxwellian_cdf(double x, double sigma)
    double maxwellian_pdf(double x, double sigma)
    double roche_lobe_Eg(double Mass_primary, double Mass_secondary, double a)
    double kepler(double ecc, double m, double tol, int maxit)
    
    






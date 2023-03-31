

from Utilities_h cimport *



cdef class _Params:

    cdef public double G, yr_cgs, parsec_cgs, Rsun_cgs, Msun_cgs
    cdef public double Sigma_StefBoltz, Myr_to_yr, yr_to_Myr, kms_to_RSunyr, LSun_to_Solar, c, km_to_RSun, g_to_MSun, Mchandra
    cdef public double NULL_DOUBLE
    cdef public int NULL_INT
    cdef public double DIFF_TOLL, LARGE, TINY, tH
    cdef public int SINGLE_STEP_EVOLUTION, REPEATED_EVOLUTION
    cdef public int JUMP_CONVERGE, JUMP, NO_JUMP, SNIA_EXPLODE, SNII_EXPLODE, SN_NOT_EXPLODE, RLO_TRUE, RLO_FALSE
    cdef public int BIN_EV_DONE, BIN_EV_SETBROKEN, BIN_EV_NOT_DONE
    
    def __init__(self):#can be tried with __Cinit__ as well#test the speed

        self.G = 3.925125598496094e8; #RSUN^3 YR^-2 MSUN^-1 (astropy: constant.G.to("Rsun^3/yr^2/Msun"))
        self.yr_cgs = 3.1557600e7; #yr in s (astropy: u.yr.to(u.s))
        self.parsec_cgs= 3.085677581491367e+18; #parsec in cm (astropy: u.parsec.to(u.cm))
        self.Rsun_cgs = 6.95700e10; #rsun in cm (astropy constant.R_sun.to("cm"))
        self.Msun_cgs = 1.988409870698051e+33; #msun in g (astropy constant.M_sun.to("cm"))




        self.Sigma_StefBoltz = 7.1694165533435e-17; #LSun^3 RSun^-2 K^-4 (astropy: constant.sigma_sb.to('Lsun/(K^4 * Rsun^2)')
        self.Myr_to_yr = 1.0e6;
        self.yr_to_Myr = 1.0e-6;
        self.kms_to_RSunyr = 45.360931435963785; #(astropy: (u.km/u.s).to(u.Rsun/u.yr))
        self.LSun_to_Solar = 12.500687924182579; #From Lsun to MSun RSun^2 yr^-3 (astropy: u.Lsun.to((u.Msun*u.Rsun**2)/(u.yr**3)))
        self.c = 1.3598865132357053e7; # RSun/yr (astropy: constant.c.to('Rsun/yr'))
        self.km_to_RSun = 1.4374011786689665e-06; #(astropy: u.km.to(u.Rsun))
        self.g_to_MSun = 5.029144215870041e-34; #(astropy: u.g.to(u.Msun))
        self.tH = 13.7*1e3; #Hubble time in Myr
        self.Mchandra = 1.41; #Chandrasekhar mass in Msun

        ###string PLACEHOLDER="xxx"; # Standard placeholder for input properties
        # SY

        # MAGIC NULL VALUES
        self.NULL_DOUBLE = -9e30;
        self.NULL_INT = -999999999;
        #size_t NULL_SINT = 999999999;
        # std::string NULL_STR = "FORZAROMA"; # NOT POSSIBLE in C11 (It will be possible in C20)
        ###string NULL_STR = "FORZAROMA";

        # MAGIC LARGE AN TINY VALUES
        self.DIFF_TOLL = 1e-10; # Tollerance on difference between two values
        self.LARGE = 1e30;
        self.TINY = 1e-15;
        ###double DOUBLE_EPS = std::numeric_limits<double>::epsilon();


        # INT CONSTANT TO HANDLE RETURN FROM EVOLUTION
        ###ctypedef unsigned int evolution;
        self.SINGLE_STEP_EVOLUTION=0;
        self.REPEATED_EVOLUTION=1;

        # INT CONSTANT TO HANDLE RETURN FROM FUNCTIONS
        ###ctypedef unsigned int jump_convergence;
        self.JUMP_CONVERGE=0;
        self.JUMP=1;
        self.NO_JUMP=2;

        # INT CONST FOR SN EXPLOSION
        ###ctypedef unsigned int sn_explosion;
        self.SNIA_EXPLODE=1;
        self.SNII_EXPLODE=2;
        self.SN_NOT_EXPLODE=0;

        # INT CONST FOR RLO
        ###ctypedef unsigned int rlo;
        self.RLO_FALSE=0; # RLO is happening or happened
        self.RLO_TRUE=1; # RLO is happening or happened

        # bool CONST FOR BINARY EVOLUTION
        ###ctypedef bool bse_evolution;
        self.BIN_EV_DONE = 1; # This is the return if the properties of the binary have been evolved with the proper evolve method
        self.BIN_EV_NOT_DONE = 0; # This is the return if the properties of the binary have been evolved without the proper evolve method
        self.BIN_EV_SETBROKEN = 2; # This is the return if the properties of the binary have not been evolved but a set broken has been called

    cpdef double G_cgs(self): ###we defined with cpdef since we want a c-level function that can be readable with python
        return self.G*self.Rsun_cgs*self.Rsun_cgs*self.Rsun_cgs/(self.Msun_cgs*self.yr_cgs*self.yr_cgs)
    cpdef double G3_over_c5(self) except? -1:
        return (self.G*self.G*self.G)/(self.c*self.c*self.c*self.c*self.c)
    cpdef double parsec_to_Rsun(self) except? -1:
        return self.parsec_cgs/self.Rsun_cgs

    cpdef double G_over_c2(self) except? -1:
        return self.G / (self.c*self.c)


    
    
    

#–––––––––functions–––––––––––––#







cdef class Functions:






    cpdef double pkepler(self, double ecc, double m, double tol, int maxit):
        return kepler( ecc,  m,  tol,  maxit)


    cpdef double pmaxwellian_cdf(self, double x, double sigma):
        return maxwellian_cdf(x, sigma)

    cpdef double pmaxwellian_pdf(self, double x, double sigma):
        return maxwellian_pdf(x, sigma)

    cpdef double proche_lobe_Eg(self, double Mass_primary, double Mass_secondary, double a):
        return roche_lobe_Eg(Mass_primary, Mass_secondary, a)





{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 58,
   "id": "f95865f0",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "The cython extension is already loaded. To reload it, use:\n",
      "  %reload_ext cython\n"
     ]
    }
   ],
   "source": [
    "%load_ext cython "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 59,
   "id": "ff9a7702",
   "metadata": {
    "scrolled": true
   },
   "outputs": [],
   "source": [
    "%%cython\n",
    "\n",
    "cdef class params:\n",
    "    cdef public double G, yr_cgs, parsec_cgs, Rsun_cgs, Msun_cgs\n",
    "    cdef public double Sigma_StefBoltz, Myr_to_yr, yr_to_Myr, kms_to_RSunyr, LSun_to_Solar, c, km_to_RSun, g_to_MSun, Mchandra\n",
    "    cdef public double NULL_DOUBLE\n",
    "    cdef public int NULL_INT\n",
    "    cdef public double DIFF_TOLL, LARGE, TINY\n",
    "    cdef public int SINGLE_STEP_EVOLUTION, REPEATED_EVOLUTION\n",
    "    cdef public int JUMP_CONVERGE, JUMP, NO_JUMP, SNIA_EXPLODE, SNII_EXPLODE, SN_NOT_EXPLODE, RLO_TRUE, RLO_FALSE\n",
    "    cdef public int BIN_EV_DONE, BIN_EV_SETBROKEN, BIN_EV_NOT_DONE\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "    def __init__(self):\n",
    "        self.G = 3.925125598496094e8; #RSUN^3 YR^-2 MSUN^-1 (astropy: constant.G.to(\"Rsun^3/yr^2/Msun\"))\n",
    "        self.yr_cgs = 3.1557600e7; #yr in s (astropy: u.yr.to(u.s))\n",
    "        self.parsec_cgs= 3.085677581491367e+18; #parsec in cm (astropy: u.parsec.to(u.cm))\n",
    "        self.Rsun_cgs = 6.95700e10; #rsun in cm (astropy constant.R_sun.to(\"cm\"))\n",
    "        self.Msun_cgs = 1.988409870698051e+33; #msun in g (astropy constant.M_sun.to(\"cm\"))\n",
    "    cpdef double G_cgs(self): ###we defined with cpdef since we want a c-level function that can be readable with python\n",
    "        return self.G*self.Rsun_cgs*self.Rsun_cgs*self.Rsun_cgs/(self.Msun_cgs*self.yr_cgs*self.yr_cgs)\n",
    "        #self.G_cgs = G*Rsun_cgs*Rsun_cgs*Rsun_cgs/(Msun_cgs*yr_cgs*yr_cgs); #cm^3 s^-2 g^-1\n",
    "\n",
    "\n",
    "        self.Sigma_StefBoltz = 7.1694165533435e-17; #LSun^3 RSun^-2 K^-4 (astropy: constant.sigma_sb.to('Lsun/(K^4 * Rsun^2)')\n",
    "        self.Myr_to_yr = 1.0e6;\n",
    "        self.yr_to_Myr = 1.0e-6;\n",
    "        self.kms_to_RSunyr = 45.360931435963785; #(astropy: (u.km/u.s).to(u.Rsun/u.yr))\n",
    "        self.LSun_to_Solar = 12.500687924182579; #From Lsun to MSun RSun^2 yr^-3 (astropy: u.Lsun.to((u.Msun*u.Rsun**2)/(u.yr**3)))\n",
    "        self.c = 1.3598865132357053e7; # RSun/yr (astropy: constant.c.to('Rsun/yr'))\n",
    "        self.km_to_RSun = 1.4374011786689665e-06; #(astropy: u.km.to(u.Rsun))\n",
    "    cpdef double parsec_to_Rsun(self):\n",
    "        return self.parsec_cgs/self.Rsun_cgs\n",
    "        #self.parsec_to_Rsun= parsec_cgs/Rsun_cgs;\n",
    "        self.g_to_MSun = 5.029144215870041e-34; #(astropy: u.g.to(u.Msun))\n",
    "    cpdef double G_over_c2(self):\n",
    "        return self.G / (self.c*self.c)\n",
    "        #self.G_over_c2 = G / (c*c);\n",
    "    cpdef double G3_over_c5(self):\n",
    "        return (self.G*self.G*self.G)/(self.c*self.c*self.c*self.c*self.c)\n",
    "        #self.G3_over_c5 = (G*G*G)/(c*c*c*c*c); #Scaling for GW processes\n",
    "        self.tH = 13.7*1e3; #Hubble time in Myr\n",
    "        self.Mchandra = 1.41; #Chandrasekhar mass in Msun\n",
    "\n",
    "        ###string PLACEHOLDER=\"xxx\"; # Standard placeholder for input properties\n",
    "        # SY\n",
    "\n",
    "        # MAGIC NULL VALUES\n",
    "        self.NULL_DOUBLE = -9e30;\n",
    "        self.NULL_INT = -999999999;\n",
    "        #size_t NULL_SINT = 999999999;\n",
    "        # std::string NULL_STR = \"FORZAROMA\"; # NOT POSSIBLE in C11 (It will be possible in C20)\n",
    "        ###string NULL_STR = \"FORZAROMA\";\n",
    "\n",
    "        # MAGIC LARGE AN TINY VALUES\n",
    "        self.DIFF_TOLL = 1e-10; # Tollerance on difference between two values\n",
    "        self.LARGE = 1e30;\n",
    "        self.TINY = 1e-15;\n",
    "        ###double DOUBLE_EPS = std::numeric_limits<double>::epsilon();\n",
    "\n",
    "\n",
    "        # INT CONSTANT TO HANDLE RETURN FROM EVOLUTION\n",
    "        ###ctypedef unsigned int evolution;\n",
    "        self.SINGLE_STEP_EVOLUTION=0;\n",
    "        self.REPEATED_EVOLUTION=1;\n",
    "\n",
    "        # INT CONSTANT TO HANDLE RETURN FROM FUNCTIONS\n",
    "        ###ctypedef unsigned int jump_convergence;\n",
    "        self.JUMP_CONVERGE=0;\n",
    "        self.JUMP=1;\n",
    "        self.NO_JUMP=2;\n",
    "\n",
    "        # INT CONST FOR SN EXPLOSION\n",
    "        ###ctypedef unsigned int sn_explosion;\n",
    "        self.SNIA_EXPLODE=1;\n",
    "        self.SNII_EXPLODE=2;\n",
    "        self.SN_NOT_EXPLODE=0;\n",
    "\n",
    "        # INT CONST FOR RLO\n",
    "        ###ctypedef unsigned int rlo;\n",
    "        self.RLO_FALSE=0; # RLO is happening or happened\n",
    "        self.RLO_TRUE=1; # RLO is happening or happened\n",
    "\n",
    "        # bool CONST FOR BINARY EVOLUTION\n",
    "        ###ctypedef bool bse_evolution;\n",
    "        self.BIN_EV_DONE = 1; # This is the return if the properties of the binary have been evolved with the proper evolve method\n",
    "        self.BIN_EV_NOT_DONE = 0; # This is the return if the properties of the binary have been evolved without the proper evolve method\n",
    "        self.BIN_EV_SETBROKEN = 2; # This is the return if the properties of the binary have not been evolved but a set broken has been called\n",
    "\n",
    "\n",
    "        \n",
    "p = params()\n",
    "\n",
    "print(p.g_to_MSun)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 56,
   "id": "5adc1ce1",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "In file included from /Users/melikakeshavarz/.ipython/cython/_cython_magic_9e5f9e63b0d82b2f36d3e1d8e73cb8eb.c:760:\n",
      "/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h:8:10: fatal error: 'property.h' file not found\n",
      "#include <property.h>\n",
      "         ^~~~~~~~~~~~\n",
      "1 error generated.\n"
     ]
    }
   ],
   "source": [
    "%%cython\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "cdef extern from \"/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h\" namespace \"utilities\":\n",
    "    double maxwellian_cdf(double x, double sigma)\n",
    "    double maxwellian_pdf(double x, double sigma)\n",
    "    double roche_lobe_Eg(double Mass_primary, double Mass_secondary, double a)\n",
    "    double kepler(double ecc, double m, double tol, int maxit)\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "cdef class _u_function:\n",
    "    \n",
    "    def __init__(self):\n",
    "        self.x = \n",
    "    \n",
    "    \n",
    "    \n",
    "\n",
    "     def __cinit__(self, double x, double sigma, double Mass_primary, double Mass_secondary,\n",
    "                   double a, double ecc, double m, double tol, int maxit):\n",
    "            self.pmaxwellian_cdf = maxwellian_cdf(x, sigma)\n",
    "            self.pmaxwellian_cdf = maxwellian_pdf(x, sigma)\n",
    "            self.proche_lobe_Eg = roche_lobe_Eg(Mass_primary, Mass_secondary, a)\n",
    "            self.pkepler= kepler(ecc, m, tol, maxit)\n",
    "\n",
    "            \n",
    "            \n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "319b4aef",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "id": "e7e315e7",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "In file included from /Users/melikakeshavarz/.ipython/cython/_cython_magic_e4a222691808497c2a1797bd61c9dada.c:760:\n",
      "/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h:8:10: fatal error: 'property.h' file not found\n",
      "#include <property.h>\n",
      "         ^~~~~~~~~~~~\n",
      "1 error generated.\n"
     ]
    }
   ],
   "source": [
    "%%cython\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "cdef extern from \"/Users/melikakeshavarz/Desktop/sevndevel/include/general/static_main.h\" namespace \"utilities\":\n",
    "    double maxwellian_cdf(double x, double sigma)\n",
    "    double maxwellian_pdf(double x, double sigma)\n",
    "    double roche_lobe_Eg(double Mass_primary, double Mass_secondary, double a)\n",
    "    double kepler(double ecc, double m, double tol, int maxit)\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "cdef class _u_function:\n",
    "\n",
    "    def pmaxwellian_cdf(self, x, sigma):\n",
    "        return maxwellian_cdf(x,sigma)\n",
    "\n",
    "\n",
    "    def pmaxwellian_pdf(self, x, sigma):\n",
    "        return maxwellian_pdf(x,sigma)\n",
    "\n",
    "\n",
    "    def proche_lobe_Eg(self, Mass_primary, Mass_secondary, a):\n",
    "        return roche_lobe_Eg(Mass_primary, Mass_secondary, a)\n",
    "\n",
    "\n",
    "    def pkepler(self, ecc, m, tol=1e-6, maxit=50):\n",
    "        return kepler(ecc,m,tol,maxit)\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 39,
   "id": "fc042097",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "(None, <pyximport.pyximport.PyxImporter at 0x7fdbb05bee60>)"
      ]
     },
     "execution_count": 39,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pyximport; pyximport.install()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "22fae07c",
   "metadata": {},
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "91f1a41a",
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Error compiling Cython file:\n",
      "------------------------------------------------------------\n",
      "...\n",
      "\n",
      "\n",
      "\n",
      "class uti:\n",
      "    def __cinit__(self):\n",
      "        self.params = _params()\n",
      "                     ^\n",
      "------------------------------------------------------------\n",
      "\n",
      "/Users/melikakeshavarz/.ipython/cython/_cython_magic_a420a20a8b7d9e2582e9dbcbb34351ae.pyx:6:22: undeclared name not builtin: _params\n"
     ]
    }
   ],
   "source": [
    "%%cython\n",
    "class uti:\n",
    "    def __cinit__(self):\n",
    "        self.params = _params()\n",
    "        self.uf = _u_functions()\n",
    "\n",
    "\n",
    "\n",
    "\n",
    "uti = uti()\n",
    "\n",
    "\n",
    "\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "c3f7bfb5",
   "metadata": {},
   "outputs": [
    {
     "ename": "AttributeError",
     "evalue": "'uti' object has no attribute 'params'",
     "output_type": "error",
     "traceback": [
      "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[0;31mAttributeError\u001b[0m                            Traceback (most recent call last)",
      "Cell \u001b[0;32mIn[15], line 1\u001b[0m\n\u001b[0;32m----> 1\u001b[0m \u001b[43muti\u001b[49m\u001b[38;5;241;43m.\u001b[39;49m\u001b[43mparams\u001b[49m\u001b[38;5;241m.\u001b[39mG \u001b[38;5;241m=\u001b[39m \u001b[38;5;241m1\u001b[39m\n",
      "\u001b[0;31mAttributeError\u001b[0m: 'uti' object has no attribute 'params'"
     ]
    }
   ],
   "source": [
    "uti.params.G = 1"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.10.8"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}

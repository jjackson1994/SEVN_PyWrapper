
cdef extern from "../../include/general/static_main.h" namespace "utilities":
 double maxwellian_cdf(double x, double sigma)
 double maxwellian_pdf(double x, double sigma)
 double roche_lobe_Eg(double Mass_primary, double Mass_secondary, double a)
 double kepler(double ecc, double m, double tol, int maxit)



 








def pmaxwellian_cdf(x,sigma):
   return maxwellian_cdf(x,sigma)


def pmaxwellian_pdf(x, sigma):
   return maxwellian_pdf(x,sigma)

def proche_lobe_Eg(Mass_primary, Mass_secondary, a):
   return roche_lobe_Eg(Mass_primary, Mass_secondary, a)


def pkepler(ecc, m, tol=1e-6, maxit=50):
   return kepler(ecc,m,tol,maxit)




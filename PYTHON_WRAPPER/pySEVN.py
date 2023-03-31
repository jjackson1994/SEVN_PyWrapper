#!/usr/bin/env python
# coding: utf-8

# #  Python Wrapper
# 
# This code allows us to run SEVN code from a  simple pythonic interface. The wrapper feeds in all the variables that are used in order to run the sevn.x and sevnB.x files for the single stellar evolution and the binary stellar evolution respectively as well setup and compile the underlying SEVN code for the first time users. 

# ## Python Wrapper: Under the hood (not usually viewed by user)

# ### Set the default model parameters
# For conistency the input varible names used in the Python Wrapper have the same names as that used already in  runscripts, these are translated to the names that the sevn.x and sevnB.x files expect with a python dictionary. 

#### Dictionary mapping between runscript/python names to params in sevnB.x
mappings = {'NTHREADS': 'nthreads','LISTBIN': 'list','IBMODE': 'ibmode','TABLES': 'tables',
 'TABLESHE': 'tables_HE','OMODE': 'omode','OUTPATH': 'o','WINDSMODE': 'wmode','TIDES': 'tmode',
 'GWMODE': 'gwmode','RLMODE': 'rlmode','CIRCMODE': 'circmode','CEMODE': 'cemode','MIXING': 'mixmode','COLLMODE': 'collmode',
 'HARDMODE': 'hardmode','SNORBCHANGE': 'kmode','SNKICKS': 'sn_kicks','SNPISN': 'sn_pairinstability','SNNML': 'sn_neutrinomaloss','SUPERNOVA': 'snmode',
 'BHXSPIN': 'xspinmode','MAXWSDXSPIN': 'xspin_sigma_maxwell','BAVERAXSPIN': 'xspin_bavera','GWTSHOLD': 'gw_tshold','GWONLYBCO': 'gw_onlybco','JTEMAX': 'jtrack_h_err_rel_max',
 'JTMAXDM': 'jtrack_max_dm_factor','JTMAXITER': 'jtrack_max_iteration','JTMINDM': 'jtrack_min_dm_factor','JTDMTSHOLD': 'jtrack_tshold_dm_rel','EDDF': 'eddington_factor','RLOEPSNOVA': 'rlo_eps_nova',
 'RLOMACCR': 'rlo_f_mass_accreted','RLOGAM': 'rlo_gamma_angmom','RLOSTABILITY': 'rlo_stability','RLONTMAX': 'rlo_max_nuclearmt','RLOSMTMS': 'rlo_mtstable_ms','RLOCOLLISION': 'rlo_enable_collision',
 'MCHANDRA': 'sn_Mchandra','SNLOWECSN': 'sn_co_lower_ecsn','SNLOW': 'sn_co_lower_sn','SNLOWECSNHE': 'sn_co_lower_ecsn_pureHe','SNLOWHE': 'sn_co_lower_sn_pureHe','NSMAX': 'sn_max_ns_mass',
 'SNMINVKICK': 'sn_min_vkick','SNVKICKSTD': 'sn_kick_velocity_stdev','NSMASSMEAN': 'sn_Mremnant_average_NS','NSMASSSTD': 'sn_Mremnant_std_NS','WALPHA': 'w_alpha','WBETA': 'w_beta',
 'LITPHASES': 'io_literal_phases','LOGLEVEL': 'log_level','NCHUNK': 'ev_Nchunk','MAXREP': 'ev_max_repetitions','TEND': 'tf','TSTART': 'tini',
 'RSEED': 'rseed','SQHE': 'rlo_QHE','TABCONV': 'tabuse_envconv','TABXSUP': 'tabuse_Xsup','TABINERTIA': 'tabuse_inertia','INERTIAMODE': 'inertiamode',
 'TABRCO': 'tabuse_rhe ','CEALPHA': 'ce_alpha','CEKCE': 'ce_kce','CEKNCE': 'ce_knce','CELAM': 'star_lambda','CELAMHE': 'star_lambda_pureHe',
 'CELAMFTH': 'star_lambda_fth','WRTS': 'star_tshold_WR_envelope','NSMAGTSCALE': 'ns_magnetic_tscale','NSMAGMSCALE': 'ns_magnetic_mscale','SNC25TS': 'sn_compact_csi25_tshold','SNCOMPFB': 'sn_compact_fallback',
 'NAKEDTS': 'ev_naked_tshold','Z ': 'Z','LOGFILE': 'io_logfile','INITERRSTOP': 'initerror_stop','SMAXCO': 'ev_set_maxCO','SMINHE': 'ev_set_minHE',
 'THGHURLEY': 'use_thg_hurley','TSMAXVAR': 'ts_maximum_variation','TSMIN': 'ts_min_dt','TSMAX': 'ts_max_dt','TSSPIN': 'ts_check_spin','TSSPINBIN': 'ts_check_spin_bin',
 'TSNSSPIN': 'ts_check_NSspin','OPTIMISTIC': 'optimistic_scenario_hg','HARDRHOC': 'hard_rhoc','HARDSIGMA': 'hard_sigma','HARDXI': 'hard_xi','HARDKAPPA': 'hard_kappa','HARDMASS': 'hard_mass_average',
 'INTW': 'ev_setwM','INTWLOG': 'ev_setwM_log','INTWPHASE': 'ev_setwM_tphase','CKSTALLING': 'check_stalling', 'DTOUT' : 'dtout'}

path_error = "Please set path to the SEVN folder with set_path('path_to_SEVN')"
py_to_input_dict = {'True' : 'true', 'False' : 'false'}


# ### Python function Definitions:  Set Up Tools

# This a few ease of use tools to check the setup in users SEVN directory, and add the correct lines if needed and also comiple the c++ code.

import os
from datetime import datetime

def set_path(install_path, exe_path = None): 
    import os
    #Maybe write somthing that keeps track of the installation
    global SEVN
    SEVN = install_path
    return SEVN

#SET UP TOOLS--------------------------------
def add_SEVN_path_to_file(file_path): # automatically adds the users SEVN path to given file 
    if 'SEVN' in globals():
        #read 
        f = open(file_path, "r")
        replaced_content = ""
        catch_str = 'SEVN="<Insert absolute SEVNpath>"'
        out_str = 'SEVN="'+SEVN + '" #Complete path to the SEVN folder'
        for line in f:
            if catch_str in line:
                replaced_content += out_str + "\n"
            else:
                replaced_content += line         
        f.close()
        out_f = open(file_path, "w")
        out_f.write(replaced_content)
        out_f.close()

def sevn_compile():
    if 'SEVN' not in globals():print(path_error)
    else: #os.system(os.path.join(SEVN, "compile.sh"))
        from subprocess import run as sp_run
        sp=sp_run(os.path.join(SEVN, "compile.sh"), shell=True, cwd=SEVN)

def check_compile():
    # only runs if not built
    if 'SEVN' in globals() and not os.path.exists(os.path.join(SEVN, 'build')):
        add_SEVN_path_to_file(os.path.join(SEVN, "compile.sh"))
        add_SEVN_path_to_file(os.path.join(SEVN, "run_scripts", "run.sh"))
        add_SEVN_path_to_file(os.path.join(SEVN, "run_scripts", "run_sse.sh"))
        sevn_compile() 
    if 'SEVN' in globals() and os.path.exists(os.path.join(SEVN, 'build')):
        print("SEVN already compiled")
    if 'SEVN' not in globals():print(path_error)


# ### Python function Definitions:  Class Functions

# #### Functions called inside the classes
#Convert between the Standard Python varible values and the c++ input
def var_format(var):
    var=str(var)
    if var in py_to_input_dict:
        var = py_to_input_dict[var]
    return var

# Generate output folder and copy in the launch command and binary ran
def update_outdir(self, launch_time):
    ## create the outpath folder
    source = open(self.EXE, "rb")
    file_name=os.path.basename(self.EXE)
    dest = open(os.path.join(self.output.OUTPATH,file_name), "wb")
    dest.write(source.read())
    source.close()
    dest.close()
    
    # save output comand
    text_file = open(os.path.join(self.output.OUTPATH,"launch_line.txt"), "w")
    text_file.write("[SEVN launch string]:" +self.output.RUNCMD)
    text_file.close()
    print("Directory '%s' created" %self.output.OUTPATH)  


# #### Class methods

#get the launch command list for a set of paramters 
def gen_cmd_list(self):
    if type(self) is dict:param_dict = self
    else: param_dict = vars(self)
    cmd_dict= {key:str(mappings[key]) + " "+ var_format(param_dict[key]) for key in param_dict if key in mappings}
    # Check SCOL, BCOL and NAMEPREX, if they are empty do not add it
    # As they are not in mappings dict add
    if hasattr(self, "SCOL"):#all in same param set
        if isinstance(self.SCOL, str) and self.SCOL: cmd_dict["scol"] = 'scol ' + self.SCOL
        if isinstance(self.BCOL, str) and self.BCOL: cmd_dict["bcol"] = 'bcol ' + self.BCOL
        if isinstance(self.NAMEPREX, str) and self.NAMEPREX !="": cmd_dict["name_prefix"] ="name_prefix " + self.NAMEPREX
    
    #Run script uses 'TABRCO' for'tabuse_rhe' and 'tabuse_rco'
    if hasattr(self, "TABRCO"):  cmd_dict["TABRCO"] = cmd_dict["TABRCO"] +  ' -tabuse_rco ' + var_format(self.TABRCO)
    
    # create the output cmd
    cmd_list= [str(cmd_dict[key]) for key in cmd_dict]
    return cmd_list

#This allows a dictionary to be passed to each class in order to bulk update params
def updater(self, updated_dict):
    current_dict = vars(self)
    for key in updated_dict:
        ### just check they have a correct match
        if key in current_dict:
            setattr(self, key, updated_dict[key])
        else:
            print("WARNING", key, "SKIPPED AS NOT RECOGNISED" )
#Print output  
def printer(self):
    attrs = vars(self)
    try:
        from pprint import pprint
        out_dict = pprint(attrs)
    except:
        print(attrs)


# ### Param Storage Classes

#Parent class that all parameter holding child classes inherit methods defined  
class _section:
    def print_all(self):
        printer(self)    
    def update(self, updated_dict):
        updater(self, updated_dict)    
    def gen_output(self):
        return gen_cmd_list(self)
    
#child classes: here they hold the user input for the run    
class _tables_sse(_section):
    ###set up inputs --------------------
    def __init__(self):
        self.LISTBIN = os.path.join(SEVN,"run_scripts","listStar.dat") #Complete path to input file (list of binaries or single stars)
        self.IBMODE="new" #Input file format for binaries [new*] [legacy] [sevn1]
        self.TABLES = os.path.join(SEVN,"tables","SEVNtracks_parsec_ov05_AGB") #Complete path to look-up tables
        self.TABLESHE = os.path.join(SEVN,"tables", "SEVNtracks_parsec_pureHe36") #Complete path to look-up tables for pure-He stars
        self.TEND="list"
        self.TSTART="list"
        self.RSEED="false"
        
class _tables_bin(_tables_sse):
    def __init__(self):
        super().__init__()
        self.LISTBIN=os.path.join(SEVN,"run_scripts", "listBin.dat")

class _output(_section):
    ###set up inputs --------------------
    def __init__(self):
        #defult can change it for the model if we want
        self.OUTPATH = os.path.join(SEVN,"sevn_output_py") #Complete path to the output folder (the folder will be automatically created or cleaned if it already exists)
        self.OMODE="csv" #Format for output files [h5] [ascii*] [csv]
        self.NAMEPREX=""  #prefix to add to the name of the systems
        self.LOGLEVEL="critical"  #Log output level: [debug] [info] [warning] [error] [critical]
        self.LITPHASES="false" #Use literal phases instead of numbers in output [true] - [false*]
        self.LOGFILE="true" #If true produce the logfile output  [true] - [false*]
        self.SCOL="Mass:MHE:MCO:Radius:Luminosity:Temperature:Phase:RemnantType" #Additional columns to print in the output file for single stellar evolution runs. Default is empty, but any property of single stars can be added (check names in the Property class)
        self.BCOL="Semimajor:Eccentricity:BEvent:BWorldtime" #Additional columns to print in the output file for binary stellar evolution runs. Default is empty, but any property of binary stars can be added (check names in the BinaryProperty class)
        self.RUNCMD = "Not ran yet"

class _prescriptions_sse(_section):
    ###set up inputs --------------------
    def __init__(self):
        self.SNKICKS="unified" #Prescriptions for SN kicks - [unified*] [hobbs] [hobbs_pure] [cc15] [ecus30] [ec15cc265] [zeros]
        self.SNPISN="mapelli20" #Prescription for pair instability SN - [mapelli20*] [iorio22] [iorio22_limited] [farmer19] [disabled]
        self.SNNML="lattimer89" #Prescription for neutrino mass loss in SN - [lattimer89*] [disabled]
        self.SUPERNOVA="list" #Prescription for the SN explosion mechanism - [list*] [rapid] [rapid_gauNS] [delayed] [delayed_gauNS] [compact] [deathmatrix] [directcollapse]
        self.BHXSPIN="disabled"
        
class _prescriptions_bin(_section):
    ###set up inputs --------------------
    def __init__(self):
        self.INDSMODE="hurley" #Prescriptions for wind accretion and the associated orbital changes - [hurley*] [disabled]
        self.TIDES="tides_simple" #Prescriptions for tides - [simple*] [disabled]
        self.GWMODE="peters" #Prescriptions for gravitational-wave decay - [peters*] [disabled]
        self.RLMODE="hurley_rl" #Prescriptions for Roche-Lobe overflow and mass transfer/accretion - [hurley_rl*] [hurley_bse] [disabled]
        self.CIRCMODE="periastron" #Prescriptions for orbit circularisation at onset of RLO - [periastron*] [periastron_full] [angmomg] [semimajor] [disabled]
        self.CEMODE="energy" #Prescriptions for common-envelope evolution - [energy*] [disabled]
        self.MIXING="simple" #Prescriptions  for mixing (merger) - [simple*] [disabled]
        self.COLLMODE="hurley" #Prescriptions for collision at periastron - [hurley*] [disabled]
        self.HARDMODE="disabled" #Prescriptions for hardening in stellar clusters [disabled*] [fastcluster]
        self.SNORBCHANGE="hurley" #Prescriptions for orbital changes after SN kicks - [hurley*] [disabled]
        self.SNKICKS="unified" #Prescriptions for SN kicks - [unified*] [hobbs] [hobbs_pure] [cc15] [ecus30] [ec15cc265] [zeros]
        self.SNPISN="mapelli20" #Prescription for pair instability SN - [mapelli20*] [iorio22] [iorio22_limited] [farmer19] [disabled]
        self.SNNML="lattimer89" #Prescription for neutrino mass loss in SN - [lattimer89*] [disabled]
        self.SUPERNOVA="list" #Prescription for the SN explosion mechanism - [list*] [rapid] [rapid_gauNS] [delayed] [delayed_gauNS] [compact] [deathmatrix] [directcollapse]
        self.BHXSPIN="disabled" #Prescription for the BH spin - [disabled*] [geneva] [mesa] [fuller] [maxwellian] [accretion]l columns to print in the output file for binary stellar evolution runs. Default is empty, but any property of binary stars can be added (check names in the BinaryProperty class)

class _options_sse(_section):
    ###set up inputs --------------------
    def __init__(self):
        self.TABCONV="true" #If true estimate the properties of the convective envelope using the tables (xxxconv.dat)
        self.TABXSUP="false"  #If true use the surface abundance tables (xxxsup.dat)
        self.TABINERTIA="false" #If true estimate the properties of the stellar inerita using the tables (inertia.dat)
        self.TABRHE="true" #If true estimate the properties of the HE core radius using the tables (rhe.dat)
        self.INERTIAMODE="Hurley" #option for inertia estimate when tabuse_inertia is false [*Hurley][DeMink][hspherecore][hsphere]
        self.TABRCO="true" #If true estimate the properties of the CO core radius using the tables (rhe.dat)
        self.THGHURLEY="false" #If true estimate the HG time from the Hurley+00 functional forms instead of using the convective envelope
        self.OPTIMISTIC="false" #If true allow the star in the HG (Hurley phase 2) to start a CE
        
class _options_bin(_section):
    ###set up inputs --------------------
    def __init__(self):
        self.SQHE="false" #If true enable the Quasi Homogeneous Evolution  after a RLO mass transfer following Elrdige&Stanway11
        self.TABCONV="true" #If true estimate the properties of the convective envelope using the tables (xxxconv.dat)
        self.TABXSUP="false"  #If true use the surface abundance tables (xxxsup.dat)
        self.TABINERTIA="false" #If true estimate the properties of the stellar inerita using the tables (inertia.dat)
        self.INERTIAMODE="Hurley" #option for inertia estimate when tabuse_inertia is false [*Hurley][DeMink][hspherecore][hsphere]
        self.TABRHE="true" #If true estimate the properties of the HE core radius using the tables (rhe.dat)
        self.TABRCO="true" #If true estimate the properties of the CO core radius using the tables (rhe.dat)
        self.THGHURLEY="false" #If true estimate the HG time from the Hurley+00 functional forms instead of using the convective envelope
        self.OPTIMISTIC="false" #If true allow the star in the HG (Hurley phase 2) to start a CE

class _params_sse(_section):
    def __init__(self):
        self.MCHANDRA="1.44" #Chandrasekar mass limit for WD formation
        self.SNLOWECSN="1.38" #Minimum value for the CO mass to go ECSN
        self.SNLOW="1.44" #Minimum CO value for the CO mass to go SN (i.e. max CO mass for ECSN)
        self.SNLOWECSNHE="-1"  #Minimum value for the CO mass to go ECSN for pureHe star, if -1 use the same value as H star
        self.SNLOWHE="-1" #Minimum CO value for the CO mass to go SN (i.e. max CO mass for ECSN) for pureHe star, if -1 use the same value as H star
        self.SNC25TS="0.35" #csi25 parameter threshold for explosion/implosion decision, if -1 use a stochastic threshold based on the results of  Patton&Sukhbold20
        self.SNCOMPFB="0.9" #Fallback fraction for implosions in the compact SN option
        self.SNMINVKICK="0.0" #Minimum SN Kick after all the corrections
        self.SNVKICKSTD="265.0" #Standard deviation  of the Maxwellian distribution of kick velocity (Used in the Hobbs and Unified SN kick model)
        #-------WINDS-------#
        self.WALPHA="1.5" #alpha factor to tune the amount of wind accretion (Eq.6 Hurley+02)
        self.WBETA="0.125" #beta factor to tune wind velocity (Eq.9 in Hurley+02)
        #-------CE-------#
        self.CELAM="-1" #if >0 Constant Lambda in binding energy (Eq. 69 in Hurley02). If -1 same Lambda as in BSE (-11 and -12 are other BSE-like variations).
        #-4 Lambda interpolated from Klencki21 (-41 is a variation in which the Lambda is not interpolated but it is "quantised" in bins)
        #-5 Lambda interpolated from  Xu&Li10  (-51 is a variation in which the Lambda is not interpolated but it is "quantised" in bins)
        self.CELAMHE="0.5" #Constant Lambda in binding energy used for pureHe stars(Eq. 69 in Hurley02).
        # Notice: some Lambda model have their own estimate of Lamdba_he (for example option -4), in this case this value is not considered
        self.CELAMFTH="1"  #Fraction of internal energy that goes to the binding energy. Used only if star_lambda<0. Notice that some Lambda models do not include an option for the fraction of internal energu (e.g. option -5)
        #-------NS-------#
        self.NSMAX="3.0" #Maximum NS mass
        self.NSMAGTSCALE="1000" #Magnetic field decay timescale in Myr
        self.NSMAGMSCALE="0.15" #Magnetic field decay mass-scale in Msun
        self.NSMASSMEAN="1.33" #NS masses are drawn from a Gaussian with this mean. Notice, not all the SNMODE options allows to use it
        self.NSMASSSTD="0.09" #NS masses are drawn from a Gaussian with this std. Notice, not all the SNMODE options allows to use it
        #-------BH-------#
        self.MAXWSDXSPIN="0.1" # Standard deviation of the Maxwellian distribution for Xspin - default: 0.1.
        self.BAVERAXSPIN="false" # Bavera correction for the black-hole spin - default: false.
        
class _params_bin(_section): #### paramter def
    def __init__(self):
        #-------GW-------#
        self.GWTSHOLD= "1" #Enable GW decay if GW_time_decay < GWTSHOLD*Hubble_time
        self.GWONLYBCO="false" #If true activate the GW orbital decay on for binary compact objects
        #-------RLO-------#
        self.RLOEPSNOVA="0.001" #Fraction of accreted matter retained in nova eruption
        self.RLOMACCR="0.5" #Fraction of the mass lost by the primary that is accreted onto the secondary during RLO
        self.RLOGAM="-2" #Angular momentum lost during RLO. [-1]: from the primary, [-2]: from the secondary, [>0]: fraction lost from the system
        self.RLOSTABILITY="qcrit_Hradiative_stable"  #"Option for RLO mass transfer stability
        self.RLONTMAX="5"    #Max value of the mass to use in the normalisation of the nuclear mass transfer (Eq. 59 Hurley+02)
        self.RLOCOLLISION="false"  #If true allow collision at periastron during RLO
        self.RLOSMTMS="true"   #If true mass transfer from radiative MS and pureHE MS are always stable
        #-------ACCRETION-------#
        self.EDDF="1" #Eddington factor to limit accretion on a compact object (>1 means super-Eddington)
        #-------SN-------#
        self.MCHANDRA="1.44" #Chandrasekar mass limit for WD formation
        self.SNLOWECSN="1.38" #Minimum value for the CO mass to go ECSN
        self.SNLOW="1.44" #Minimum CO value for the CO mass to go SN (i.e. max CO mass for ECSN)
        self.SNLOWECSNHE="-1"  #Minimum value for the CO mass to go ECSN for pureHe star, if -1 use the same value as H star
        self.SNLOWHE="-1" #Minimum CO value for the CO mass to go SN (i.e. max CO mass for ECSN) for pureHe star, if -1 use the same value as H star
        self.SNC25TS="0.35" #csi25 parameter threshold for explosion/implosion decision, if -1 use a stochastic threshold based on the results of  Patton&Sukhbold20
        self.SNCOMPFB="0.9" #Fallback fraction for implosions in the compact SN option
        self.SNMINVKICK="0.0" #Minimum SN Kick after all the corrections
        self.SNVKICKSTD="265.0" #Standard deviation  of the Maxwellian distribution of kick velocity (Used in the Hobbs and Unified SN kick model)
        #-------WINDS-------#
        self.WALPHA="1.5" #alpha factor to tune the amount of wind accretion (Eq.6 Hurley+02)
        self.WBETA="0.125" #beta factor to tune wind velocity (Eq.9 in Hurley+02)
        #-------CE-------#
        self.CEALPHA="3" #alpha in binding energy (Eq. 73 in Hurley02)
        self.CELAM="-1" #if >0 Constant Lambda in binding energy (Eq. 69 in Hurley02). If -1 same Lambda as in BSE (-11 and -12 are other BSE-like variations).
        #-4 Lambda interpolated from Klencki21 (-41 is a variation in which the Lambda is not interpolated but it is "quantised" in bins)
        #-5 Lambda interpolated from  Xu&Li10  (-51 is a variation in which the Lambda is not interpolated but it is "quantised" in bins)
        self.CELAMHE="0.5" #Constant Lambda in binding energy used for pureHe stars(Eq. 69 in Hurley02).
        # Notice: some Lambda model have their own estimate of Lamdba_he (for example option -4), in this case this value is not considered
        self.CELAMFTH="1"  #Fraction of internal energy that goes to the binding energy. Used only if star_lambda<0. Notice that some Lambda models do not include an option for the fraction of internal energu (e.g. option -5)
        self.CEKCE="1"  #Fraction of non core mass  participating to the CE (e.g. envelope of giants) retained after the CE coalescence.If -1, use a rescaled version of eq. 77 In Hurley
        self.CEKNCE="1" #Fraction of non core mass not participating to the CE (e.g. a MS star) retained after the CE coalescence.If -1, use the eq. 77 in Hurley 2002 (ce_kce is ignored)
        #-------Hardening-------#
        self.HARDRHOC="39900" #central density of the cluster in Msun/pc^3
        self.HARDSIGMA="5" #3D velocity dispersion of the cluster in km/s
        self.HARDXI="3" #xi parameter for fastcluster hardening option (Eq. 11 Mapelli+21)
        self.HARDKAPPA="0.1" #kappa parameter for fastcluster hardening option (Eq. 13 Mapelli+21)
        self.HARDMASS="1" #Average mass of the perturber stars in the environment producing the hardening in Msun
        #-------NS-------#
        self.NSMAX="3.0" #Maximum NS mass
        self.NSMAGTSCALE="1000" #Magnetic field decay timescale in Myr
        self.NSMAGMSCALE="0.15" #Magnetic field decay mass-scale in Msun
        self.NSMASSMEAN="1.33" #NS masses are drawn from a Gaussian with this mean. Notice, not all the SNMODE options allows to use it
        self.NSMASSSTD="0.09" #NS masses are drawn from a Gaussian with this std. Notice, not all the SNMODE options allows to use it
        #-------BH-------#
        self.MAXWSDXSPIN="0.1" # Standard deviation of the Maxwellian distribution for Xspin - default: 0.1.
        self.BAVERAXSPIN="false" # Bavera correction for the black-hole spin - default: false.
                
class _adv_params(_section): #### paramter def
    def __init__(self):
        #Parameters for jumping onto new tracks
        #-------------------------------
        self.JTEMAX="0.005" #Maximum relative error in mass when jumping on a new track
        self.JTMAXDM="1.2" #Maximum new ZAMS tested when jumping on a new track (Mzams_new_max = Mzams_old + JTMAXDM*DM_accreted_or_donated)
        self.JTMINDM="0" #Minimum new ZAMS tested when jumping on a new track (Mzams_new_min = Mzams_old + JTMINDM*DM_accreted_or_donated)
        self.JTMAXITER="10" #Maximum number of iterations for reaching convergence
        self.JTDMTSHOLD="0.01" #Maximum relative change in total mass for not changing track
        # -------------------------------
        #Other parameters
        #-------------------------------
        self.MAXREP="50" #Maximum number of repetitions allowed in the sse and bse. If we reach this number an error is raised
        self.NAKEDTS="1E-4" #Mass difference threshold (Msun) between envelope and core to set a star as nakedHe or nakedCO.
        self.WRTS="0.021" #Relative difference threshold between envelope (Mass-MHE) and total mass to define a star as Wolf Rayet
        self.INITERRSTOP="false" #If true terminate the run when a error on a system initialisation is thrown
        self.SMAXCO="false" #If true the first time a star develops a CO core, we set the maximum CO core Mass for SSE as the last value of the interpolating tracks
        self.SMINHE="false" #If true the first time a star develops a CO core, we set the minimum HE core Mass for SSE as the last value of the interpolating tracks
        # -------------------------------
        #Interpolation
        #-------------------------------
        self.INTW="linear" #Option for setting the weights in the Mass interpolation [*linear][rational][log], Notice for Radius, Inertia and Luminosity it set to log
        self.INTWLOG="log" #Option to set weights for mass interpolation for log properties (i.e. Radius,Luminosity,Inertia) [linear][rational][*log]
        self.INTWPHASE="rational" #Option to set weights for estimating the stellar phases times [linear][*rational][log]
        # -------------------------------
        #Timestep
        #-------------------------------
        self.TSMAXVAR="0.05"  #Relative maximum variation of stellar and binary properties used in the adaptive time step
        self.TSMIN="-1" #Force the adaptive timestep to be larger than this value, it will it has the priority on any other option, -1 means that the option is disabled
        self.TSMAX="-1" #Force the adaptive timestep to be smaller than this value, it has the priority on any other option, -1 means that the option is disabled
        self.TSSPIN="false" #If true take into account the variation (SSE only) of OmegaSpin in the adaptive timestep
        self.TSSPINBIN="false" #If true take into account the variation (BSE only) of OmegaSpin in the adaptive timestep
        self.TSNSSPIN="false" #If true take into account the variation of OmegaRem for NS in the adaptive timestep. It should be set to true if interested on pulsars
        self.CKSTALLING="true" #If true check stalling stars. If the elapsed evolution time is larger than 20s an error is thrown


# ### Define model classes

class sse:       
    def __init__(self):
        if 'SEVN' not in globals():print(path_error)
        self.tables = _tables_sse()
        self.output = _output()
        self.prescriptions = _prescriptions_sse()
        self.options = _options_sse()# cant be smaller 
        self.params = _params_sse()
        self.adv_params = _adv_params()
        self.Z= "list"  #Stellar metallicity - [*list][number]. If list use the Z in the input file otherwise overwrite all the Zs.
        self.runbool= False # keep track if the model has been ran 
        self.EXE = os.path.join(SEVN, "build", "exe", "sevn.x")
        self.output.SCOL='Worldtime:Mass:MHE:MCO:Radius:Luminosity:Temperature:Phase:RemnantType'
        self.output.BCOL="Semimajor:Eccentricity:BEvent" 
        self.tables.LISTBIN = os.path.join(SEVN,"run_scripts","listStar.dat")
        
    def run(self, NTHREADS ="1", #Number of OpenMP threads (1 means no parallel threads, sequential execution)
            NCHUNK = "1000", #Evolve Nchunk at time
            DTOUT="list", #If list use the dtout reported in the input list, otherwise use this value for all the stars and binaries (Can be a number in Myr (e.g. 10), a colon separated sequence in Myr (e.g. 10:100:10 goes from 10 Myr to 10
            PRINTFILE =False): 

        run_dict = {'NTHREADS': str(NTHREADS), 'NCHUNK' : str(NCHUNK),  'DTOUT' : DTOUT}
        # concat the output lists
        F = gen_cmd_list(run_dict) + self.tables.gen_output() + self.output.gen_output() + self.prescriptions.gen_output()         + self.options.gen_output() + self.params.gen_output()+ self.adv_params.gen_output()         + ["Z "+str(self.Z)]
        
        final_cmd = self.EXE + " " + "-"+' -'.join(F)
        self.output.RUNCMD = final_cmd
        launch_time = datetime.now()

        if not os.path.isdir(self.output.OUTPATH):os.mkdir(self.output.OUTPATH)
        print_option = None
        #os.system("cd "+self.output.OUTPATH+"; "+final_cmd + print_option)#SEVN cleans folder automatically  
        from subprocess import run as sp_run, PIPE# more compatable than capture_output
        if PRINTFILE: print_option = PIPE
        print('running')
        sp=sp_run(final_cmd, stdout=print_option, stderr=print_option, shell=True, cwd=self.output.OUTPATH)

        if PRINTFILE: 
            run_output=sp.stdout
            run_error=sp.stderr
            if type(run_output)!=str: run_output=run_output.decode()
            if type(run_error)!=str: run_error=run_error.decode()
            print('RUN output saved to' + str(os.path.join(self.output.OUTPATH, 'run_output.txt')) )
            run_output_path = os.path.join(self.output.OUTPATH, 'run_output.txt')
            run_error_path = os.path.join(self.output.OUTPATH, 'err_output.txt')
            out_f = open(run_output_path, "w")
            out_f.write(run_output)
            out_f.close()
            out_f = open(run_error_path, "w")
            out_f.write(run_error)
            out_f.close()

        update_outdir(self, launch_time)
        self.runbool=True

    def output_df(self):
        if self.runbool:## will make smarter soon
            import pandas as pd ## on
            df = pd.read_csv(os.path.join(self.output.OUTPATH, 'output_0.csv'), sep=",")
            return df
        else:
            print("Must run first")
            
    ## this is pretty printed which makes it a string 
    def print_all(self):
        class_dict=vars(self)
        out_dict ={}
        for key in class_dict:
            if hasattr(class_dict[key], 'update'):
                out_dict[key] = vars(class_dict[key])
            if isinstance(class_dict[key], str):
                out_dict[key] = class_dict[key]            
        ### just to make the dictionary nice 
        try:
            from pprint import pprint
            out_dict = pprint(out_dict)
        except:
            print(out_dict)
                
    def get_dict(self):
        class_dict=vars(self)
        out_dict ={}
        for key in class_dict:
            if hasattr(class_dict[key], 'update'):
                out_dict[key] = vars(class_dict[key])
            if isinstance(class_dict[key], str):
                out_dict[key] = class_dict[key]
        return out_dict 
        
    def update(self, updated_dict):## allows meany simple ways to update
        if isinstance(updated_dict, str):eval(updated_dict)# can update from pretty print
        updated_dict= dict(updated_dict)
        class_dict = vars(self)
        out_dict = {}
        
        #This can both find and update the correct subclass attribute in order to be easier for users
        for key in updated_dict:
            if key in class_dict: ##check if dict macthes the subclass
                if hasattr(class_dict[key], 'update'):
                    class_dict[key].update(updated_dict[key])
                if isinstance(updated_dict, str):
                    setattr(self, key, updated_dict[key])
                
            for class_key in class_dict: ## loop all class elements
                if hasattr(class_dict[class_key], 'update'): # check if is subclass
                    subclass_dict= vars(class_dict[class_key])
                    if key in subclass_dict:## need a cleaner way to acesss subclass
                        eval_str = "self."+class_key+"."+key+" = "+'str(updated_dict[key])'
                        #sub_class_attr= getattr(self, class_key)
                        exec(eval_str)

class binary(sse):
    def __init__(self):
        if 'SEVN' not in globals():print(path_error)
        sse.__init__(self)
        self.tables = _tables_bin()
        self.output = _output()
        self.prescriptions = _prescriptions_bin()
        self.options = _options_bin()
        self.params = _params_bin()
        self.adv_params = _adv_params()
        self.Z= "list"  #Stellar metallicity - [*list][number]. If list use the Z in the input file otherwise overwrite all the Zs.
        self.runbool= False # keep track if the model has been ran 
        self.EXE = os.path.join(SEVN,"build","exe","sevnB.x")

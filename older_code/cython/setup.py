from distutils.core import setup, Extension
from Cython.Build import cythonize
import glob

src_files=glob.glob("../../src/*.cpp",recursive=True)+\
          glob.glob("../../src/binstar/*.cpp",recursive=True)+ \
          glob.glob("../../src/binstar/procs/*.cpp",recursive=True)+ \
          glob.glob("../../src/general/*.cpp",recursive=True)+\
          glob.glob("../../src/general/utils/*.cpp",recursive=True)+\
          glob.glob("../../src/star/*.cpp",recursive=True)+\
          glob.glob("../../src/star/lambdas/*.cpp",recursive=True)+\
          glob.glob("../../src/star/procs/*.cpp",recursive=True)+\
          glob.glob("../../src/star/procs/*/*.cpp",recursive=True)


ext= Extension("SEVNpy",sources=["cython_wrapper.pyx",]+src_files,
               language="c++",
               extra_compile_args=["-std=c++11"],
               extra_link_args=["-std=c++11"],
               include_dirs = ['../../include','../../include/star','../../include/star/lambdas',
                               '../../include/star/procs/kicks','../../include/star/procs/neutrinomassloss','../../include/star/procs/pairinstability',
                                '../../include/star/procs/supernova',
                               '../../include/general/utils','../../include/general/','../../include/binstar/procs',
                               '../../include/star/lambdas','../../include/star/procs','../../include/binstar'])

""""
ext = Extension("SEVNpy",sources=["cython_wrapper.pyx","../../src/general/utils/utilities.cpp",
                                  "../../src/binstar/Processes.cpp","../../src/binstar/Orbit.cpp",
                                  "../../src/general/lookup_and_phases.cpp","../../src/general/utils/evolve.cpp",
                                  "../../src/general/IO.cpp","../../src/general/utils/sevnlog.cpp",
                                  "../../src/star/star.cpp","../../src/star/remnant.cpp",
                                  "../../src/star/procs/kicks.cpp","../../src/star/procs/supernova.cpp",
                                  "../../src/star/lambdas/lambda_nanjing.cpp","../../src/star/lambdas/lambda_klencki21.cpp",
                                  "../../src/star/property.cpp",
                                  "../../src/binstar/qcrit.cpp","../../src/binstar/binstar.cpp",
                                  "../../src/binstar/BinaryProperty.cpp", "../../src/binstar/MTstability.cpp",
                                  "../../src/general/params.cpp"],
                language="c++",
                include_dirs = ['../../include','../../include/star','../../include/general/utils','../../include/general/',
                                '../../include/star/lambdas','../../include/star/procs','../../include/binstar','../../include/h5out'])
"""

setup(name="SEVNpy",ext_modules=cythonize(ext,compiler_directives={'language_level' : "3"}))
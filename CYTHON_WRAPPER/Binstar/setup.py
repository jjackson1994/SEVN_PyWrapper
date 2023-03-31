from distutils.core import setup, Extension
from Cython.Build import cythonize
import glob

path = "/Users/melikakeshavarz/Desktop/sevndevel"

src_files=glob.glob(path+"/src/*.cpp",recursive=True)+\
          glob.glob(path+"/src/binstar/*.cpp",recursive=True)+ \
          glob.glob(path+"/src/binstar/procs/*.cpp",recursive=True)+ \
          glob.glob(path+"/src/general/*.cpp",recursive=True)+\
          glob.glob(path+"/src/general/utils/*.cpp",recursive=True)+\
          glob.glob(path+"/src/star/*.cpp",recursive=True)+\
          glob.glob(path+"/src/star/lambdas/*.cpp",recursive=True)+\
          glob.glob(path+"/src/star/procs/*.cpp",recursive=True)+\
          glob.glob(path+"/src/star/procs/*/*.cpp",recursive=True)


ext= Extension("Binstar",sources=["Binstar.pyx"]+src_files,
               language="c++",
               extra_compile_args=["-std=c++11"],
               extra_link_args=['-std=c++11'],
               include_dirs = [path +'/include',path+'/include/star',path +'/include/star/lambdas',
                               path +'/include/star/procs/kicks',path +'/include/star/procs/neutrinomassloss',path +'/include/star/procs/pairinstability',
                               path + '/include/star/procs/supernova',
                               path +'/include/general/utils',path +'/include/general/',path +'/include/binstar/procs',
                               path +'/include/star/lambdas',path +'/include/star/procs',path +'/include/binstar'])



setup(name="Binstar",ext_modules=cythonize(ext,compiler_directives={'language_level' : "3"}))

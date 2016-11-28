
QT       -= core gui

TARGET = HelloGPUMaya
macx:TARGET = HelloGPUMaya.bundle

SOURCES += src/*.cpp
HEADERS += include/*.h

INCLUDEPATH += include/

OBJECTS_DIR = obj

DEFINES +=  REQUIRE_IOSTREAM \
            _BOOL

MAYALIBS =  -lOpenMaya \
            -lFoundation


QMAKE_CFLAGS += -fPIC
QMAKE_CXXFLAGS += -fPIC


# --------------------------------------------------
# LINUX specific stuff
# --------------------------------------------------
linux-g++*:MAYALOCATION = /usr/autodesk/maya2016/
linux-g++*:MAYADEVKIT = /public/devel/2015/mayaDevkit_2016
linux-g++*:TEMPLATE = lib
linux-g++*:INCLUDEPATH += $$MAYALOCATION/include $$MAYADEVKIT/include
linux-g++*:LIBS += -L$$MAYALOCATION/lib $$MAYALIBS
linux-g++*:DEFINES += linux


# --------------------------------------------------
# MAC specific stuff
# --------------------------------------------------
macx:MAYALOCATION = /Applications/Autodesk/maya2017
macx:CONFIG -=  app_bundle
macx:INCLUDEPATH += $$MAYALOCATION/devkit/include
macx:LIBS += -bundle
mac:LIBS -= -dynamiclib
macx:LIBS += -L$$MAYALOCATION/Maya.app/Contents/MacOS $$MAYALIBS
macx:DEFINES += OSMac_


# --------------------------------------------------
# WINDOWS specific stuff - TODO
# --------------------------------------------------



#--------------------------------------------------------------------------
# CUDA stuff
#--------------------------------------------------------------------------
# Make cuda files appear in project
HEADERS += $$PWD/cuda_inc/*.cuh
INCLUDEPATH += $$PWD/cuda_inc
CUDA_SOURCES += $$PWD/cuda_src/*.cu
CUDA_PATH = /usr
NVCC = $$CUDA_PATH/bin/nvcc -ccbin g++

SYSTEM_NAME = unix
SYSTEM_TYPE = 64
GENCODE_FLAGS += -arch=sm_50
NVCC_OPTIONS = --use_fast_math

# include paths
INCLUDEPATH += $(CUDA_PATH)/include/cuda

# library directories
QMAKE_LIBDIR += $$CUDA_PATH/lib/x86_64-linux-gnu

CUDA_OBJECTS_DIR = $$PWD/cuda_obj

# The following makes sure all path names (which often include spaces) are put between quotation marks
CUDA_INC = $$join(INCLUDEPATH,' -I','-I','')
LIBS += -lcudart -lcurand

cuda.input = CUDA_SOURCES
cuda.output = $$CUDA_OBJECTS_DIR/${QMAKE_FILE_BASE}_cuda.o
cuda.commands = $$NVCC -m$$SYSTEM_TYPE $$GENCODE_FLAGS -c -o ${QMAKE_FILE_OUT} ${QMAKE_FILE_NAME} $$NVCC_OPTIONS $$CUDA_INC -Xcompiler '-fPIC'
cuda.dependency_type = TYPE_C
QMAKE_EXTRA_COMPILERS += cuda

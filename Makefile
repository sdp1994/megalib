#------------------------------------------------------------------------------
#
#  Makefile for MEGAlib
#
#  Author: Andreas Zoglauer
#
#------------------------------------------------------------------------------



#------------------------------------------------------------------------------
# Program and directories

SHELL=/bin/bash

# Basic directories
TOP	= $(shell pwd)
SR	= $(TOP)/src
IN	= $(TOP)/include
LB	= $(TOP)/lib
BN	= $(TOP)/bin
HT	= $(TOP)/doc/html
CT	= $(TOP)/cint
CF	= $(TOP)/config

#------------------------------------------------------------------------------
# Included options (result of ./configure)

include $(TOP)/config/Makefile.options
include $(TOP)/config/Makefile.config
include $(TOP)/config/Makefile.user

CXXFLAGS    += -I$(IN)
LDFLAGS     += -L$(LB)


#------------------------------------------------------------------------------
# Commands:

CMD=

#.NOPARALLEL:
.EXPORT_ALL_VARIABLES: all copy miw geo geolib
.SILENT:
.NOTPARALLEL: info glo geo spe miw rev siv res mim evi meg her bm cal add cos 
.SUFFIXES:
.SUFFIXES: .cxx .h .o .so

all: info link only

only: info glo geo spe rev siv res mim evi rea add cos 
hardware: info glo meg her bm cal add
simulation: info glo geo siv cos
imaging: info glo geo spe siv rev mim evi res 


#------------------------------------------------------------------------------
# Version check:

ROOTVERSIONOK   = $(shell bash $(CF)/configure_rootversiontest )
GEANT4VERSIONOK = $(shell bash $(CF)/configure_geant4versiontest )


#------------------------------------------------------------------------------
# Global library:

info:
ifneq ($(strip $(ROOTVERSIONOK)),)
	echo "$(ROOTVERSIONOK)"
	exit 1;		
endif
ifeq "$(strip $(GEANT4INSTALLED))" "0"
ifneq ($(strip $(GEANT4VERSIONOK)),)
	echo "$(GEANT4VERSIONOK)"
	exit 1;		
endif
endif
	echo "MEGAlib compilation mode: $(CMODE)"

global: info glo 

glo: link 
	$(MAKE) glo -C src

clean_globalmisc:
	@$(MAKE) clean_glomisc -C src

clean_globalgui:
	@$(MAKE) clean_glogui -C src


#------------------------------------------------------------------------------
# Addon

ADDONLIBS = \
	-lCommonGui \
	-lCommonMisc \

addon: info add

add: link glo geolib spelib revlib sivlib mimlib mim rev
	@$(MAKE) add -C src

clean_addon:
	@$(MAKE) clean_add -C src


#------------------------------------------------------------------------------
# Megalyze

MEGALYZELIBS = \
	-lCommonGui \
	-lCommonMisc \
	-lMegalyzeGui \
	-lMegalyzeDaq \
	-lMegalyzeHardware \
	-lMegalyzeInterface \

#	$(LB)/MMain.o \

megaylze: info meg
	@$(BN)/megalyze $(CMD)

megalyze: info meg
	@$(BN)/megalyze $(CMD)

meg: link glo
	@$(MAKE) meg -C src

clean_megalyze:
	@$(MAKE) clean_meg -C src


#------------------------------------------------------------------------------
# Geomega

GEOMEGALIBS = \
	$(LB)/MGeomegaMain.o \
	-lGeomegaGui \
	-lGeomega \
	-lCommonGui \
	-lCommonMisc \

geomega: info geo
	@$(BN)/geomega $(CMD)

geolib: link glo
	@$(MAKE) geolib -C src

geo: link glo
	@$(MAKE) geo -C src

clean_geomega:
	@$(MAKE) clean_geo -C src


#------------------------------------------------------------------------------
# Eview

EVIEWLIBS = \
	$(LB)/MEviewMain.o \
	-lEviewGui \
	-lRevan \
	-lRevanGui \
	-lSpectralyze \
	-lSpectralyzeGui \
	-lGeomega \
	-lCommonMisc \
	-lCommonGui \

evi: link glo rev geolib
	@$(MAKE) evi -C src

eview: info evi
	@$(BN)/eview $(CMD)

clean_eview:
	@$(MAKE) clean_evi -C src


#------------------------------------------------------------------------------
# Spectralyzer:

SPECTRALYZELIBS = \
	$(LB)/MSpectralyzerMain.o \
	-lSpectralyzeGui \
	-lSpectralyze \
	-lCommonMisc \
	-lCommonGui \
	-lGeomega \

spectralyze: info spe
	@$(BN)/spectralyze $(CMD)

spelib: link glo geolib
	@$(MAKE) spelib -C src
	
spe: link glo geolib
	@$(MAKE) spe -C src

clean_spectralyze:
	@$(MAKE) clean_spe -C src


#------------------------------------------------------------------------------
# Mimrec:

MIMRECLIBS = \
	$(LB)/MMimrecMain.o \
	-lMimrecGui \
	-lMimrec \
	-lSpectralyze \
	-lSpectralyzeGui \
	-lCommonMisc \
	-lCommonGui \
	-lGeomega \

mimrec: info mim
	@$(BN)/mimrec $(CMD)

mimlib: link glo geolib spelib
	@$(MAKE) mimlib -C src

mim: link glo geolib spelib
	@$(MAKE) mim -C src

clean_mimrec:
	@$(MAKE) clean_mim -C src


#------------------------------------------------------------------------------
# Sivan:

SIVANLIBS = \
	$(LB)/MSivanMain.o \
	-lSivanGui \
	-lSivan \
	-lGeomega \
	-lCommonMisc \
	-lCommonGui \
#	-lMimrec \

sivan: info siv
	@$(BN)/sivan $(CMD)

siv: link glo geolib
	@$(MAKE) siv -C src

sivlib: link glo geolib
	@$(MAKE) sivlib -C src

clean_sivan:
	@$(MAKE) clean_siv -C src


#------------------------------------------------------------------------------
# Revan:

REVANLIBS = \
	$(LB)/MRevanMain.o \
	-lRevanGui \
	-lRevan \
	-lGeomega \
	-lSpectralyze \
	-lSpectralyzeGui \
	-lCommonMisc \
	-lCommonGui \

revan: info rev
	@$(BN)/revan $(CMD)

revlib: link glo geolib spelib
	@$(MAKE) revlib -C src

rev: link glo spe geolib spelib
	@$(MAKE) rev -C src

clean_revan:
	@$(MAKE) clean_rev -C src


#------------------------------------------------------------------------------
# Cosima:

COSIMALIBS = \
	-lGeomega \
	-lSivan \
	-lCommonMisc \
	-lCommonGui \

cosima: info cos
ifeq "$(strip $(GEANT4INSTALLED))" "0"
	@echo "Launching cosima..."
	@$(BN)/cosima $(CMD)
else 
	@echo "Geant4 not installed, cannot launch cosima..."
endif

cos: link glo geolib sivlib
	@$(MAKE) cos -C src

clean_cosima:
	@$(MAKE) clean_cos -C src


#------------------------------------------------------------------------------
# Addon

RESPONSELIBS = \
	-lCommonMisc \
	-lCommonGui \
	-lGeomega \
	-lRevan \
	-lMimrec \
	-lSivan \
	-lSpectralyze \

response: info res

res: link glo geolib revlib sivlib spelib mimlib mim rev
	@$(MAKE) res -C src

clean_response:
	@$(MAKE) clean_res -C src


#------------------------------------------------------------------------------
# Herty:

HERTYLIBS = \
	$(LB)/MHertyMain.o \
	-lHertyGui \
	-lCommonMisc \
	-lCommonGui \

herty: info her
	@$(BN)/herty

herlib: link glo
	@$(MAKE) herlib -C src

her: link glo geolib
	@$(MAKE) her -C src

clean_herty:
	@$(MAKE) clean_her -C src


#------------------------------------------------------------------------------
# Realta:

REALTALIBS = \
	-lRealtaGui \
	-lRealta \
	-lGeomega \
	-lSivan \
	-lRevan \
	-lRevanGui \
	-lMimrec \
	-lMimrecGui \
	-lSpectralyze \
	-lSpectralyzeGui \
	-lCommonMisc \
	-lCommonGui \

realta: info rea 
	@$(BN)/realta

rea: link glo rev mim spe siv geolib spelib
	@$(MAKE) rea -C src

clean_realta:
	@$(MAKE) clean_rea -C src



#------------------------------------------------------------------------------
# MIWorks:

MIWORKSLIBS = \
	$(LB)/MIWorksMain.o \
	-lMiworksGui \
	-lCommonMisc \
	-lCommonGui \

miworks: info glo miw
	@$(BN)/miworks $(CMD)

miw: link glo
	@$(MAKE) miw -C src

clean_miworks:
	@$(MAKE) clean_miw -C src



#------------------------------------------------------------------------------
# BeamMonitor:

BMLIBS = \
	$(LB)/MBMMain.o \
	-lBeamMonitor \
	-lCommonMisc \
	-lCommonGui \
	-lMegalyze

beammonitor: info bm
	@$(BN)/BeamMonitor $(CMD)

bm: link glo meg
	@$(MAKE) bm -C src

clean_bm:
	@$(MAKE) clean_bm -C src



#------------------------------------------------------------------------------
# Calibration:

CALLIBS = \
	-lCommonMisc\
	-lMegalyzeDaq\
	-lMegalyzeHardware\
	-lMegalyzeInterface\
	-lMegalyzeGui \
	-lCommonGui

calibration: info cal
	@$(BN)/CalibCsISingle $(CMD)

cal: link glo meg 
	@$(MAKE) cal -C src

clean_cal:
	@$(MAKE) clean_cal -C src



#------------------------------------------------------------------------------
# additional options:

link:
	$(MAKE) -s link -C src 

clean:
	@$(MAKE) -s clean -C src 
	@rm -f $(LB)/*.o
	@rm -f $(LB)/*.$(DLL)
ifneq ($(DLL),so)
	@rm -f $(LB)/*.so
endif
	@rm -f $(LB)/*Cint*
	@rm -rf $(LB)/*SunWS_cache*
	@rm -f *~
	@rm -f \#*
	@rm -f $(IN)/*.h

html: man
doxygen: man

man:
	@rm -rf $(HT)
	@sh resource/doxy
	@doxygen resource/Doxyfile

update:
	@bash config/configure_update
	@if ( `test -f config/configure_lastgoodoptions` ); then bash configure `cat config/configure_lastgoodoptions`; $(MAKE) all; else echo "MEGAlib updated. Please reconfigure and compile!"; fi 

changelog:
	@sh bin/changelog.sh
	@less doc/ChangeLog


STANDARDTAREXCLUDE="--exclude=*.tgz --exclude=*.fits --exclude=*.pdf --exclude=*.o --exclude=*.so --exclude=*.tar --exclude=*.tra --exclude=*.sim --exclude=*.SIM --exclude=*.evta --exclude=*.pev --exclude=*~ --exclude=\#* --exclude=*SunWS_cache* --exclude=*.evta.gz  --exclude=*.rawa.gz --exclude=*.sim.gz --exclude=*.uevta --exclude=*.calib --exclude=*.rawa --exclude=*.house --exclude=CommandLog.txt --exclude=doc/html --exclude=revan --exclude=megalyze --exclude=sivan --exclude=mimrec "

extract_geomega:
	@echo "Extracting all files necessary for geomega"
	@echo "Make sure you do this only on a newly checked-out version!"
	@echo "Generating file: MEGAlib.$(shell date +'%d%m%y.%H%M').tgz"
	@cd ..; tar cvfz MEGAlib.$(shell date +'%d%m%y.%H%M').tgz $(STANDARDTAREXCLUDE) --exclude=src/addon --exclude=src/beammonitor  --exclude=src/calibration  --exclude=src/eview --exclude=src/herty --exclude=src/megalyze --exclude=src/mimrec --exclude=src/miworks --exclude=src/realta --exclude=src/response --exclude=src/revan --exclude=src/sivan --exclude=*/CVS MEGAlib

MEGALIBDIRNAME=$(shell cd ..; if ( test -L MEGAlib ); then echo `readlink MEGAlib`; else echo "MEGAlib"; fi; )

backup:
	@echo "Generating backup file: MEGAlib.$(shell date +'%d%m%y.%H%M').tgz"
	@cd ..; tar cvfz MEGAlib.$(shell date +'%d%m%y.%H%M').tgz $(MEGALIBDIRNAME)

TAROPT="


#
#------------------------------------------------------------------------------



#FILENAME:	Makefile
#USAGE:		Top Makefile
#Version:	$Revision: 1.11 $
#Modified By:	$Author: mooney $
#Last Modified:	$Date: 2004-03-05 17:38:46 $
#NOTES- The "DIRS" order is based on compile time dependencies.
#     - The user must modify SUPPORT for local configuration.
#     - Pointing the CONFIG macro to a different config directory
#	supports multiple configurations in the same support
#	directory.
#     - Support modules can be shared between configurations only if
#	dependencies are not violated.  Only the "DIRS" are the target of
#	gnumake.  If this configuration is using a support module built by
#	another configuration, then the	DIRS line for that support module must
#	be commented out (i.e, must begin with a '#') and the 'include',
#	'RELEASE_FILES' and 'MASTER_FILES' lines must be uncommented (i.e.,
#	the '#' must be removed).

SUPPORT = /home/oxygen/MOONEY/epics/synApps_4_6/support
CONFIG = config

include $(SUPPORT)/$(CONFIG)/RELEASE
include $(EPICS_BASE)/config/CONFIG_COMMON
include $(SUPPORT)/$(CONFIG)/CONFIG

include $(SUPPORT)/$(CONFIG)/VXSTATS_RELEASE
DIRS += $(VXSTATS)
RELEASE_FILES += $(VXSTATS)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/VXSTATS_RELEASE

include $(SUPPORT)/$(CONFIG)/SNCSEQ_RELEASE
DIRS += $(SNCSEQ)
RELEASE_FILES += $(SNCSEQ)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/SNCSEQ_RELEASE

#include $(SUPPORT)/$(CONFIG)/ALLEN_BRADLEY_RELEASE
#DIRS += $(ALLEN_BRADLEY)
#RELEASE_FILES += $(ALLEN_BRADLEY)/config/RELEASE
#MASTER_FILES  += $(SUPPORT)/$(CONFIG)/ALLEN_BRADLEY_RELEASE

#include $(SUPPORT)/$(CONFIG)/BITBUS_RELEASE
#DIRS += $(BITBUS)
#RELEASE_FILES += $(BITBUS)/config/RELEASE
#MASTER_FILES  += $(SUPPORT)/$(CONFIG)/BITBUS_RELEASE

include $(SUPPORT)/$(CONFIG)/IPAC_RELEASE
DIRS += $(IPAC)
RELEASE_FILES += $(IPAC)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/IPAC_RELEASE

include $(SUPPORT)/$(CONFIG)/ASYN_RELEASE
DIRS += $(ASYN)
RELEASE_FILES += $(ASYN)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/ASYN_RELEASE

include $(SUPPORT)/$(CONFIG)/MPF_RELEASE
DIRS += $(MPF)
RELEASE_FILES += $(MPF)/configure/RELEASE
MASTER_FILES +=  $(SUPPORT)/$(CONFIG)/MPF_RELEASE

include $(SUPPORT)/$(CONFIG)/GPIBCORE_RELEASE
DIRS += $(GPIBCORE)
RELEASE_FILES += $(GPIBCORE)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/GPIBCORE_RELEASE

#include $(SUPPORT)/$(CONFIG)/MPFSERIAL_RELEASE
#DIRS += $(MPF_SERIAL)
#RELEASE_FILES += $(MPF_GPIB)/config/RELEASE
#MASTER_FILES  += $(SUPPORT)/$(CONFIG)/MPFSERIAL_RELEASE

include $(SUPPORT)/$(CONFIG)/MOTOR_RELEASE
DIRS += $(MOTOR)
RELEASE_FILES += $(MOTOR)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/MOTOR_RELEASE

include $(SUPPORT)/$(CONFIG)/STD_RELEASE
DIRS += $(STD)
RELEASE_FILES += $(STD)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/STD_RELEASE

include $(SUPPORT)/$(CONFIG)/VME_RELEASE
DIRS += $(VME)
RELEASE_FILES += $(VME)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/VME_RELEASE

include $(SUPPORT)/$(CONFIG)/CALC_RELEASE
DIRS += $(CALC)
RELEASE_FILES += $(CALC)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/CALC_RELEASE

include $(SUPPORT)/$(CONFIG)/SSCAN_RELEASE
DIRS += $(SSCAN)
RELEASE_FILES += $(SSCAN)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/SSCAN_RELEASE

include $(SUPPORT)/$(CONFIG)/OPTICS_RELEASE
DIRS += $(OPTICS)
RELEASE_FILES += $(OPTICS)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/OPTICS_RELEASE

include $(SUPPORT)/$(CONFIG)/AUTOSAVE_RELEASE
DIRS += $(AUTOSAVE)
RELEASE_FILES += $(AUTOSAVE)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/AUTOSAVE_RELEASE

include $(SUPPORT)/$(CONFIG)/DAC128V_RELEASE
DIRS += $(DAC128V)
RELEASE_FILES += $(DAC128V)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/DAC128V_RELEASE

include $(SUPPORT)/$(CONFIG)/IPUNIDIG_RELEASE
DIRS += $(IPUNIDIG)
RELEASE_FILES += $(IPUNIDIG)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/IPUNIDIG_RELEASE

include $(SUPPORT)/$(CONFIG)/LOVE_RELEASE
DIRS += $(LOVE)
RELEASE_FILES += $(LOVE)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/LOVE_RELEASE

include $(SUPPORT)/$(CONFIG)/MCA_RELEASE
DIRS += $(MCA)
RELEASE_FILES += $(MCA)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/MCA_RELEASE

#include $(SUPPORT)/$(CONFIG)/CAMAC_RELEASE
#DIRS += $(CAMAC)
#RELEASE_FILES += $(CAMAC)/configure/RELEASE
#MASTER_FILES  += $(SUPPORT)/$(CONFIG)/CAMAC_RELEASE

include $(SUPPORT)/$(CONFIG)/IP330_RELEASE
DIRS += $(IP330)
RELEASE_FILES += $(IP330)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/IP330_RELEASE

include $(SUPPORT)/$(CONFIG)/IP_RELEASE
DIRS += $(IP)
RELEASE_FILES += $(IP)/configure/RELEASE
MASTER_FILES  += $(SUPPORT)/$(CONFIG)/IP_RELEASE

DIRS += $(SUPPORT)/xxx
RELEASE_FILES += $(SUPPORT)/xxx/configure/RELEASE

all install clean rebuild inc depends build uninstall release::
	@$(PERL) makeReleaseConsistent.pl $(SUPPORT) $(EPICS_BASE) $(MASTER_FILES) $(RELEASE_FILES)

include $(SUPPORT)/$(CONFIG)/RULES_DIRS

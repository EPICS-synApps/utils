#Makefile at top of application tree (above all tops)
TOP = .
include $(TOP)/config/CONFIG_APP

#DIRS += allenBradley1-3
DIRS += bitBus1-4
DIRS += ipac2-3
DIRS += mpf1-7
DIRS += mpfSerial1-3
DIRS += mpfGpib1-4
DIRS += motor4-4
DIRS += std1-1
DIRS += dac128V1-1
DIRS += ipUnidig1-1
DIRS += love1-1
DIRS += mca5-1
DIRS += ip3301-3
DIRS += ip1-1
#DIRS += camac1-1
#DIRS += xxx

include $(TOP)/config/RULES_TOP

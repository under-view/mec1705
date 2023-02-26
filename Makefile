MODULE_NAME = mec1705

ASL ?= iasl
ASL_FLAGS ?=
ASL_FNAME = $(MODULE_NAME).asl
AML_FNAME = $(MODULE_NAME).aml

ifneq ($(KERNELRELEASE),)
	obj-m := $(MODULE_NAME)-espi.o
else
	KSRC ?= $(PWD)
endif

# Bootlin Explanation
# The module Makefile is initially interpreted with KERNELRELEASE undefined, so
# it calls the kernel Makefile, passing the module directory in the M variable
# The kernel Makefile knows how to compile a module, and thanks to the M
# variable, knows where the Makefile for our module is. This module Makefile is
# then interpreted with KERNELRELEASE defined, so the kernel sees the obj-m
# definition.

all:
	$(MAKE) -C $(KSRC) M=$$PWD

aml:
	$(ASL) $(PWD)/$(ASL_FNAME)

clean:
	$(RM) $(PWD)/*.o
	$(RM) $(PWD)/*.ko
	$(RM) $(PWD)/*.order
	$(RM) $(PWD)/*.symvers
	$(RM) $(PWD)/*.mod*
	$(RM) $(PWD)/.mod*
	$(RM) $(PWD)/.Mod*
	$(RM) $(PWD)/.$(MODULE_NAME)*
	$(RM) $(PWD)/*.aml

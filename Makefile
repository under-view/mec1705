MODULE_NAME = mec1705

ASL ?= iasl
ASL_FLAGS ?=
ASL_FNAME = $(MODULE_NAME).asl
AML_FNAME = $(MODULE_NAME).aml

all: aml

aml:
	$(ASL) $(PWD)/$(ASL_FNAME)

clean:
	$(RM) $(PWD)/*.aml

#!/bin/bash

DEVUTILS_DIR=$(dirname "${BASH_SOURCE[0]}")

alias compile_mec1705_aml="make -C ${DEVUTILS_DIR}/../ aml"
alias load_mec1705_aml="mkdir -p /sys/kernel/config/acpi/table/mec1705; cat ${DEVUTILS_DIR}/../mec1705.aml > /sys/kernel/config/acpi/table/mec1705/aml"
alias unload_mec1705_aml="${DEVUTILS_DIR}/unload-acpi-table /sys/kernel/config/acpi/table/mec1705"

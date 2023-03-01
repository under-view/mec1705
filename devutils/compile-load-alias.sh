#!/bin/bash

MEC1705_DEVUTILS_DIR=$(dirname $(realpath "${BASH_SOURCE[0]}"))

alias mount_enable_acpi_configfs="mount -t configfs none /sys/kernel/config 2>/dev/null && modprobe acpi-configfs"
alias compile_mec1705_aml="make -C ${MEC1705_DEVUTILS_DIR}/../ aml"
alias load_mec1705_aml="mkdir -p /sys/kernel/config/acpi/table/mec1705; cat ${MEC1705_DEVUTILS_DIR}/../mec1705.aml > /sys/kernel/config/acpi/table/mec1705/aml"
alias unload_mec1705_aml="${MEC1705_DEVUTILS_DIR}/unload-acpi-table /sys/kernel/config/acpi/table/mec1705"

# MEC1705

ACPI Table for the MEC1705 EC

**Compile ASL**
```sh
$ make aml
```

**Testing AML file**
```sh
# First Gather, Extract, & Disassemble ACPI Tables
$ acpidump > acpi.log
$ acpixtract acpi.log

# To get source of all DSDT/SSDT
$ iasl -d *.dat > /dev/null 2>&1

# Execute
$ acpiexec *.{dat,aml}
```

SSDT overlays: Run-time ConfigFS approach

```sh
# Mount ConfigFS
$ mount -t configfs none /sys/kernel/config

# Load ACPI ConfigFS support (if it’s a module)
$ modprobe acpi-configfs

# Allocate a new SSDT
$ mkdir -p /sys/kernel/config/acpi/table/mec1705
$ cat "mec1705.aml" > "/sys/kernel/config/acpi/table/mec1705/aml"
```

**Useful Resources**
* [ACPI Documentation](https://acpica.org/documentation)
* [Ubuntu ACPI Tricks and Tips](https://wiki.ubuntu.com/Kernel/Reference/ACPITricksAndTips)
* [MEC172x System BIOS Porting Guide](https://ww1.microchip.com/downloads/en/Appnotes/AN3642-Application-Note-DS00003642A.pdf)

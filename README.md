# MEC1705

ACPI Table and eSPI Controller Driver for the MEC1705 EC

### Building
**Compile Kernel Module**
```
# On target
$ KSRC="/lib/modules/$(uname -r)/build" make
```
```sh
$ source openembedded-core/oe-init-build-env $(pwd)/build
$ bitbake mec1705-espi
```
```sh
# cd into working directory + git folder
# May look something like bellow
$ cd tmp/work/udoo_bolt_emmc-northstar-linux/mec1705-espi/0.0.1-git+b3697dda641acf3534f7e7e38b58981464e2e6f2-r0/git
$ ../temp/run.do_compile
```

**Compile ASL**
```sh
# Compile ACPI Source Language to ACPI Machine Language
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
# If desire alias for loading and unloading ACPI SSDT
$ source devutils/compile-load-alias

# Mount ConfigFS
$ mount -t configfs none /sys/kernel/config

# Load ACPI ConfigFS support (if it’s a module)
$ modprobe acpi-configfs

# Load SSDT
$ mkdir -p /sys/kernel/config/acpi/table/mec1705
$ cat "mec1705.aml" > "/sys/kernel/config/acpi/table/mec1705/aml"
# OR
$ load_mec1705_aml

# Unload SSDT
$ ./devutils/unload-acpi-table /sys/kernel/config/acpi/table/mec1705
# OR
$ unload_mec1705_aml
```

**Useful Resources**
* [ACPI Documentation](https://acpica.org/documentation)
* [Microchip - Intel Enhanced Serial Peripheral Interface (eSPI)](https://www.microchip.com/en-us/solutions/data-centers-and-computing/computing-solutions/technologies/espi)
* [Microchip - Embedded Memory Interface (EMI)](https://www.microchip.com/en-us/solutions/data-centers-and-computing/computing-solutions/technologies/embedded-memory-interface#)
* [Ubuntu ACPI Tricks and Tips](https://wiki.ubuntu.com/Kernel/Reference/ACPITricksAndTips)
* [MEC172x System BIOS Porting Guide](https://ww1.microchip.com/downloads/en/Appnotes/AN3642-Application-Note-DS00003642A.pdf)

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
$ bitbake mec1705
```
```sh
# cd into working directory + git folder
# May look something like bellow
$ cd tmp/work/udoo_bolt_emmc-northstar-linux/mec1705/0.0.1-git+b9d43fbe2a6a05a29bfa13d244a8573a3ade20c3-r0/git
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
* [Microchip - Intel Enhanced Serial Peripheral Interface (eSPI)](https://www.microchip.com/en-us/solutions/data-centers-and-computing/computing-solutions/technologies/espi)
* [Microchip - Embedded Memory Interface (EMI)](https://www.microchip.com/en-us/solutions/data-centers-and-computing/computing-solutions/technologies/embedded-memory-interface#)
* [Ubuntu ACPI Tricks and Tips](https://wiki.ubuntu.com/Kernel/Reference/ACPITricksAndTips)
* [MEC172x System BIOS Porting Guide](https://ww1.microchip.com/downloads/en/Appnotes/AN3642-Application-Note-DS00003642A.pdf)

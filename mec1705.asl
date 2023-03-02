/*
 * SSDT For UDOO Bolt Embedded Controller MEC1705.
 *
 *
 * Host has access to runtime registers via eSPI
 *      eSPI Interface IO Component Registers (BAR: 0x400F3400): offsets = 0x00 - 0xFF | 0x330 - 0x3FF
 *      eSPI Memory Component (BAR: 0x400F3800): offsets = 0x330 - 0x3FF
 *      The Configuration Registers are accessed through the Configuration Port. Registers located at offsets
 *      0x330 through 0x3FF are mapped to Configuration Port offsets 0x30 through 0xFF. Configuration Port offsets
 *      0x00 through 0x2F, for all Host Logical Devices, are mapped to the Global Configuration Registers.
 *
 *
 * Original Table Headers: ili9488 TFT 3.5" LCD Table
 *      Generated AML File          "mec1705.aml"
 *      Table Signature             "SSDT"        (Secondary System Descriptor Table)
 *      Compliance Revision         "5"           (2+ enables 64-bit arithmetic & determines size of ASL integer)
 *      OEM ID                      ""            (Original Equipment Manufacturer ID)
 *      OEM Table ID                "MEC1705"     (Original Equipment Manufacturer Table ID)
 *      OEM Revision                "1"           (Original Equipment Manufacturer Revision)
 */
DefinitionBlock ("mec1705.aml", "SSDT", 5, "", "MEC1705", 0x1)
{
	Device(EC17) { // MEC1705 Embedded Controller named device object
		Name (_UID, One)       // _UID: Unique ID
		Name (_HID, "PRP0001") // _HID: Hardware ID

		/*
		 * EC hardware is informing the OS that something happened.
		 * GPE for Runtime EC SCI (System Controller Interrupt)
		 */
		Name(_GPE, 100) // GPIO100 / nEC_SCI -> Runtime SCI

		Name (_DSD, Package() { // Device Specific Data - used to return MEC1705 static resources (Defined in _CRS) to the device driver.
			/*
			 * Known as the Device Properties UUID
			 * A generic UUID recognized by the ACPI subsystem in the Linux kernel which automatically
			 * processes the data packages associated with it and makes data available to device driver
			 * as "device properties".
			 */
			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
			Package()
			{
				// Define compatible property
				Package () { "compatible", Package () { "microchip,mec1705-espi" } },
			}
		})

		/*
		 * Define EC Static Resources.
		 * Ports/Registers used to communicate System Host with EC.
		 */
		Name(_CRS, ResourceTemplate() { // _CRS: Current Resource settings
			/*
			 * data port - Allows bi-directional data transfers to and from the host
			 *             and embedded controller.
			 * IO(Decode16, Range Minimum, Range Maximum, Alignment 1, Length 1)
			 */
			IO(Decode16, 0x60, 0x60, 0x01, 0x01)

			/*
			 * status/command port - returns port status information upon a read, and generates
			 *                       a command sequence to the embedded controller upon a write.
			 * IO(Decode16, Range Minimum, Range Maximum, Alignment 1, Length 1)
			 */
			IO(Decode16, 0x64, 0x64, 0x01, 0x01)

			// eSPI Interface IO Component Registers (BAR: 0x400F3400)
			/*
			OperationRegion(EIOC, EmbeddedControl, 0x400F3434, 0x13)
			Field(EIOC, ByteAcc, Lock, Preserve) {
				EIOP, 4, // eSPI I/O Component (Configuration Port)
				MCOM, 4, // eSPI Memory Component
				MBOX, 4, // Mailbox
				EKBC, 4, // 8042 Emulated Keyboard Controller
				AEC0, 4, // ACPI EC Channel 0
				AEC1, 4, // ACPI EC Channel 1
				AEC2, 4, // ACPI EC Channel 2
				AEC3, 4, // ACPI EC Channel 3
				AEC4, 4, // ACPI EC Channel 4
				APM1, 4, // ACPI PM1
				LKYB, 4, // Legacy (Fast Keyboard)
				URT0, 4, // UART 0
				URT1, 4, // UART 1
				EMI0, 4, // Embedded Memory Interface (EMI) 0
				EMI1, 4, // Embedded Memory Interface (EMI) 1
				EMI2, 4, // Embedded Memory Interface (EMI) 2
				BDP0, 4, // BIOS Debug Port (Port 80) 0
				BDP1, 4, // BIOS Debug Port (Port 80) 1
				RTCT, 4, // RTC
			}
			*/
		})
	}
}

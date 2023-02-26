/*
 * SSDT For UDOO Bolt Embedded Controller MEC1705.
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
        Name(_HID, EISAID("MEC1705")) // _HID: Hardware ID
        Name(_UID, 0)

        /*
         * EC hardware is informing the OS that something happened.
         * GPE for Runtime EC SCI (System Controller Interrupt)
         */
        Name(_GPE, 100) // GPIO100 / nEC_SCI -> Runtime SCI

        Name (_CID, Package() {      // Compatible ID (Array of ASL objects. These Objects being strings.)
            "MEC1705",
            "mec1705",
        })

        Name (_DSD, Package() { // Device Specific Data
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"), // Not actual
            Package()
            {
                // Define compatible property
                Package () { "compatible", Package () { "microchip,mec1705-espi" } },
            }
        })


        /*
         * Define EC Static Resources.
         * Ports used to initialize the logical devices at POST.
         */
        Method(_CRS, 0, Serialized) {       // _CRS: Current Resource Settings
            local0 = ResourceTemplate() {   // Configuration Port information
                /*
                 * data port - Allows bi-directional data transfers to and from the host
                 *             and embedded controller.
                 */
                IO(Decode16,
                  0x60,     // Range Minimum
                  0x60,     // Range Maximum
                  1,        // Alignment 1
                  0x02,     // Length 1
                  )

                /*
                 * status/command port - returns port status information upon a read, and generates
                 *                       a command sequence to the embedded controller upon a write.
                 */
                IO(Decode16,
                  0x64,     // Range Minimum
                  0x64,     // Range Maximum
                  1,        // Alignment 1
                  0x02,     // Length 1
                  )
            }
            Return(local0)
        }

        Device(EMIH) { // EMIH - Embedded Memory Interface Handler
            Name(_ADR, 0)

            /*
             * The Runtime Registers may be mapped into the Hosts address space,
             * either I/O or Memory, by setting the register offset for the register
             * in the embedded controller. When the HOST-to-EC Mailbox Register is written,
             * a HW interrupt is generated to the EC. Similarly, when the EC-to-HOST Mailbox
             * Register is written, a HW interrupt is generated to the system host.
             */
            OperationRegion(EMI, EmbeddedControl, 0x00, 0x0C)
            Field(EMI, ByteAcc, Lock, Preserve) {
                /*
                 * 13 byte-addressable registers in the Host’s address space
                 * EMI - Embedded Memory Interface Name Space Configuration
                 */
                HEMR, 1, // 0x00 - System Host to Embedded Controller Mailbox Register
                EHMR, 1, // 0x01 - Embedded Controller to System Host Mailbox Register
                ECLR, 1, // 0x02 - Embedded Controller Address LSB Register
                ECMR, 1, // 0x03 - Embedded Controller Address MSB Register
                DB0R, 1, // 0x04 - EC Data Byte 0 Register
                DB1R, 1, // 0x05 - EC Data Byte 1 Register
                DB2R, 1, // 0x06 - EC Data Byte 2 Register
                DB3R, 1, // 0x07 - EC Data Byte 3 Register
                ISLR, 1, // 0x08 - Interrupt Source LSB Register
                ISMR, 1, // 0x09 - Interrupt Source MSB Register
                IMLR, 1, // 0x0A - Interrupt Mask LSB Register
                IMMR, 1, // 0x0B - Interrupt Mask MSB Register
                AIDR, 1, // 0x0C - Application ID Register
            }

            /*
             * The OS runs _REG control methods to inform AML code
             * of a change in the availability of an operation region.
             * OSPM executes this when EC operation region handler status changes
             */
            Method(_REG, 2, NotSerialized) {
                Printf ("EC17.EMIH._REG: %o %o", ToHexString(Arg0), ToHexString(Arg1))
            }
        }
    }
}

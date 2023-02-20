/*
 * SSDT For UDOO Bolt Embedded Controller MEC1705.
 *
 *
 * Original Table Headers: ili9488 TFT 3.5" LCD Table
 *      Generated AML File          "mec1705.aml"
 *      Table Signature             "SSDT"        (Secondary System Descriptor Table)
 *      Compliance Revision         "3"           (2+ enables 64-bit arithmetic & determines size of ASL integer)
 *      OEM ID                      ""            (Original Equipment Manufacturer ID)
 *      OEM Table ID                "MEC1705"     (Original Equipment Manufacturer Table ID)
 *      OEM Revision                "1"           (Original Equipment Manufacturer Revision)
 */
DefinitionBlock ("mec1705.aml", "SSDT", 3, "", "MEC1705", 0x1)
{
    Device(EC17) { // MEC1705 Embedded Controller
        Name(_HID, EISAID("MEC1705")) // _HID: Hardware ID

        // Define that the EC SCI is bit 0 of the GP_STS register
        Name(_GPE, 0)

        OperationRegion(ECOR, EmbeddedControl, 0x00, 0xFF)
        Field(ECOR, ByteAcc, Lock, Preserve) {
        }

        /*
         * Define EC Static Resources.
         * Ports used to initialize the logical devices at POST.
         */
        Method(_CRS, 0, Serialized) {     // _CRS: Current Resource Settings
            local0 = ResourceTemplate() {   // Configuration Port information
                /*
                 * eSPI Data Register (data port) - Allows bi-directional data transfers to
                 *                                  and from the host and embedded controller.
                 */
                IO(Decode16,
                  0x01,     // Range Minimum
                  0x01,     // Range Maximum
                  1,        // Alignment 1
                  0x02,     // Length 1
                  )

                /*
                 * eSPI Index Register (status/command port) - returns port status information
                 *                                             upon a read, and generates a command
                 *                                             sequence to the embedded controller
                 *                                             upon a write.
                 */
                IO(Decode16,
                  0x00,     // Range Minimum
                  0x00,     // Range Maximum
                  1,        // Alignment 1
                  0x02,     // Length 1
                  )
            }
            Return(local0)
        }
    }
}

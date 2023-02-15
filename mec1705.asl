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
  External(\_SB.PCH, DeviceObj)      // System Bus : Platform Controller Hub
  External(\_SB.PCH.ESPI, DeviceObj) // System Bus : Platform Controller Hub : Intel's Enhanced Serial Peripheral Interface

  Scope (\_SB) {
    Scope (PCH) {
      Scope (ESPI) {
        Device(EC17) { // MEC1705 Embedded Controller
          Name(_HID, EISAID("PNP0C09"))

          // Define that the EC SCI is bit 0 of the GP_STS register
          Name(_GPE, 0)

          OperationRegion(ECOR, EmbeddedControl, 0, 0xFF)
          Field(ECOR, ByteAcc, Lock, Preserve) {
          }

          // Define EC Static Resources
          Method(_CRS, 0) {
            local0 = ResourceTemplate() {
              IO(Decode16, 0x60, 0x60, 0, 1)
              IO(Decode16, 0x64, 0x64, 0, 1)
            }
            Return(local0)
          }
        }
      }
    }
  }
}

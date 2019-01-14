// In config ACPI, SMBU renamed SBUS
// Find:     534D4255
// Replace:  53425553
// TgtBridge:no
// Search 0x001F0004(6th+) or 0x001F0003(6th-)
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SBUS", 0)
{
#endif
    External(_SB.PCI0.SBUS, DeviceObj)
    Scope (_SB.PCI0.SBUS)
    {
        Device(BUS0)
        {
            Name(_CID, "smbus")
            Name(_ADR, Zero)
            Device(DVL0)
            {
                Name(_ADR, 0x57)
                Name(_CID, "diagsvault")
                Method (_DSM, 4, Serialized)
                {
                    If (!Arg2) { Return (Buffer() { 0x03 } ) }
                    Return (Package() { "address", 0x57 })
                }
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
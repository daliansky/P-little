// In config ACPI, I2C0:_STA to XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:49324330
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2C0NONE", 0x00001000)
{
#endif
    External(_SB.PCI0.I2C0, DeviceObj)
    External(_SB.PCI0.I2C0.XSTA, MethodObj)

    Scope (_SB.PCI0.I2C0)
    {    
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.PCI0.I2C0.XSTA())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
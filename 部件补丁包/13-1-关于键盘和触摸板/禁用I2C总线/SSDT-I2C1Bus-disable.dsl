// In config ACPI, I2C1:_STA to XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:49324331
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2C1NONE", 0x00001000)
{
#endif
    External(_SB.PCI0.I2C1, DeviceObj)
    External(_SB.PCI0.I2C1.XSTA, MethodObj)
    
    Scope (_SB.PCI0.I2C1)
    {    
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.XSTA())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
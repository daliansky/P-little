// In config ACPI, I2C0._STA renamed I2C0.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:49324330
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PCI-I2C0", 0)
{
#endif
    //path:_SB.PCI0.I2C0
    External(_SB.PCI0.I2C0, DeviceObj)

    Scope (_SB.PCI0.I2C0)
    {    
        Method (_STA, 0, NotSerialized)
        {
            Return (0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
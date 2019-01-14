// In config ACPI, I2C1._STA renamed I2C1.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:49324331
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PCI-I2C1", 0)
{
#endif
    //path:_SB.PCI0.I2C1
    External(_SB.PCI0.I2C1, DeviceObj)
    
    Scope (_SB.PCI0.I2C1)
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
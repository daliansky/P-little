// In config ACPI, I2C1.TPD1._STA renamed I2C1.TPD1.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:54504431
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2C-TPD1", 0)
{
#endif
    //path:_SB.PCI0.I2C1.TPD1
    Method (_SB.PCI0.I2C1.TPD1._STA, 0, NotSerialized)
    {
        Return (0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
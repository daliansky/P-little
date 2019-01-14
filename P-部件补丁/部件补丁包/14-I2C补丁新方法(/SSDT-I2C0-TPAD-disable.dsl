// In config ACPI, I2C0.TPAD._STA renamed I2C0.TPAD.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:54504144
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2C-TPAD", 0)
{
#endif
    //path:_SB.PCI0.I2C0.TPAD
    Method (_SB.PCI0.I2C0.TPAD._STA, 0, NotSerialized)
    {
        Return (0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
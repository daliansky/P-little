// In config ACPI, GPI0._STA renamed GPI0.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:47504930
//
// Search GPI0 or INT344B
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "GPI0", 0)
{
#endif
    //path:_SB.PCI0.GPI0
    External(_SB.PCI0.GPI0, DeviceObj)
    Scope (_SB.PCI0.GPI0)
    {
        Method(_STA, 0, NotSerialized)
        {
            Return (0x0F)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
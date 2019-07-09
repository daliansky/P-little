//Please change the path
// In config ACPI, ALSD._STA renamed ALSD.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:414C5344
//
// Search "ACPI0008" or ALSD
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "ALSD0008", 0)
{
#endif
    //path:ALSD
    Method(ALSD._STA, 0, NotSerialized)
    {
        Return (0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
// In config ACPI, _Q13 renamed XQ13
// Find:     5F 51 31 33
// Replace:  58 51 31 33
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "X-KEYFn", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q13, 0, NotSerialized)
        {
            \XWCF.MPWS =1
            Notify (\_SB.SLPB, 0x80) 
        }
    } 
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
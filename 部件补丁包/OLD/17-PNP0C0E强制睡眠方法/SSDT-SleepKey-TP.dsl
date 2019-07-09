// In config ACPI, _Q13 renamed XQ13
// Find:     5F 51 31 33
// Replace:  58 51 31 33
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SLEEPKEY", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q13, 0, NotSerialized)
        {
            If (\XWCF.MPWS==0)
            {
                \XWCF.MPWS =1
                Notify (\_SB.SLPB, 0x80)
            }
        }        
    } 
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
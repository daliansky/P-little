//
// In config ACPI, _Q2B renamed XQ2B
// Find:     5F 51 32 42
// Replace:  58 51 32 42
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SLEEPLID", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)
    External(XWCF.MODE, IntObj)
    External(_SB.PCI0.LPCB.EC.XQ2B, MethodObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q2B, 0, NotSerialized)
        {
            If (\XWCF.MODE==0)
            {
                XQ2B()
            }
            Else
            {
                If (\XWCF.MPWS==0)
                {
                    \XWCF.MPWS =1
                    Notify (\_SB.SLPB, 0x80)
                }
            }
        }        
    } 
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
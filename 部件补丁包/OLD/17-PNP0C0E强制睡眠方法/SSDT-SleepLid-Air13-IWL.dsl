// Overriding _Q15
// In config ACPI, _Q15 renamed XQ15
// Find:     5F513135
// Replace:  58513135
//
#define LidManagement 0
#define ButtonManagement 1
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SLEEPLID", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)
    External(XWCF.MODE, IntObj)
    External(_SB.PCI0.LPCB.EC.XQ15, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q15, 0, NotSerialized)
        {
            If (\XWCF.MODE==0)
            {
                XQ15()
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
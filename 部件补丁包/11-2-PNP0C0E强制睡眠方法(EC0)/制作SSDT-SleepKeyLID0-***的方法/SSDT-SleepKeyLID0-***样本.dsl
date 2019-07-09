//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "X-KEYLID", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.LID0, DeviceObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)
    External(XWCF.MODE, IntObj)
    External(XWCF.MYLD, IntObj)
    External(_SB.PCI0.LPCB.EC0.XLID, MethodObj)

    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q01, 0, NotSerialized)
        {
            If (\XWCF.MODE==0)
            {
                If (\XWCF.MYLD!=0)
                {
                    \XWCF.MYLD =0
                }
                Else
                {
                    \XWCF.MYLD =1
                }
                Notify (\_SB.LID0, 0x80)
            }
            Else
            {
                \XWCF.MPWS =1
                Notify (\_SB.SLPB, 0x80)
            }
        
        }        
        Method (_Q02, 0, NotSerialized)
        {
            If (\XWCF.MODE==0)
            {
                \XWCF.MYLD =1
                \_SB.PCI0.LPCB.EC0.XLID()
            }
            Else
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
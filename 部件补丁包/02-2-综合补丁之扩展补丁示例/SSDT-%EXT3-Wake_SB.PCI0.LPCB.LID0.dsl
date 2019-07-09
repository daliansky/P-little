//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "EXT3", 0)
{
#endif
    External(_SB.PCI0.LPCB.LID0, DeviceObj)
    Method (EXT3, 1, NotSerialized)
    {   
        If (3 == Arg0)
        {
            Notify (\_SB.PCI0.LPCB.LID0, 0x80)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

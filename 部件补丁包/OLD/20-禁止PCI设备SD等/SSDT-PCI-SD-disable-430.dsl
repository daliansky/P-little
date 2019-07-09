//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PCI-SD", 0)
{
#endif
    //path:_SB.PCI0.EXP3
    External(_SB.PCI0.EXP3, DeviceObj)
    Scope (_SB.PCI0.EXP3)
    {
        Method (_STA, 0, NotSerialized)
        {
            Return (0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
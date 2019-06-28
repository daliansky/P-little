//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "EXT3", 0)
{
#endif
    External(_SB.LID, DeviceObj)
    External(_SB.LID._LID, MethodObj)
    External(_SB.PCI0.IGPU.GLID, MethodObj)
    Method (EXT3, 1, NotSerialized)
    {   
        If (3 == Arg0)
        {
            Local0 = \_SB.LID._LID ()
            \_SB.PCI0.IGPU.GLID (Local0)
            Notify (\_SB.LID, 0x80)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

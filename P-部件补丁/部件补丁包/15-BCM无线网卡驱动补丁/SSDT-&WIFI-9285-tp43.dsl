//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFIcard", 0)
{
    //path:_SB.PCI0.EXP2
    External(_SB.PCI0.EXP2, DeviceObj)
    Scope (_SB.PCI0.EXP2)
    {
        Device(PXSX){Name (_ADR, 0)}
    }

    Scope (_SB.PCI0.EXP2.PXSX)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "compatible",   //9285
                "pci168c,2a"
            }
            Return (Local0)
        }
    }
}
//EOF
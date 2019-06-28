//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFIcard", 0)
{
    //path:_SB.PCI0.RP05
    /*
    External(_SB.PCI0.RP05, DeviceObj)
    Scope (_SB.PCI0.RP05)
    {
        Device(PXSX){Name (_ADR, 0)}
    }
    */

    //path:_SB.PCI0.RP05.PXSX
    External(_SB.PCI0.RP05.PXSX, DeviceObj)
    Scope (_SB.PCI0.RP05.PXSX)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "compatible",    //4352,4360
                "pci14e4,4331"
            }
            Return (Local0)
        }
    }
}
//EOF
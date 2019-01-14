//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFIcard", 0)
{
    //path:_SB.PCI0.RP08
    /*
    External(_SB.PCI0.RP08, DeviceObj)
    Scope (_SB.PCI0.RP08)
    {
        Device(PXSX){Name (_ADR, 0)}
    }
    */

    //path:_SB.PCI0.RP08.PXSX
    External(_SB.PCI0.RP08.PXSX, DeviceObj)
    Scope (_SB.PCI0.RP08.PXSX)
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
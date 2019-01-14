//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFIcard", 0)
{
    //path:_SB.PCI0.RP03
    /*
    External(_SB.PCI0.RP03, DeviceObj)
    Scope (_SB.PCI0.RP03)
    {
        Device(PXSX){Name (_ADR, 0)}
    }
    */
 
    //path:_SB.PCI0.RP03.PXSX
    External(_SB.PCI0.RP03.PXSX, DeviceObj)
    Scope (_SB.PCI0.RP03.PXSX)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "compatible",   //4322
                "pci14e4,432b"
            }
            Return (Local0)
        }
    }
}
//EOF
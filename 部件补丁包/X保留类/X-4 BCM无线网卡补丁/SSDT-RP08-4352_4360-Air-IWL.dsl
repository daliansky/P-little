//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFI", 0)
{
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
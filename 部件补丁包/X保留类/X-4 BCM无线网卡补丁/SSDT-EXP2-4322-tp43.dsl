//
DefinitionBlock ("", "SSDT", 2, "hack", "WIFI", 0)
{
    External(_SB.PCI0.EXP2, DeviceObj)
    Scope (_SB.PCI0.EXP2)
    {
        Device(PXSX)
        {
            Name (_ADR, 0)
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }

    Scope (_SB.PCI0.EXP2.PXSX)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "compatible",   //4322
                "pci14e4,432b"//"pci14e4,4331"
            }
            Return (Local0)
        }
    }
}
//EOF
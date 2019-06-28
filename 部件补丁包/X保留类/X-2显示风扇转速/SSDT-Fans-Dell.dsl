//Dell fans
DefinitionBlock ("", "SSDT", 2, "hack", "FANS", 0)
{
    External(_SB.PCI0.LPCB.EC.KDRT, MethodObj)
    External(ECRD, IntObj)
    
    Device (SMCD)
    {
        Name (_HID, EisaId ("PNP0C02"))
        //Name (_CID, "monitor")
        Name (TACH, Package ()
        {
            "System Fan", 
            "FAN0"
        })

        Method (FAN0, 0, NotSerialized)
        {
            If (\ECRD)
            {
                Store (\_SB.PCI0.LPCB.EC.KDRT (0x05), Local0)
                Return (Local0)
            }
            Else
            {
                Return (0x0BB8)
            }
        }
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
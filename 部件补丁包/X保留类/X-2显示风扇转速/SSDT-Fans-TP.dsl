// FanHW for thinkpad
// made:FakeSMC.kext\Info.plist\IOKitPersonalities\FakeSMC\Configuration\keys\FNum\1\00--01
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "FANS", 0)
{
#endif  
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    Scope(_SB.PCI0.LPCB.EC)
    {
        OperationRegion (FRAM, EmbeddedControl, 0x00, 0x0100)
        Field (FRAM, ByteAcc, NoLock, Preserve)
        {   
            Offset (0x84),
            HSP0,   8,    ///HSPD,   16,
            HSP1,   8,
        } 
    }  
    
    Device (SMCD)
    {
        Name (_HID, "FAN00000")
        Name (TACH, Package ()
        {
            "System Fan", 
            "FAN0"
        })

        Method (FAN0, 0, NotSerialized)///FAN0
        {
            Local0 = \_SB.PCI0.LPCB.EC.HSP1 << 8
            Or (\_SB.PCI0.LPCB.EC.HSP0, Local0, Local0)
            Return (Local0)
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
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
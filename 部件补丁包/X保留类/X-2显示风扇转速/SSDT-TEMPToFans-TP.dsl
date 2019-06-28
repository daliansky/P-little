// FanHW for thinkpad
// made:FakeSMC.kext\Info.plist\IOKitPersonalities\FakeSMC\Configuration\keys\FNum\1\00--01
// Need to install RehabMan's ACPIPoller.kext
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "TEMPFANS", 0)
{
#endif  
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.HFSP, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.TMP0, FieldUnitObj)
    
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
        
        Method (TCPU, 0, NotSerialized)
        {
            Local0=\_SB.PCI0.LPCB.EC.TMP0
            
            If (LGreaterEqual (Local0, 0x55)) // CPU Temp is >= 85C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x07 }
            Else {
            If (LGreaterEqual (Local0, 0x50)) // CPU Temp is >= 80C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x06 }
            Else {
            If (LGreaterEqual (Local0, 0x4B)) // CPU Temp is >= 75C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x05 }
            Else {
            If (LGreaterEqual (Local0, 0x46)) // CPU Temp is >= 70C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x04 }
            Else {
            If (LGreaterEqual (Local0, 0x41)) // CPU Temp is >= 65C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x03 }
            Else {
            If (LGreaterEqual (Local0, 0x3C)) // CPU Temp is >= 60C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x02 }
            Else {
            If (LGreaterEqual (Local0, 0x01)) // CPU Temp is >= 01C
            { \_SB.PCI0.LPCB.EC.HFSP = 0x01 }
            }}}}}}
            //\_SB.PCI0.LPCB.EC.HFSP = 0x80 //BIOS controll
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
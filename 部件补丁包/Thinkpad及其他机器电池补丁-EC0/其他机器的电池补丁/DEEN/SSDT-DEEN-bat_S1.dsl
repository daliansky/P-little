// battery
// In config ACPI, H_EC renamed EC0
// Find:     48 5F 45 43
// Replace:  45 43 30 5F
//
// In config ACPI, _BIF renamed XTIF
// Find:     5F 42 49 46
// Replace:  58 42 49 46
// TgtBridge:no
//
// In config ACPI, _BST renamed XTST
// Find:     5F 42 53 54
// Replace:  58 42 53 54
// TgtBridge:no
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBIF, PkgObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBST, PkgObj)
    External(_SB.PCI0.LPCB.EC0.BSTS, FieldUnitObj)

    Method (B1B2, 2, NotSerialized)
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }
    
    Scope(_SB.PCI0.LPCB.EC0)
    {   
        OperationRegion (BRAM, EmbeddedControl, 0x00, 0xFF)           
        Field (BRAM, ByteAcc, Lock, Preserve)
        {
            Offset (0x8E), 
            DCA0,8,DCA1,8,//BDCA,   16, 
            Offset (0x92), 
            PVO0,8,PVO1,8,//BPVO,   16, 
            RRL0,8,RRL1,8,//PRRL,   16, 
            Offset (0x98), 
            RCA0,8,RCA1,8,//BRCA,   16, 
            LFC0,8,LFC1,8,//BLFC,   16, 
            Offset (0x9E), 
            STA0,8,STA1,8,//BSTA,   16, 
            DVO0,8,DVO1,8,//BDVO,   16, 
            Offset (0xA4), 
            ACU0,8,ACU1,8,//BACU,   16,      
        }
    }
        
    Scope(_SB.PCI0.LPCB.EC0.BAT0)
    {      
                Method (_BIF, 0, NotSerialized)
                {
                    BBIF [One] = B1B2 (\_SB.PCI0.LPCB.EC0.DCA0,\_SB.PCI0.LPCB.EC0.DCA1)//BDCA
                    BBIF [0x02] = B1B2 (\_SB.PCI0.LPCB.EC0.LFC0,\_SB.PCI0.LPCB.EC0.LFC1)//BLFC
                    BBIF [0x04] = B1B2 (\_SB.PCI0.LPCB.EC0.DVO0,\_SB.PCI0.LPCB.EC0.DVO1)//BDVO
                    Return (\_SB.PCI0.LPCB.EC0.BAT0.BBIF)
                }

                Method (_BST, 0, NotSerialized)
                {
                    Local0 = \_SB.PCI0.LPCB.EC0.BSTS
                    If ((B1B2 (\_SB.PCI0.LPCB.EC0.STA0,\_SB.PCI0.LPCB.EC0.STA1) & 0x10))
                    {
                        Local0 |= 0x04
                    }

                    BBST [Zero] = Local0
                    Local1 = B1B2 (\_SB.PCI0.LPCB.EC0.ACU0,\_SB.PCI0.LPCB.EC0.ACU1)//BACU
                    If ((Local1 & 0x8000))
                    {
                        Local0 = (~Local1 & 0x7FFF)
                        Local0++
                    }
                    Else
                    {
                        Local0 = (Local1 & 0x7FFF)
                    }

                    If ((Local0 < 0x0352))
                    {
                        Local0 = 0x0352
                    }

                    BBST [One] = Local0
                    BBST [0x02] = B1B2 (\_SB.PCI0.LPCB.EC0.RCA0,\_SB.PCI0.LPCB.EC0.RCA1)//BRCA
                    BBST [0x03] = B1B2 (\_SB.PCI0.LPCB.EC0.PVO0,\_SB.PCI0.LPCB.EC0.PVO1)//BPVO
                    Return (\_SB.PCI0.LPCB.EC0.BAT0.BBST)
                }
    }
}
//EOF


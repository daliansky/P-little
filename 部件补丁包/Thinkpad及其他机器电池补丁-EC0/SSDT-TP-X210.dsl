// battery
// In config ACPI, _BIF to XBIF
// Find:     5F 42 49 46
// Replace:  58 42 49 46
// TgtBridge:42 41 54 30
//
// In config ACPI, _BST to XBST 
// Find:     5F 42 53 54
// Replace:  58 42 53 54
// TgtBridge:42 41 54 30
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BSTS, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBIF, PkgObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBST, PkgObj)
    
    Method (B1B2, 2, NotSerialized)//16
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }
    
    Scope(_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (BRAM, EmbeddedControl, Zero, 0xFF)
        Field (BRAM, ByteAcc, Lock, Preserve)
        {
                Offset (0x60), 
                GCP0,8,GCP1,8,//DGCP,   16, 
                LCP0,8,LCP1,8,//FLCP,   16, 
                GVO0,8,GVO1,8,//DGVO,   16, 
                BDW0,8,BDW1,8,//BDW,    16, 
                BDL0,8,BDL1,8,//BDL,    16, 
                BPR0,8,BPR1,8,//BPR,    16, 
                BRC0,8,BRC1,8,//BRC,    16, 
                BPV0,8,BPV1,8,//BPV,    16
        }
    }
            
    Scope(_SB.PCI0.LPCB.EC0.BAT0)
    {
        Method (_BIF, 0, NotSerialized)
        {
                Sleep (0x0A)
                BBIF [One] = B1B2 (GCP0, GCP1)
                Sleep (0x0A)
                BBIF [0x02] = B1B2 (LCP0, LCP1)
                Sleep (0x0A)
                BBIF [0x04] = B1B2 (GVO0, GVO1)
                Sleep (0x0A)
                BBIF [0x05] = B1B2 (BDW0, BDW1)
                Sleep (0x0A)
                BBIF [0x06] = B1B2 (BDL0, BDL1)
                Return (\_SB.PCI0.LPCB.EC0.BAT0.BBIF)
        }
        
        Method (_BST, 0, NotSerialized) 
        {
                Sleep (0x0A)
                BBST [Zero] = \_SB.PCI0.LPCB.EC0.BSTS
                Sleep (0x0A)
                BBST [One] = B1B2 (BPR0, BPR1)
                Sleep (0x0A)
                BBST [0x02] = B1B2 (BRC0, BRC1)
                Sleep (0x0A)
                BBST [0x03] = B1B2 (BPV0, BPV1)
                Return (\_SB.PCI0.LPCB.EC0.BAT0.BBST)
        }
    }
}
//EOF


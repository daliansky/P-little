// battery
// In config ACPI, _BIF to XBIF
// Find:     5F424946
// Replace:  58424946
// TgtBridge:no
//
// In config ACPI, _BST to XBST(BAT0)
// Find:     5F425354
// Replace:  58425354
// TgtBridge:42415430
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BATX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.BSTS, FieldUnitObj)
    //
    Method (B1B2, 2, NotSerialized)
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }

    Scope(\_SB.PCI0.LPCB.EC0)
    {
        OperationRegion (BRAM, EmbeddedControl, 0x00, 0xFF)           
        Field (BRAM, ByteAcc, Lock, Preserve)
        {
                Offset (0x60), 
                DGC0,   8,DGC1,   8, 
                FLC0,   8,FLC1,   8, 
                DGV0,   8,DGV1,   8, 
                BDW0,   8,BDW1,   8, 
                BDL0,   8,BDL1,   8, 
                BPR0,   8,BPR1,   8, 
                BRC0,   8,BRC1,   8, 
                BPV0,   8,BPV1,   8
        }
    }   
    
    Scope(_SB.PCI0.LPCB.EC0.BAT0)
    {   
        Name (BBIX, Package (0x0D)
        {
            One, 
            0x1130, 
            0x1130, 
            One, 
            0x2B5C, 
            Zero, 
            Zero, 
            Zero, 
            0xFFFFFFFF, 
            "Y91", 
            "123456", 
            "LION", 
            "CJOYIN"
        })
        Method (_BIF, 0, NotSerialized)
        {
            Acquire (BATX, 0xFFFF)
            Store (B1B2 (DGC0, DGC1), Index (BBIX, One))
            Store (B1B2 (FLC0, FLC1), Index (BBIX, 0x02))
            Store (B1B2 (DGV0, DGV1), Index (BBIX, 0x04))
            Store (B1B2 (BDW0, BDW1), Index (BBIX, 0x05))
            Store (B1B2 (BDL0, BDL1), Index (BBIX, 0x06))
            Release (BATX)
            Return (BBIX)
        }
        
        Name (BBSX, Package (0x04)
        {
            Zero, 
            0x03E8, 
            0x1130, 
            0x2B5C
        })
        Method (_BST, 0, NotSerialized)
        {
            Acquire (BATX, 0xFFFF)
            Store (\_SB.PCI0.LPCB.EC0.BSTS, Index (BBSX, Zero))
            Store (B1B2 (BPR0, BPR1), Index (BBSX, One))
            Store (B1B2 (BRC0, BRC1), Index (BBSX, 0x02))
            Store (B1B2 (BPV0, BPV1), Index (BBSX, 0x03))
            Release (BATX)
            Return (BBSX)
        }
    } 
}
//EOF


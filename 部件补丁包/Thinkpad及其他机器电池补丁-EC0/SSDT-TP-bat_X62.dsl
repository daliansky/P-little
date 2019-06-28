// battery
//
//1:_BIF to XBIF
//Find      :5F424946
//Replace   :58424946
//TgtBridge :no
//
//2:_BST to XBST
//Find      :5F425354
//Replace   :58425354
//TgtBridge :no
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT0, DeviceObj)   
    External(_SB.PCI0.LPCB.EC0.BSTS, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BATX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBIF, PkgObj)
    External(_SB.PCI0.LPCB.EC0.BAT0.BBST, PkgObj)
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
    
    Scope(\_SB.PCI0.LPCB.EC0.BAT0)
    {   
        Method (_BIF, 0, NotSerialized)
        {
            Acquire (BATX, 0xFFFF)
            Store (B1B2 (GCP0, GCP1), Index (^BBIF, One))
            Store (B1B2 (LCP0, LCP1), Index (^BBIF, 0x02))
            Store (B1B2 (GVO0, GVO1), Index (^BBIF, 0x04))
            Store (B1B2 (BDW0, BDW1), Index (^BBIF, 0x05))
            Store (B1B2 (BDL0, BDL1), Index (^BBIF, 0x06))
            Release (BATX)
            Return (^BBIF)
        }
        
        Method (_BST, 0, NotSerialized)
        {
            Acquire (BATX, 0xFFFF)
            Store (^^BSTS, Index (^BBST, Zero))
            Store (B1B2 (BPR0, BPR1), Index (^BBST, One))
            Store (B1B2 (BRC0, BRC1), Index (^BBST, 0x02))
            Store (B1B2 (BPV0, BPV1), Index (^BBST, 0x03))
            Release (BATX)
            Return (^BBST)
        }
    } 
}
//EOF


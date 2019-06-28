// battery
// In config ACPI, ECBE to XCBE
// Find:     4543424500
// Replace:  5843424500
// TgtBridge:no
//
// In config ACPI, _BST to XBST 
// Find:     5F425354
// Replace:  58425354
// TgtBridge:no
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.BAT0, DeviceObj)
    External(_SB.BAT0.PAK0, PkgObj)
    External(_SB.MUEX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.BSOK, MethodObj)
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
                    ,   16, //no XIF0
                IF10,8,IF11,8,//wxw XIF1
                IF20,8,IF21,8,//wxw XIF2
                IF30,8,IF31,8,//wxw XIF3
                IF40,8,IF41,8,//wxw XIF4
                    ,   16, //no XIF5
                    ,   16, //no XIF6
                IF70,8,IF71,8,//wxw XIF7
                    ,   16, //no XIF8
                    ,   64, //no XIF9
                    ,   64, //no XIFA
                    ,   64, //no XIFB
                    ,   64, //no XIFC
                ST00,8,ST01,8,//wxw XST0
                ST10,8,ST11,8,//wxw XST1
                ST20,8,ST21,8,//wxw XST2
                ST30,8,ST31,8,//wxw XST3
                Offset (0xA6), 
                YCN0,8,YCN1,8,//wxw CYCN
        }
    }   
    
    Scope(\_SB.BAT0)
    {   
        Method (ECBE, 0, NotSerialized)
        {
            Acquire (MUEX, 0xFFFF)
            //Store ("ECBE", Debug)
            Store (B1B2 (^^PCI0.LPCB.EC0.IF10, ^^PCI0.LPCB.EC0.IF11), Index (PAK0, One))
            If (LGreaterEqual (B1B2 (^^PCI0.LPCB.EC0.YCN0, ^^PCI0.LPCB.EC0.YCN1), 0x32))
            {
                Store (B1B2 (^^PCI0.LPCB.EC0.IF20, ^^PCI0.LPCB.EC0.IF21), Index (PAK0, 0x02))
            }
            Else
            {
                Store (B1B2 (^^PCI0.LPCB.EC0.IF10, ^^PCI0.LPCB.EC0.IF11), Index (PAK0, 0x02))
            }

            Store (B1B2 (^^PCI0.LPCB.EC0.IF30, ^^PCI0.LPCB.EC0.IF31), Index (PAK0, 0x03))
            Store (B1B2 (^^PCI0.LPCB.EC0.IF40, ^^PCI0.LPCB.EC0.IF41), Index (PAK0, 0x04))
            Store (B1B2 (^^PCI0.LPCB.EC0.IF70, ^^PCI0.LPCB.EC0.IF71), Index (PAK0, 0x07))
            Release (MUEX)
        }
            
        Name (BFBX, Package ()
        {
            Zero, 
            Zero, 
            Zero, 
            Zero
        })
        
        Method (_BST, 0, NotSerialized)
        {
            Acquire (MUEX, 0xFFFF)
            //Store ("BST1 Start", Debug)
            If (LEqual (^^PCI0.LPCB.EC0.BSOK, One))
            {
                Store (B1B2 (^^PCI0.LPCB.EC0.ST00, ^^PCI0.LPCB.EC0.ST01), Index (BFBX, Zero))
                Store (B1B2 (^^PCI0.LPCB.EC0.ST10, ^^PCI0.LPCB.EC0.ST11), Index (BFBX, One))
                If (LGreaterEqual (B1B2 (^^PCI0.LPCB.EC0.YCN0, ^^PCI0.LPCB.EC0.YCN1), 0x32))
                {
                    Store (B1B2 (^^PCI0.LPCB.EC0.ST20, ^^PCI0.LPCB.EC0.ST21), Index (BFBX, 0x02))
                }
                Else
                {
                    Store (Divide (Multiply (B1B2 (^^PCI0.LPCB.EC0.ST20, ^^PCI0.LPCB.EC0.ST21), 0x64), 
                    B1B2 (^^PCI0.LPCB.EC0.IF20, ^^PCI0.LPCB.EC0.IF21), ), Local0)
                    //
                    Store (Divide (B1B2 (^^PCI0.LPCB.EC0.IF10, ^^PCI0.LPCB.EC0.IF11), 0x64, ), Local1)
                    Store (Multiply (Local0, Local1), Index (BFBX, 0x02))
                }

                Store (B1B2 (^^PCI0.LPCB.EC0.ST30, ^^PCI0.LPCB.EC0.ST31), Index (BFBX, 0x03))//wxw
                //Store ("BST1 End", Debug)
            }

            Release (MUEX)
            Return (BFBX)
        }
    } 
}
//EOF


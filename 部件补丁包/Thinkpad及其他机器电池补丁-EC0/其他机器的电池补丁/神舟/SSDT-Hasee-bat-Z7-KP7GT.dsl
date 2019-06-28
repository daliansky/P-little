// battery
// In config ACPI, _BST renamed _BST
// Find:     5F 42 53 54
// Replace:  58 42 53 54
//
// In config ACPI, ECBE renamed XCBE
// Find:     45 43 42 45 00
// Replace:  58 43 42 45 00
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.BAT0, DeviceObj)
    External(_SB.MUEX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.BSOK, FieldUnitObj)
    External(_SB.BAT0.PAK0, PkgObj)
    External(_SB.BAT0.BFB0, PkgObj)
    
    Method (B1B2, 2, NotSerialized)
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }
    Method (B1B4, 4, NotSerialized)
    {
        Store (Arg3, Local0)
        Or (Arg2, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg1, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg0, ShiftLeft (Local0, 0x08), Local0)
        Return (Local0)
    }    
    Scope (_SB.PCI0.LPCB.EC0)
    { 
        OperationRegion (BRAM, EmbeddedControl, 0x00, 0xFF)
        Field (BRAM, ByteAcc, Lock, Preserve)
        {
                ,   16, 
            IF10,8,IF11,8, //XIF1,   16, 
            IF20,8,IF21,8, //XIF2,   16, 
            IF30,8,IF31,8, //XIF3,   16, 
            IF40,8,IF41,8, //XIF4,   16, 
                ,   16, 
                ,   16, 
            IF70,8,IF71,8, //XIF7,   16,
            ST00,8,ST01,8, //XST0,   16, 
            ST10,8,ST11,8, //XST1,   16, 
            ST20,8,ST21,8, //XST2,   16, 
            ST30,8,ST31,8, //XST3,   16,      
        }
    }
        
    Scope (_SB.BAT0)
    {
        Method (ECBE, 0, NotSerialized)
        {
            Acquire (MUEX, 0xFFFF)
            //Debug = "ECBE"
            PAK0 [One]  = B1B2 (^^PCI0.LPCB.EC0.IF10,^^PCI0.LPCB.EC0.IF11)
            PAK0 [0x02] = B1B2 (^^PCI0.LPCB.EC0.IF20,^^PCI0.LPCB.EC0.IF21)
            PAK0 [0x03] = B1B2 (^^PCI0.LPCB.EC0.IF30,^^PCI0.LPCB.EC0.IF31)
            PAK0 [0x04] = B1B2 (^^PCI0.LPCB.EC0.IF40,^^PCI0.LPCB.EC0.IF41)
            PAK0 [0x07] = B1B2 (^^PCI0.LPCB.EC0.IF70,^^PCI0.LPCB.EC0.IF71)
            Release (MUEX)
        }
        
        Method (_BST, 0, NotSerialized)
        {
            Acquire (MUEX, 0xFFFF)
            //Debug = "BST1 Start"
            If ((^^PCI0.LPCB.EC0.BSOK == One))
            {
                BFB0 [Zero] = B1B2 (^^PCI0.LPCB.EC0.ST00,^^PCI0.LPCB.EC0.ST01)
                BFB0 [One]  = B1B2 (^^PCI0.LPCB.EC0.ST10,^^PCI0.LPCB.EC0.ST11)
                BFB0 [0x02] = B1B2 (^^PCI0.LPCB.EC0.ST20,^^PCI0.LPCB.EC0.ST21)
                BFB0 [0x03] = B1B2 (^^PCI0.LPCB.EC0.ST30,^^PCI0.LPCB.EC0.ST31)
                //Debug = "BST1 End"
            }

            Release (MUEX)
            Return (\_SB.BAT0.BFB0)
        }
    }
}
//EOF


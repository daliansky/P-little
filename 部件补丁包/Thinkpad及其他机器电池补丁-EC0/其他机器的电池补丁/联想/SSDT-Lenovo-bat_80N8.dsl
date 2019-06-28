// battery
// In config ACPI, _BIF to XBIF
// Find:     5F424946
// Replace:  58424946
// TgtBridge:42415431
//
// In config ACPI, _BST to XBST 
// Find:     5F425354
// Replace:  58425354
// TgtBridge:42415431
//
// In config ACPI, H_EC to EC0
// Find:     48 5F 45 43
// Replace:  45 43 30 5F
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT1, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.ECA2, IntObj)
    External(_SB.PCI0.LPCB.EC0.BATM, MutexObj)
    External(_SB.PCI0.LPCB.EC0.B1IC, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.B1DI, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BAT1.POSW, MethodObj)
    
    Method (B1B2, 2, NotSerialized)
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
                Offset (0xB6), 
                    ,   16, 
                APV0,8,APV1,8,//BAPV,   16, 
                
                Offset (0xC2), 
                ARC0,8,ARC1,8,//BARC,   16, 
                ADC0,8,ADC1,8,//BADC,   16, 
                ADV0,8,ADV1,8,//BADV,   16, 
                    ,   16, 
                    ,   16, 
                AFC0,8,AFC1,8,//BAFC,   16, 
                    ,   16, 
                BCR0,8,BCR1,8,//B1CR,   16, 
        }
    }   
    
    Scope(_SB.PCI0.LPCB.EC0.BAT1)
    {   
                Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
                {
                    Name (BPKG, Package (0x0D)
                    {
                        Zero, 
                        Ones, 
                        Ones, 
                        One, 
                        Ones, 
                        Zero, 
                        Zero, 
                        0x64, 
                        Zero, 
                        "VIUU4", 
                        "BAT20101001", 
                        "Li Polymer", 
                        "Lenovo IdeaPad"
                    })
                    Name (MDST, Buffer (0x05)
                    {
                        "    "
                    })
                    Name (SNST, Buffer (0x05)
                    {
                        "    "
                    })
                    Name (TPST, Buffer (0x05)
                    {
                        "    "
                    })
                    Name (LENV, Buffer (0x09)
                    {
                        "        "
                    })
                    If (\_SB.PCI0.LPCB.EC0.ECA2)
                    {
                        Local0 = B1B2(AFC0, AFC1)
                        If (Local0)
                        {
                            BPKG [One] = B1B2(ADC0, ADC1)
                            BPKG [0x02] = Local0
                            BPKG [0x04] = B1B2(ADV0, ADV1)
                            Divide (Local0, 0x0A, Local1, Local2)
                            BPKG [0x05] = Local2
                            Divide (Local0, 0x14, Local1, Local2)
                            BPKG [0x06] = Local2
                        }
                    }

                    Return (BPKG) /* \_SB_.PCI0.LPCB.H_EC.BAT1._BIF.BPKG */
                }
        
                Method (_BST, 0, NotSerialized)  // _BST: Battery Status
                {
                    Acquire (BATM, 0xFFFF)
                    Name (PKG1, Package (0x04)
                    {
                        Ones, 
                        Ones, 
                        Ones, 
                        Ones
                    })
                    If (\_SB.PCI0.LPCB.EC0.ECA2)
                    {
                        Local0 = (B1IC << One)
                        Local1 = (B1DI | Local0)
                        PKG1 [Zero] = Local1
                        Local2 = B1B2(BCR0, BCR1)
                        Local2 = POSW (Local2)
                        Local3 = B1B2(APV0, APV1)
                        Divide (Local3, 0x03E8, Local4, Local3)
                        Local2 *= Local3
                        PKG1 [One] = Local2
                        PKG1 [0x02] = B1B2(ARC0, ARC1)
                        PKG1 [0x03] = B1B2(APV0, APV1)
                    }

                    Release (BATM)
                    Return (PKG1) /* \_SB_.PCI0.LPCB.H_EC.BAT1._BST.PKG1 */
                }
    } 
}
//EOF


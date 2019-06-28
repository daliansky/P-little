// battery
// In config ACPI, _BIF to XBIF
// Find:     5F424946
// Replace:  58424946
// TgtBridge:no
//
// In config ACPI, _BST to XBST 
// Find:     5F425354
// Replace:  58425354
// TgtBridge:no
//
// In config ACPI, BATN128 to ZZZZ128
// Find:     42 41 54 4E 40
// Replace:  5A 5A 5A 5A 40
// TgtBridge:no
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.BAT1, DeviceObj)
    External(\_SB.PCI0.LPCB.ECOK, MethodObj)
    External(ECDY, IntObj)
    External(_SB.PCI0.LPCB.EC0.SYS7, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.GAU0, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.DBCD, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BMF0, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BST0, FieldUnitObj)
    
    Method (B1B2, 2, NotSerialized)//16
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }
    
    Scope(_SB.PCI0.LPCB.EC0)
    {   
        Method (RE1B, 1, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Return(BYTE)
        }
        
        Method (RECB, 2, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                Store(RE1B(Arg0), Index(TEMP, Local0))
                Increment(Arg0)
                Increment(Local0)
            }
            Return(TEMP)
        }
        
        Method (XXXX, 0, Serialized) { Return(RECB(0x10,128)) }

        OperationRegion (BRAM, EmbeddedControl, Zero, 0xFF)
        Field (BRAM, ByteAcc, Lock, Preserve)
        {
                Offset (0x10), 
                //XXXX,   128, //BATN
                Offset (0xBF), 
                    ,   8, 
                    ,   4, 
                    ,   3, 
                    ,   1, 
                    ,   8, 
                RC00,8,RC01,8,//BRC0,   16, 
                SN00,8,SN01,8,//BSN0,   16, 
                PV00,8,PV01,8,//BPV0,   16, 
                DV00,8,DV01,8,//BDV0,   16, 
                DC00,8,DC01,8,//BDC0,   16,
                FC00,8,FC01,8,//BFC0,   16, 
                    ,   8, 
                    ,   8, 
                    ,   16, 
                AC00,8,AC01,8,//BAC0,   16, 
        }
    }
            
    Scope(\_SB.PCI0.LPCB.BAT1)
    {
        Method (_BIF, 0, NotSerialized)
        {
            Name (STAT, Package (0x0D)
            {
                Zero, 
                0x0FA0, 
                0x0FA0, 
                One, 
                0x2B5C, 
                0x01A4, 
                0x9C, 
                0x0108, 
                0x0EC4, 
                "DELL", 
                "    ", 
                "Lion", 
                "Dell"
            }) 
            Name (SN0, Buffer (0x04)
            {
                0x31, 0x32, 0x33, 0x34
            })
            If ((ECOK () && (ECDY == Zero)))
            {
                Local0 = B1B2 (^^EC0.DC00,^^EC0.DC01)
                            Sleep (0x14)
                Local1 = B1B2 (^^EC0.FC00,^^EC0.FC01)
                            Sleep (0x14)
                            Local0 *= 0x0A
                            Local1 *= 0x0A
                            STAT [One] = Local0
                            STAT [0x02] = Local1
                STAT [0x04] = B1B2 (^^EC0.DV00,^^EC0.DV01)
                            Sleep (0x14)
                Local2 = B1B2 (^^EC0.SN00,^^EC0.SN01)
                            Sleep (0x14)
                Local3 = B1B2 (^^EC0.FC00,^^EC0.FC01)
                            Sleep (0x14)
                            Local3 = (Local3 *= 0x32 / 0x64)
                            STAT [0x05] = Local3
                Local4 = B1B2 (^^EC0.FC00,^^EC0.FC01)
                            Sleep (0x14)
                            Local4 = (Local4 *= 0x1E / 0x64)
                            STAT [0x06] = Local4
                            STAT [0x09] = ^^EC0.XXXX()
                Local0 = B1B2 (^^EC0.SN00,^^EC0.SN01)
                            Local1 = Zero
                            While ((Local1 < 0x04))
                            {
                                Local2 = (Local0 >> (0x0C - (Local1 * 0x04)))
                                Local2 &= 0x0F
                                If ((Local2 > 0x09))
                                {
                                    Local2 += 0x37
                                }
                                Else
                                {
                                    Local2 += 0x30
                                }

                                SN0 [Local1] = Local2
                                Local1++
                            }

                            STAT [0x0A] = SN0
                            Local0 = ^^EC0.BMF0
                            If ((Local0 == One))
                            {
                                STAT [0x0C] = "SANYO"
                            }
                            ElseIf ((Local0 == 0x02))
                            {
                                STAT [0x0C] = "SONY"
                            }
                            ElseIf ((Local0 == 0x03))
                            {
                                STAT [0x0C] = "SDI"
                            }
                            ElseIf ((Local0 == 0x04))
                            {
                                STAT [0x0C] = "PANASONIC"
                            }
                            ElseIf ((Local0 == 0x05))
                            {
                                STAT [0x0C] = "Samsung"
                            }
                            ElseIf ((Local0 == 0x06))
                            {
                                STAT [0x0C] = "Simplo"
                            }
                            ElseIf ((Local0 == 0x07))
                            {
                                STAT [0x0C] = "Dynapack"
                            }
            }

            Return (STAT)
        }
        
        Method (_BST, 0, NotSerialized)
        {
            Name (PBST, Package (0x04)
            {
                One, 
                0x0732, 
                0x0960, 
                0x2B5C
            })
            Local0 = One
            Local1 = 0x0732
            Local2 = 0x0960
            Local3 = 0x2B5C
            If ((ECOK () && (ECDY == Zero)))
            {
                Local0 = ^^EC0.BST0
                            Sleep (0x14)
                Local1 = B1B2 (^^EC0.AC00,^^EC0.AC01)
                            Sleep (0x14)
                Local2 = B1B2 (^^EC0.RC00,^^EC0.RC01)
                            Sleep (0x14)
                Local3 = B1B2 (^^EC0.PV00,^^EC0.PV01)
                            Sleep (0x14)
                Local4 = ^^EC0.GAU0
                            Sleep (0x14)
                            If ((Local1 && 0x8000))
                            {
                                Local1 = ~Local1
                                Local1 &= 0xFFFF
                            }

                            Local0 &= 0x07
                            If ((Local0 == 0x02))
                            {
                                If ((Local4 < 0x50))
                                {
                                    Local1 = ((Local1 = (0x0C80 * Local3)) / 0x03E8)
                                }
                                ElseIf ((Local4 < 0x5A))
                                {
                                    Local1 = ((Local1 = (0x07D0 * Local3)) / 0x03E8)
                                }
                                Else
                                {
                                    Local1 = ((Local1 = (0x03E8 * Local3)) / 0x03E8)
                                }
                            }
                            Else
                            {
                                Local1 = (Local1 *= Local3 / 0x03E8)
                            }

                            If (^^EC0.DBCD)
                            {
                                Sleep (0x14)
                                If (^^EC0.SYS7)
                                {
                                    Sleep (0x14)
                                    Local0 = Zero
                                }
                                Else
                                {
                                    Sleep (0x14)
                                    Local0 = One
                                }
                            }

                            Local2 *= 0x0A
                            PBST [Zero] = Local0
                            PBST [One] = Local1
                            PBST [0x02] = Local2
                            PBST [0x03] = Local3
            }

            Return (PBST)
        }
    }
}
//EOF


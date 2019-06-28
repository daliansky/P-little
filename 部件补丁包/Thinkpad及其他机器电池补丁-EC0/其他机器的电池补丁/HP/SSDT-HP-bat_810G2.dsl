// battery
// In config ACPI, EC:BTIF to XTIF
// Find:     42 54 49 46 09
// Replace:  58 54 49 46 09
// TgtBridge:45 43 5F 5F
//
// In config ACPI, EC:BTST to XTST
// Find:     42 54 53 54 0A
// Replace:  58 54 53 54 0A
// TgtBridge:45 43 5F 5F
//
// In config ACPI, GBTI to XBTI
// Find:     47 42 54 49 01
// Replace:  58 42 54 49 01
// TgtBridge:no
//
// In config ACPI, EC:GBTC to XBTC
// Find:     47 42 54 43 00
// Replace:  58 42 54 43 00
// TgtBridge:45 43 5F 5F
//
// In config ACPI, SBTC to YBTC
// Find:     53 42 54 43 03
// Replace:  59 42 54 43 03
// TgtBridge:no
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External (_SB.PCI0.LPCB.EC0, DeviceObj) 
    External (_SB_.PCI0.LPCB.EC0.BST, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BATN, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BATP, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BRCC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BRCV, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.BSEL, FieldUnitObj) 
    External (_SB_.PCI0.LPCB.EC0.IDIS, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.INAC, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.INCH, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC0.PSSB, FieldUnitObj)
    //
    External (_SB_.PCI0.LPCB.EC0.BTDR, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.BSTA, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.BTMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0.NGBF, IntObj)
    External (_SB_.PCI0.LPCB.EC0.NDCB, IntObj)
    External (_SB_.NBST, PkgObj)
    External (_SB_.NDBS, PkgObj)
    External (_SB_.NBTI, PkgObj)
    //
    External (_SB_.PCI0.LPCB.EC0.NGBT, IntObj)
    External (_SB_.PCI0.LPCB.EC0.ECMX, MutexObj)
    External (_SB_.PCI0.LPCB.EC0.ECRG, IntObj)
    External (_SB_.PCI0.LPCB.EC0.NLB1, IntObj)
    External (_SB_.PCI0.LPCB.EC0.NLB2, IntObj)
    External (_SB_.PCI0.LPCB.EC0.GBSS, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GACS, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GBMF, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GCTL, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GDCH, MethodObj)
    External (_SB_.PCI0.LPCB.EC0.GDNM, MethodObj)
    
    Method (B1B2, 2, NotSerialized)
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }
        
    Scope (\_SB.PCI0.LPCB.EC0)
    { 
        OperationRegion (BRAM, EmbeddedControl, 0x00, 0xFF)          
        Field (BRAM, ByteAcc, NoLock, Preserve)
        {
                        Offset (0x87), 
                            ,    8, 
                            ,    8, 
                        BDC0,8,BDC1,8,//BDC,    16, 
                        Offset (0x8D), 
                        BFC0,8,BFC1,8,//BFC,    16, 
                        RTE0,8,RTE1,8,//BRTE,   16, 
                        Offset (0x92), 
                        BME0,8,BME1,8,//BME,    16, 
                            ,    8, 
                        BDV0,8,BDV1,8,//BDV,    16, 
                        CV10,8,CV11,8,//BCV1,   16, 
                        Offset (0x9B), 
                        ATE0,8,ATE1,8,//BATE,   16, 
                        BPR0,8,BPR1,8,//BPR,    16, 
                        BCR0,8,BCR1,8,//BCR,    16, 
                        BRC0,8,BRC1,8,//BRC,    16, 
                        BCC0,8,BCC1,8,//BCC,    16, 
                        BPV0,8,BPV1,8,//BPV,    16, 
                        CV20,8,CV21,8,//BCV2,   16, 
                        CV30,8,CV31,8,//BCV3,   16, 
                        CV40,8,CV41,8,//BCV4,   16, 
                            ,   16, 
                        ATF0,8,ATF1,8,//BATF,   16, 
                            ,   16, 
                        AXC0,8,AXC1,8,//MAXC,   16, 
                            ,   8, 
                            ,   1, 
                            ,   1, 
                            ,   2, 
                            ,   4, 
                        STS0,8,STS1,8,//BSTS,   16, 
                        Offset (0xC9), 
                        BSN0,8,BSN1,8,//BSN,    16, 
                        DAT0,8,DAT1,8,//BDAT,   16, 
                        Offset (0xD5), 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   8, 
                            ,   4, 
                            ,   4, 
                            ,   16, 
                        CBT0,8,CBT1,8,//CBT,    16, 
        }

                    Method (BTIF, 1, Serialized)
                    {
                        Local7 = (0x01 << Arg0)
                        BTDR (0x01)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        Local0 = \_SB.PCI0.LPCB.EC0.NGBF
                        Release (BTMX)
                        If (((Local0 & Local7) == 0x00))
                        {
                            Return (0x00)
                        }

                        NBST [Arg0] = \_SB.NDBS
                        Acquire (BTMX, 0xFFFF)
                        \_SB.PCI0.LPCB.EC0.NGBT |= Local7
                        Release (BTMX)
                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            BSEL = Arg0
                            Local0 = B1B2 (BFC0, BFC1)
                            DerefOf (NBTI [Arg0]) [0x01] = Local0
                            DerefOf (NBTI [Arg0]) [0x02] = Local0
                            DerefOf (NBTI [Arg0]) [0x04] = B1B2 (BDV0, BDV1)
                            DerefOf (NBTI [Arg0]) [0x05] = \_SB.PCI0.LPCB.EC0.NLB1
                            DerefOf (NBTI [Arg0]) [0x06] = \_SB.PCI0.LPCB.EC0.NLB2
                            Local0 = B1B2 (BSN0, BSN1)
                            Local1 = B1B2 (DAT0, DAT1)
                        }

                        Release (ECMX)
                        Local2 = GBSS (Local0, Local1)
                        DerefOf (NBTI [Arg0]) [0x0A] = Local2
                        Acquire (BTMX, 0xFFFF)
                        \_SB.PCI0.LPCB.EC0.NGBF &= ~Local7
                        Release (BTMX)
                        Return (0x00)
                    }

                    Method (BTST, 2, Serialized)
                    {
                        Local7 = (0x01 << Arg0)
                        BTDR (0x01)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            NBST [Arg0] = Package (0x04)
                                {
                                    0x00, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                }
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        If (Arg1)
                        {
                            \_SB.PCI0.LPCB.EC0.NGBT = 0xFF
                        }

                        Local0 = \_SB.PCI0.LPCB.EC0.NGBT
                        Release (BTMX)
                        If (((Local0 & Local7) == 0x00))
                        {
                            Return (0x00)
                        }

                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            BSEL = Arg0
                            Local0 = \_SB.PCI0.LPCB.EC0.BST
                            Local3 = B1B2 (BPR0, BPR1)
                            DerefOf (NBST [Arg0]) [0x02] = B1B2 (BRC0, BRC1)
                            DerefOf (NBST [Arg0]) [0x03] = B1B2 (BPV0, BPV1)
                        }

                        Release (ECMX)
                        If ((GACS () == 0x01))
                        {
                            Local0 &= ~0x01
                        }
                        Else
                        {
                            Local0 &= ~0x02
                        }

                        If ((Local0 & 0x01))
                        {
                            Acquire (BTMX, 0xFFFF)
                            NDCB = Local7
                            Release (BTMX)
                        }

                        DerefOf (NBST [Arg0]) [0x00] = Local0
                        If ((Local0 & 0x01))
                        {
                            If (((Local3 < 0x0190) || (Local3 > 0x1964)))
                            {
                                Local5 = DerefOf (DerefOf (NBST [Arg0]) [0x01])
                                If (((Local5 < 0x0190) || (Local5 > 0x1964)))
                                {
                                    Local3 = (0x1AF4 / 0x02)
                                }
                                Else
                                {
                                    Local3 = Local5
                                }
                            }
                        }
                        ElseIf (((Local0 & 0x02) == 0x00))
                        {
                            Local3 = 0x00
                        }

                        DerefOf (NBST [Arg0]) [0x01] = Local3
                        Acquire (BTMX, 0xFFFF)
                        \_SB.PCI0.LPCB.EC0.NGBT &= ~Local7
                        Release (BTMX)
                        Return (0x00)
                    }

                    Method (GBTI, 1, NotSerialized)
                    {
                        Debug = "Enter getbattinfo"
                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            If ((BATP & (0x01 << Arg0)))
                            {
                                BSEL = Arg0
                                Local0 = Package (0x03)
                                    {
                                        0x00, 
                                        0x6B, 
                                        Buffer (0x6B){}
                                    }
                                DerefOf (Local0 [0x02]) [0x00] = B1B2 (BDC0, BDC1)
                                DerefOf (Local0 [0x02]) [0x01] = (B1B2 (BDC0, BDC1) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x02] = B1B2 (BFC0, BFC1)
                                DerefOf (Local0 [0x02]) [0x03] = (B1B2 (BFC0, BFC1) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x04] = B1B2 (BRC0, BRC1)
                                DerefOf (Local0 [0x02]) [0x05] = (B1B2 (BRC0, BRC1) >> 0x08
                                    )
                                //wxw???
                                DerefOf (Local0 [0x02]) [0x06] = B1B2 (BME0, BME1)
                                DerefOf (Local0 [0x02]) [0x07] = (B1B2 (BME0, BME1) >> 0x08
                                    )
                                
                                DerefOf (Local0 [0x02]) [0x08] = B1B2 (BCC0, BCC1)
                                DerefOf (Local0 [0x02]) [0x09] = (B1B2 (BCC0, BCC1) >> 0x08
                                    )
                                Local1 = B1B2 (CBT0, CBT1)
                                Local1 -= 0x0AAC
                                Divide (Local1, 0x0A, Local2, Local3)
                                DerefOf (Local0 [0x02]) [0x0A] = Local3
                                DerefOf (Local0 [0x02]) [0x0B] = (Local3 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x0C] = B1B2 (BPV0, BPV1)
                                DerefOf (Local0 [0x02]) [0x0D] = (B1B2 (BPV0, BPV1) >> 0x08
                                    )
                                Local1 = B1B2 (BPR0, BPR1)
                                If (Local1)
                                {
                                    If ((B1B2 (STS0, STS1) & 0x40))
                                    {
                                        Local1 = (~Local1 + 0x01)
                                        Local1 &= 0xFFFF
                                    }
                                }

                                DerefOf (Local0 [0x02]) [0x0E] = Local1
                                DerefOf (Local0 [0x02]) [0x0F] = (Local1 >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x10] = B1B2 (BDV0, BDV1)
                                DerefOf (Local0 [0x02]) [0x11] = (B1B2 (BDV0, BDV1) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x12] = B1B2 (STS0, STS1)
                                DerefOf (Local0 [0x02]) [0x13] = (B1B2 (STS0, STS1) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x14] = B1B2 (CV10, CV11)
                                DerefOf (Local0 [0x02]) [0x15] = (B1B2 (CV10, CV11) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x16] = B1B2 (CV20, CV21)
                                DerefOf (Local0 [0x02]) [0x17] = (B1B2 (CV20, CV21) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x18] = B1B2 (CV30, CV31)
                                DerefOf (Local0 [0x02]) [0x19] = (B1B2 (CV30, CV31) >> 0x08
                                    )
                                DerefOf (Local0 [0x02]) [0x1A] = B1B2 (CV40, CV41)
                                DerefOf (Local0 [0x02]) [0x1B] = (B1B2 (CV40, CV41) >> 0x08
                                    )
                                CreateField (DerefOf (Local0 [0x02]), (0x1C * 0x08), (0x10 * 
                                    0x08), BTSN)
                                BTSN = GBSS (B1B2 (BSN0, BSN1), B1B2 (DAT0, DAT1))
                                Local1 = GBMF ()
                                Local2 = SizeOf (Local1)
                                CreateField (DerefOf (Local0 [0x02]), (0x2C * 0x08), (Local2 * 
                                    0x08), BMAN)
                                BMAN = Local1
                                Local2 += 0x2C
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x10 * 
                                    0x08), CLBL)
                                CLBL = GCTL (0x00)
                                Local2 += 0x11
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x07 * 
                                    0x08), DNAM)
                                DNAM = GDNM (0x00)
                                Local2 += 0x07
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x04 * 
                                    0x08), DCHE)
                                DCHE = GDCH (0x00)
                                Local2 += 0x04
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BMAC)
                                BMAC = 0x00
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BMAD)
                                BMAD = B1B2 (DAT0, DAT1)
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BCCU)
                                BCCU = \_SB.PCI0.LPCB.EC0.BRCC
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BCVO)
                                BCVO = \_SB.PCI0.LPCB.EC0.BRCV
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), BAVC)
                                Local1 = B1B2 (BCR0, BCR1)
                                If (Local1)
                                {
                                    If ((B1B2 (STS0, STS1) & 0x40))
                                    {
                                        Local1 = (~Local1 + 0x01)
                                        Local1 &= 0xFFFF
                                    }
                                }

                                BAVC = Local1
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), RTTE)
                                RTTE = B1B2 (RTE0, RTE1)
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), ATTE)
                                RTTE = B1B2 (ATE0, ATE1)
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x02 * 
                                    0x08), ATTF)
                                RTTE = B1B2 (ATF0, ATF1)
                                Local2 += 0x02
                                CreateField (DerefOf (Local0 [0x02]), (Local2 * 0x08), (0x01 * 
                                    0x08), NOBS)
                                NOBS = \_SB.PCI0.LPCB.EC0.BATN
                            }
                            Else
                            {
                                Local0 = Package (0x02)
                                    {
                                        0x34, 
                                        0x00
                                    }
                            }
                        }
                        Else
                        {
                            Local0 = Package (0x02)
                                {
                                    0x0D, 
                                    0x00
                                }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }
                    
                    
                    Method (GBTC, 0, NotSerialized)
                    {
                        Debug = "Enter GetBatteryControl"
                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            Local0 = Package (0x03)
                                {
                                    0x00, 
                                    0x04, 
                                    Buffer (0x04){}
                                }
                            If ((BATP & 0x01))
                            {
                                BSEL = 0x00
                                DerefOf (Local0 [0x02]) [0x00] = 0x00
                                If ((((INAC == 0x00) && (INCH == 0x00)) && (IDIS == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x00
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x02)) && (
                                    IDIS == 0x01)) && (B1B2 (AXC0, AXC1) == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x01
                                }
                                ElseIf (((INAC == 0x01) && (IDIS == 0x02)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x02
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x02)) && (
                                    IDIS == 0x01)) && (B1B2 (AXC0, AXC1) == 0xFA)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x03
                                }
                                ElseIf (((INAC == 0x00) && (INCH == 0x03)))
                                {
                                    DerefOf (Local0 [0x02]) [0x00] = 0x04
                                }
                            }
                            Else
                            {
                                DerefOf (Local0 [0x02]) [0x00] = 0xFF
                            }

                            If ((BATP & 0x02))
                            {
                                BSEL = 0x01
                                DerefOf (Local0 [0x02]) [0x01] = 0x00
                                If ((((INAC == 0x00) && (INCH == 0x00)) && (IDIS == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x00
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x01)) && (
                                    IDIS == 0x02)) && (B1B2 (AXC0, AXC1) == 0x00)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x01
                                }
                                ElseIf (((INAC == 0x01) && (IDIS == 0x01)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x02
                                }
                                ElseIf (((((INAC == 0x00) && (INCH == 0x01)) && (
                                    IDIS == 0x02)) && (B1B2 (AXC0, AXC1) == 0xFA)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x03
                                }
                                ElseIf (((INAC == 0x00) && (INCH == 0x03)))
                                {
                                    DerefOf (Local0 [0x02]) [0x01] = 0x04
                                }
                            }
                            Else
                            {
                                DerefOf (Local0 [0x02]) [0x01] = 0xFF
                            }
                        }
                        Else
                        {
                            Local0 = Package (0x02)
                                {
                                    0x35, 
                                    0x00
                                }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }
                    Method (SBTC, 3, NotSerialized)
                    {
                        Debug = "Enter SetBatteryControl"
                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            Local0 = Arg2
                            Debug = Local0
                            Local4 = Package (0x02)
                                {
                                    0x06, 
                                    0x00
                                }
                            Local1 = 0x00
                            Local2 = 0x00
                            Local1 = DerefOf (Local0 [0x10])
                            If ((Local1 == 0x00))
                            {
                                Debug = "battery 0"
                                If ((BATP & 0x01))
                                {
                                    Local2 = DerefOf (Local0 [0x11])
                                    If ((Local2 == 0x00))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        AXC0 = Zero
                                        AXC1 = Zero
                                        PSSB = 0x01
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x01))
                                    {
                                        INAC = 0x00
                                        INCH = 0x02
                                        IDIS = 0x01
                                        AXC0 = Zero
                                        AXC1 = Zero
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x02))
                                    {
                                        INAC = 0x01
                                        INCH = 0x01
                                        IDIS = 0x02
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x03))
                                    {
                                        INCH = 0x02
                                        IDIS = 0x01
                                        INAC = 0x00
                                        AXC0 = 0xFA
                                        AXC1 = Zero
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x04))
                                    {
                                        AXC0 = 0xFA
                                        AXC0 = Zero
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x05))
                                    {
                                        INAC = 0x00
                                        INCH = 0x03
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }
                                }
                                Else
                                {
                                    Local4 = Package (0x02)
                                        {
                                            0x34, 
                                            0x00
                                        }
                                }
                            }

                            If ((Local1 == 0x01))
                            {
                                If ((BATP & 0x02))
                                {
                                    Debug = "battery 1"
                                    Local2 = DerefOf (Local0 [0x11])
                                    If ((Local2 == 0x00))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        AXC0 = Zero
                                        AXC1 = Zero
                                        PSSB = 0x01
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x01))
                                    {
                                        INAC = 0x00
                                        INCH = 0x01
                                        IDIS = 0x02
                                        AXC0 = Zero
                                        AXC1 = Zero
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x02))
                                    {
                                        INAC = 0x01
                                        INCH = 0x02
                                        IDIS = 0x01
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x03))
                                    {
                                        INCH = 0x01
                                        IDIS = 0x02
                                        INAC = 0x00
                                        AXC0 = 0xFA
                                        AXC1 = Zero
                                        PSSB = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x04))
                                    {
                                        INCH = 0x00
                                        IDIS = 0x00
                                        INAC = 0x00
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }

                                    If ((Local2 == 0x05))
                                    {
                                        INAC = 0x00
                                        INCH = 0x03
                                        Local4 = Package (0x02)
                                            {
                                                0x00, 
                                                0x00
                                            }
                                    }
                                }
                                Else
                                {
                                    Local4 = Package (0x02)
                                        {
                                            0x34, 
                                            0x00
                                        }
                                }
                            }
                        }

                        Release (ECMX)
                        Return (Local4)
                    }

    }
}
//EOF


// battery
// In config ACPI, H_EC renamed EC0
// Find:     48 5F 45 43
// Replace:  45 43 30 5F
//
// In config ACPI, BTIF renamed XTIF
// Find:     42 54 49 46 09
// Replace:  58 54 49 46 09
// TgtBridge:45 43 5F 5F
//
// In config ACPI, BTST renamed XTST
// Find:     42 54 53 54 0A
// Replace:  58 54 53 54 0A
// TgtBridge:45 43 5F 5F
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BTDR, MethodObj)
    External(_SB.PCI0.LPCB.EC0.BSTA, MethodObj)
    External(_SB.PCI0.LPCB.EC0.BTMX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.NGBF, IntObj)
    External(_SB.NBST, PkgObj)
    External(_SB.NDBS, PkgObj)
    External(_SB.PCI0.LPCB.EC0.NGBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.ECMX, MutexObj)
    External(_SB.PCI0.LPCB.EC0.ECRG, IntObj)
    External(_SB.PCI0.LPCB.EC0.BSEL, FieldUnitObj)
    External(_SB.NBTI, PkgObj)
    External(_SB.PCI0.LPCB.EC0.NLB1, IntObj)
    External(_SB.PCI0.LPCB.EC0.NLB2, IntObj)
    External(_SB.PCI0.LPCB.EC0.GBSS, MethodObj)
    External(_SB.PCI0.LPCB.EC0.BST0, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BST1, FieldUnitObj)

    Method (B1B2, 2, NotSerialized)
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
        
        Method (WE1B, 2, NotSerialized)
        {
            OperationRegion(ERAM, EmbeddedControl, Arg0, 1)
            Field(ERAM, ByteAcc, NoLock, Preserve) { BYTE, 8 }
            Store(Arg1, BYTE)
        }
        Method (WECB, 3, Serialized)
        {
            ShiftRight(Arg1, 3, Arg1)
            Name(TEMP, Buffer(Arg1) { })
            Store(Arg2, TEMP)
            Add(Arg0, Arg1, Arg1)
            Store(0, Local0)
            While (LLess(Arg0, Arg1))
            {
                WE1B(Arg0, DerefOf(Index(TEMP, Local0)))
                Increment(Arg0)
                Increment(Local0)
            }
        }
        
        OperationRegion (BAM0, EmbeddedControl, 0x00, 0xFF)           
        Field (BAM0, ByteAcc, Lock, Preserve)
        {
            Offset (0x87), 
                ,    8, 
                ,    8, 
                ,   16, 
                ,   16, 
            FC00,8,FC01,8,//BFC0,   16, 
            FC10,8,FC11,8,//BFC1,   16, 
            
            Offset (0x93), 
            DV00,8,DV01,8,//BDV0,   16, 
            DV10,8,DV11,8,//BDV1,   16, 
            
            Offset (0x9B), 
            PR00,8,PR01,8,//BPR0,   16, 
            PR10,8,PR11,8,//BPR1,   16, 
            RC00,8,RC01,8,//BRC0,   16, 
            RC10,8,RC11,8,//BRC1,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   16, 
                ,   8, 
                ,   8, 
            MD00,8,MD01,8,//BMD0,   16, 
            MD10,8,MD11,8,//BMD1,   16, 
            PV00,8,PV01,8,//BPV0,   16, 
            PV10,8,PV11,8,//BPV1,   16,                         
            SN00,8,SN01,8,//BSN0,   16, 
            SN10,8,SN11,8,//BSN1,   16, 
        }
    }
        
    Scope(\_SB.PCI0.LPCB.EC0)
    {      
                    Method (BTIF, 1, Serialized)
                    {
                        Local7 = (One << Arg0)
                        BTDR (One)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        Local0 = \_SB.PCI0.LPCB.EC0.NGBF
                        Release (BTMX)
                        If (((Local0 & Local7) == Zero))
                        {
                            Return (Zero)
                        }

                        NBST [Arg0] = \_SB.NDBS
                        Acquire (BTMX, 0xFFFF)
                        \_SB_.PCI0.LPCB.EC0.NGBT |= Local7
                        Release (BTMX)
                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            BSEL = Arg0
                            Switch (Arg0)
                            {
                                Case (Zero)
                                {
                                    Local0 = B1B2 (FC00, FC01)//BFC0
                                    DerefOf (NBTI [Arg0]) [One] = Local0
                                    DerefOf (NBTI [Arg0]) [0x02] = Local0
                                    DerefOf (NBTI [Arg0]) [0x04] = B1B2 (DV00, DV01)//BDV0
                                }
                                Case (One)
                                {
                                    Local0 = B1B2 (FC10, FC11)//BFC1
                                    DerefOf (NBTI [Arg0]) [One] = Local0
                                    DerefOf (NBTI [Arg0]) [0x02] = Local0
                                    DerefOf (NBTI [Arg0]) [0x04] = B1B2 (DV10, DV11)//BDV1
                                }

                            }

                            Local1 = (Local0 * \_SB.PCI0.LPCB.EC0.NLB1)
                            Divide ((Local1 + 0x63), 0x64, Local3, Local2)
                            DerefOf (NBTI [Arg0]) [0x05] = Local2
                            DerefOf (NBTI [Arg0]) [0x05] = \_SB.PCI0.LPCB.EC0.NLB1
                            DerefOf (NBTI [Arg0]) [0x06] = \_SB.PCI0.LPCB.EC0.NLB2
                            Switch (Arg0)
                            {
                                Case (Zero)
                                {
                                    Local0 = B1B2 (SN00, SN01)//BSN0
                                    Local1 = B1B2 (MD00, MD01)//BMD0
                                }
                                Case (One)
                                {
                                    Local0 = B1B2 (SN10, SN11)//BSN1
                                    Local1 = B1B2 (MD10, MD11)//BMD1
                                }

                            }
                        }

                        Release (ECMX)
                        Local2 = GBSS (Local0, Local1)
                        DerefOf (NBTI [Arg0]) [0x0A] = Local2
                        Acquire (BTMX, 0xFFFF)
                        \_SB.PCI0.LPCB.EC0.NGBF &= ~Local7
                        Release (BTMX)
                        Return (Zero)
                    }
    }
    //
    Scope(\_SB.PCI0.LPCB.EC0)
    {
                    Method (BTST, 2, Serialized)
                    {
                        Local7 = (One << Arg0)
                        BTDR (One)
                        If ((BSTA (Local7) == 0x0F))
                        {
                            NBST [Arg0] = Package (0x04)
                                {
                                    Zero, 
                                    Ones, 
                                    Ones, 
                                    Ones
                                }
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        If (Arg1)
                        {
                            \_SB_.PCI0.LPCB.EC0.NGBT = 0xFF
                        }

                        Local0 = \_SB_.PCI0.LPCB.EC0.NGBT
                        Release (BTMX)
                        If (((Local0 & Local7) == Zero))
                        {
                            Return (Zero)
                        }

                        Acquire (ECMX, 0xFFFF)
                        If (\_SB.PCI0.LPCB.EC0.ECRG)
                        {
                            BSEL = Arg0
                            Switch (Arg0)
                            {
                                Case (Zero)
                                {
                                    Local0 = \_SB_.PCI0.LPCB.EC0.BST0
                                    Local3 = B1B2 (PR00,PR01)//BPR0
                                    DerefOf (NBST [Arg0]) [0x02] = B1B2 (RC00,RC01)//BRC0
                                    DerefOf (NBST [Arg0]) [0x03] = B1B2 (PV00,PV01)//BPV0
                                }
                                Case (One)
                                {
                                    Local0 = \_SB_.PCI0.LPCB.EC0.BST1
                                    Local3 = B1B2 (PR10,PR11)//BPR1
                                    DerefOf (NBST [Arg0]) [0x02] = B1B2 (RC10,RC11)//BRC1
                                    DerefOf (NBST [Arg0]) [0x03] = B1B2 (PV10,PV11)//BPV1
                                }

                            }
                        }

                        Release (ECMX)
                        DerefOf (NBST [Arg0]) [Zero] = Local0
                        If ((Local0 & One))
                        {
                            Switch (Arg0)
                            {
                                Case (Zero)
                                {
                                    Local3 = (0x00010000 - B1B2 (PR00,PR01))//BPR0
                                }
                                Case (One)
                                {
                                    Local3 = (0x00010000 - B1B2 (PR10,PR11))//BPR1
                                }

                            }

                            If (((Local3 < 0x0190) || (Local3 > 0x1964)))
                            {
                                Local5 = DerefOf (DerefOf (NBST [Arg0]) [One])
                                If (((Local5 < 0x0190) || (Local5 > 0x1964)))
                                {
                                    Local3 = Ones
                                }
                                Else
                                {
                                    Local3 = Ones
                                }
                            }
                        }

                        DerefOf (NBST [Arg0]) [One] = Local3
                        Acquire (BTMX, 0xFFFF)
                        \_SB_.PCI0.LPCB.EC0.NGBT &= ~Local7
                        Release (BTMX)
                        Return (Zero)
                    }
    }
}
//EOF


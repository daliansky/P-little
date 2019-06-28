// battery
// In config ACPI, _BIX renamed XBIX
// Find:     5F 42 49 58
// Replace:  58 42 49 58
//
// In config ACPI, SMBR renamed XMBR
// Find:     53 4D 42 52 0B
// Replace:  58 4D 42 52 0B
//
// In config ACPI, SMBW renamed XMBW
// Find:     53 4D 42 57 0D
// Replace:  58 4D 42 57 0D
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.BAT0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BATP, MethodObj)
    External(_SB.PCI0.LPCB.EC0.GBTT, MethodObj)
    External(_SB.PCI0.BAT0._BIF, MethodObj)
    External(_SB.PCI0.BAT0.NBIX, PkgObj)
    External(_SB.PCI0.BAT0.PBIF, PkgObj)
    External(_SB.PCI0.BAT0.BIXT, PkgObj)
    //
    External(_SB.PCI0.LPCB.EC0.ECAV, MethodObj)
    External(_SB.PCI0.LPCB.EC0.RDBL, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDWD, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.RCBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.RDQK, IntObj)
    
    External(_SB.PCI0.LPCB.EC0.WRBL, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRWD, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.SDBT, IntObj)
    External(_SB.PCI0.LPCB.EC0.WRQK, IntObj)
    External(_SB.PCI0.LPCB.EC0.SBBY, IntObj)
    //
    External(_SB.PCI0.LPCB.EC0.MUEC, MutexObj)
    External(_SB.PCI0.LPCB.EC0.PRTC, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.ADDR, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.CMDB, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.BCNT, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC0.DAT0, FieldUnitObj)
    
    External(_SB.PCI0.LPCB.EC0.SWTC, MethodObj)
    //
    
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
            Offset (0xBE), 
                ,16,
                ,16,
                ,16,
            B030,8,B031,8,    //B0C3,   16,
        }       
        OperationRegion (BAM1, EmbeddedControl, 0x18, 0x28)
        Field (BAM1, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            XXXX,    256,     //BDAT,   256,
        }
        Field (BAM1, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            DT20,8,DT21,8,    //DT2B,   16
        }
        
        OperationRegion (BAM2, EmbeddedControl, 0x40, 0x28)
        Field (BAM2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x04), 
            YYYY,    256,     //BDA2,   256,
        }
    }
        
    Scope(_SB.PCI0.BAT0)
    {      
        Method (_BIX, 0, NotSerialized)
        {
            If (LNot (^^LPCB.EC0.BATP (Zero)))
            {
                Return (\_SB.PCI0.BAT0.NBIX)
            }

            If (LEqual (^^LPCB.EC0.GBTT (Zero), 0xFF))
            {
                Return (\_SB.PCI0.BAT0.NBIX)
            }

            _BIF ()
            Store (DerefOf (Index (PBIF, Zero)), Index (BIXT, One))
            Store (DerefOf (Index (PBIF, One)), Index (BIXT, 0x02))
            Store (DerefOf (Index (PBIF, 0x02)), Index (BIXT, 0x03))
            Store (DerefOf (Index (PBIF, 0x03)), Index (BIXT, 0x04))
            Store (DerefOf (Index (PBIF, 0x04)), Index (BIXT, 0x05))
            Store (DerefOf (Index (PBIF, 0x05)), Index (BIXT, 0x06))
            Store (DerefOf (Index (PBIF, 0x06)), Index (BIXT, 0x07))
            Store (DerefOf (Index (PBIF, 0x07)), Index (BIXT, 0x08))
            Store (DerefOf (Index (PBIF, 0x08)), Index (BIXT, 0x09))
            Store (DerefOf (Index (PBIF, 0x09)), Index (BIXT, 0x10))
            Store (DerefOf (Index (PBIF, 0x0A)), Index (BIXT, 0x11))
            Store (DerefOf (Index (PBIF, 0x0B)), Index (BIXT, 0x12))
            Store (DerefOf (Index (PBIF, 0x0C)), Index (BIXT, 0x13))
            If (LEqual (DerefOf (Index (BIXT, One)), One))
            {
                Store (Zero, Index (BIXT, One))
                Store (DerefOf (Index (BIXT, 0x05)), Local0)
                Multiply (DerefOf (Index (BIXT, 0x02)), Local0, Index (BIXT, 0x02))
                Multiply (DerefOf (Index (BIXT, 0x03)), Local0, Index (BIXT, 0x03))
                Multiply (DerefOf (Index (BIXT, 0x06)), Local0, Index (BIXT, 0x06))
                Multiply (DerefOf (Index (BIXT, 0x07)), Local0, Index (BIXT, 0x07))
                Multiply (DerefOf (Index (BIXT, 0x08)), Local0, Index (BIXT, 0x08))
                Multiply (DerefOf (Index (BIXT, 0x09)), Local0, Index (BIXT, 0x09))
                Divide (DerefOf (Index (BIXT, 0x02)), 0x03E8, Local0, Index (BIXT, 0x02))
                Divide (DerefOf (Index (BIXT, 0x03)), 0x03E8, Local0, Index (BIXT, 0x03))
                Divide (DerefOf (Index (BIXT, 0x06)), 0x03E8, Local0, Index (BIXT, 0x06))
                Divide (DerefOf (Index (BIXT, 0x07)), 0x03E8, Local0, Index (BIXT, 0x07))
                Divide (DerefOf (Index (BIXT, 0x08)), 0x03E8, Local0, Index (BIXT, 0x08))
                Divide (DerefOf (Index (BIXT, 0x09)), 0x03E8, Local0, Index (BIXT, 0x09))
            }

            Store (B1B2 (^^LPCB.EC0.B030, ^^LPCB.EC0.B031), Index (BIXT, 0x0A))
            Store (0x0001869F, Index (BIXT, 0x0B))
            Return (\_SB.PCI0.BAT0.BIXT)
        }
    }
    //
    Scope(\_SB.PCI0.LPCB.EC0)
    {
        Method (SMBR, 3, Serialized)
        {
            Store (Package (0x03)
                {
                    0x07, 
                    Zero, 
                    Zero
                }, Local0)
            If (LNot (ECAV ()))
            {
                Return (Local0)
            }

            If (LNotEqual (Arg0, RDBL))
            {
                If (LNotEqual (Arg0, RDWD))
                {
                    If (LNotEqual (Arg0, RDBT))
                    {
                        If (LNotEqual (Arg0, RCBT))
                        {
                            If (LNotEqual (Arg0, RDQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            Acquire (MUEC, 0xFFFF)
            Store (\_SB.PCI0.LPCB.EC0.PRTC, Local1)
            Store (Zero, Local2)
            While (LNotEqual (Local1, Zero))
            {
                Stall (0x0A)
                Increment (Local2)
                If (LGreater (Local2, 0x03E8))
                {
                    Store (\_SB.PCI0.LPCB.EC0.SBBY, Index (Local0, Zero))
                    Store (Zero, Local1)
                }
                Else
                {
                    Store (\_SB.PCI0.LPCB.EC0.PRTC, Local1)
                }
            }

            If (LLessEqual (Local2, 0x03E8))
            {
                ShiftLeft (Arg1, One, Local3)
                Or (Local3, One, Local3)
                Store (Local3, ADDR)
                If (LNotEqual (Arg0, RDQK))
                {
                    If (LNotEqual (Arg0, RCBT))
                    {
                        Store (Arg2, CMDB)
                    }
                }

                WECB (0x04, 0x0100, Zero) //BDAT
                Store (Arg0, \_SB.PCI0.LPCB.EC0.PRTC)
                Store (SWTC (Arg0), Index (Local0, Zero))
                If (LEqual (DerefOf (Index (Local0, Zero)), Zero))
                {
                    If (LEqual (Arg0, RDBL))
                    {
                        Store (\_SB.PCI0.LPCB.EC0.BCNT, Index (Local0, One))
                        Store (RECB(0x04,0x100), Index (Local0, 0x02))//BDAT
                    }

                    If (LEqual (Arg0, RDWD))
                    {
                        Store (0x02, Index (Local0, One))
                        Store (B1B2 (\_SB.PCI0.LPCB.EC0.DT20, \_SB.PCI0.LPCB.EC0.DT21), Index (Local0, 0x02))
                        //DT2B
                    }

                    If (LEqual (Arg0, RDBT))
                    {
                        Store (One, Index (Local0, One))
                        Store (\_SB.PCI0.LPCB.EC0.DAT0, Index (Local0, 0x02))
                    }

                    If (LEqual (Arg0, RCBT))
                    {
                        Store (One, Index (Local0, One))
                        Store (\_SB.PCI0.LPCB.EC0.DAT0, Index (Local0, 0x02))
                    }
                }
            }

            Release (MUEC)
            Return (Local0)
        }
        
        Method (SMBW, 5, Serialized)
        {
            Store (Package (0x01)
                {
                    0x07
                }, Local0)
            If (LNot (ECAV ()))
            {
                Return (Local0)
            }

            If (LNotEqual (Arg0, WRBL))
            {
                If (LNotEqual (Arg0, WRWD))
                {
                    If (LNotEqual (Arg0, WRBT))
                    {
                        If (LNotEqual (Arg0, SDBT))
                        {
                            If (LNotEqual (Arg0, WRQK))
                            {
                                Return (Local0)
                            }
                        }
                    }
                }
            }

            Acquire (MUEC, 0xFFFF)
            Store (\_SB.PCI0.LPCB.EC0.PRTC, Local1)
            Store (Zero, Local2)
            While (LNotEqual (Local1, Zero))
            {
                Stall (0x0A)
                Increment (Local2)
                If (LGreater (Local2, 0x03E8))
                {
                    Store (\_SB.PCI0.LPCB.EC0.SBBY, Index (Local0, Zero))
                    Store (Zero, Local1)
                }
                Else
                {
                    Store (\_SB.PCI0.LPCB.EC0.PRTC, Local1)
                }
            }

            If (LLessEqual (Local2, 0x03E8))
            {
                WECB (0x04, 0x0100, Zero) //BDAT
                ShiftLeft (Arg1, One, Local3)
                Store (Local3, ADDR)
                If (LNotEqual (Arg0, WRQK))
                {
                    If (LNotEqual (Arg0, SDBT))
                    {
                        Store (Arg2, CMDB)
                    }
                }

                If (LEqual (Arg0, WRBL))
                {
                    Store (Arg3, \_SB.PCI0.LPCB.EC0.BCNT)
                    WECB (0x04, 0x0100, Arg4) //BDAT
                }

                If (LEqual (Arg0, WRWD))
                {
                    Store (Arg4, B1B2 (\_SB.PCI0.LPCB.EC0.DT20, \_SB.PCI0.LPCB.EC0.DT21))   
                    //DT2B
                }

                If (LEqual (Arg0, WRBT))
                {
                    Store (Arg4, \_SB.PCI0.LPCB.EC0.DAT0)
                }

                If (LEqual (Arg0, SDBT))
                {
                    Store (Arg4, \_SB.PCI0.LPCB.EC0.DAT0)
                }

                Store (Arg0, \_SB.PCI0.LPCB.EC0.PRTC)
                Store (SWTC (Arg0), Index (Local0, Zero))
            }

            Release (MUEC)
            Return (Local0)
        }
    }
}
//EOF


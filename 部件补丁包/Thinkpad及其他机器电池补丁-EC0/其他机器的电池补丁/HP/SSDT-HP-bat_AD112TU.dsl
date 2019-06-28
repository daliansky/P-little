// battery 
//
//1:BTIF to XTIF
//Find      :4254494609
//Replace   :5854494609
//TgtBridge :45435F5F
//
//2:BTST to XTST
//Find      :425453540A
//Replace   :585453540A
//
//3:ITLB to XTLB
//Find      :49544C4200
//Replace   :58544C4200
//
//4:GBTI to XBTI
//Find      :4742544901
//Replace   :5842544901
//TgtBridge :45435F5F

DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(\_SB.PCI0.LPCB, DeviceObj)
    External(\_SB.PCI0.LPCB.EC0, DeviceObj) 
    External(\_SB.PCI0.LPCB.EC0.BTDR, MethodObj)
    External(\_SB.PCI0.LPCB.EC0.BSTA, MethodObj)
    External(\_SB.PCI0.LPCB.EC0.GBSS, MethodObj)
    External(\_SB.PCI0.LPCB.EC0.BTMX, MutexObj)
    
    External(\_SB.PCI0.LPCB.EC0.NGBF, IntObj)
    External(\_SB.PCI0.LPCB.EC0.NGBT, IntObj)
    External(\_SB.PCI0.LPCB.EC0.NLB1, IntObj)
    External(\_SB.PCI0.LPCB.EC0.NLB2, IntObj)
    External(\_SB.PCI0.LPCB.EC0.ECRG, IntObj)

    External(\_SB.NDBS, IntObj)
    External(\_SB.NBTI, IntObj)
    External(\_SB.NBST, IntObj)
    
    External(\QQ70, FieldUnitObj)
    External(\_SB.WMID.BRTE, FieldUnitObj)
    External(\_SB.PCI0.LPCB.LB1, FieldUnitObj)
    External(\_SB.PCI0.LPCB.LB2, FieldUnitObj)
    External(\_SB.PCI0.LPCB.BST0, FieldUnitObj)
    External(\_SB.PCI0.LPCB.BSEL, FieldUnitObj)
    External(\_SB.PCI0.LPCB.BTAP, FieldUnitObj)
    //_Q09...
    External(H2OP, MethodObj)
    External(\_SB.PCI0.LPCB.EC0.PWUP, MethodObj)
    External(\_SB.BAT0, DeviceObj)
    
    Method (B1B2, 2, NotSerialized)//16
    {
        ShiftLeft (Arg1, 8, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }

    Method (B1B4, 4, NotSerialized)//32
    {
        Store (Arg3, Local0)
        Or (Arg2, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg1, ShiftLeft (Local0, 0x08), Local0)
        Or (Arg0, ShiftLeft (Local0, 0x08), Local0)
        Return (Local0)
    }
    
    Scope(\_SB.PCI0.LPCB.EC0)
    {   
        Scope (^^LPCB)
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
        
            Method (RMN0, 0, Serialized) { Return(RECB(0x20,128)) }//BMN0
            Method (RCT0, 0, Serialized) { Return(RECB(0x30,128)) }//BCT0
            Method (RDN0, 0, Serialized) { Return(RECB(0x10,56)) }//BCT0

            OperationRegion (BRAM, SystemMemory, 0xFE700600, 0x0100)
            Field (BRAM, ByteAcc, NoLock, Preserve)
            {
                    Offset (0x10), 
                    //BDN0,   56, 
                    Offset (0x20),
                    //BMN0,   128, //BMN0,   128,
                    Offset (0x30),
                    //BCT0,   128, //BCT0,   128,

                    Offset (0x87), 
                     ,    8, 
                     ,    8, 
                    DC00,8,DC01,8,//BDC0,   16,
                     ,   16,        //BDC1,   16,
                    FC00,8,FC01,8,//BFC0,   16,
                    FC10,8,FC11,8,//BFC1,   16, 
                    Offset (0x93), 
                    DV00,8,DV01,8,//BDV0,   16, 
                    DV10,8,DV11,8,//BDV1,   16, 

                    Offset (0x9B), 
                    PR00,8,PR01,8,//BPR0,   16, 
                     ,   16,        //BPR1,   16,
                    RC00,8,RC01,8,//BRC0,   16,
                     ,   16,        //BRC1,   16,
                    CC00,8,CC01,8,//BCC0,   16, 
                    CC10,8,CC11,8,//BCC1,   16,
                    V010,8,V011,8,//CV01,   16,
                    V020,8,V021,8,//CV02,   16,
                    V030,8,V031,8,//CV03,   16,
                    V040,8,V041,8,//CV04,   16, 
                     ,   16,        //CV11,   16
                     ,   16,        //CV12,   16
                     ,   16,        //CV13,   16
                     ,   16,        //CV14,   16
                     ,   16,        //HPBA,   16,
                     ,   16,        //HPBB,   16,
                     ,   8,         //STS0,   8,
                     ,   8,         //STS1,   8,
                    MD00,8,MD01,8,//BMD0,   16, 
                    MD10,8,MD11,8,//BMD1,   16,
                    PV00,8,PV01,8,//BPV0,   16,
                     ,   16,        //BPV1,   16,
                    SN00,8,SN01,8,//BSN0,   16, 
                    SN10,8,SN11,8,//BSN1,   16,
                    CV0A,8,CV0B,8,//BCV0,   16,
                     ,   16,        //BCV1,   16,
                    RG00,8,RG01,8,//CRG0,   16,
                     ,   16,        //CRG1,   16, 
                    TY00,8,TY01,8,//BTY0,   32,
                    TY02,8,TY03,8,
                    Offset (0xEB), 
                        ,   2, 
                        ,   1, 
                        ,   1, 
                        ,   1, 
                        ,   1, 
                        ,   1, 
                        ,   1, 
                    BT00,8,BT01,8,//CBT0,   16, 
                    Offset (0xFA)
            }
        }
            
        Method (BTIF, 1, Serialized)
        {
                Name (_T_1, Zero)
                Name (_T_0, Zero)
                ShiftLeft (One, Arg0, Local7)
                \_SB.PCI0.LPCB.EC0.BTDR (One)
                If (LEqual (\_SB.PCI0.LPCB.EC0.BSTA (Local7), 0x0F))
                {
                    Return (0xFF)
                }

                Acquire (\_SB.PCI0.LPCB.EC0.BTMX, 0xFFFF)
                Store (\_SB.PCI0.LPCB.EC0.NGBF, Local0)
                Release (\_SB.PCI0.LPCB.EC0.BTMX)
                If (LEqual (And (Local0, Local7), Zero))
                {
                    Return (Zero)
                }

                Store (\_SB.NDBS, Index (\_SB.NBST, Arg0))/////
                Acquire (\_SB.PCI0.LPCB.EC0.BTMX, 0xFFFF)
                Or (\_SB.PCI0.LPCB.EC0.NGBT, Local7, \_SB.PCI0.LPCB.EC0.NGBT)
                Release (\_SB.PCI0.LPCB.EC0.BTMX)
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    Store (Arg0, ^^BSEL)
                    While (One)
                    {
                        Store (Arg0, _T_0)
                        If (LEqual (_T_0, Zero))
                        {
                            Store (B1B2 (^^FC00, ^^FC01), Local0)

                            Store (Local0, Index (DerefOf (Index (\_SB.NBTI, Arg0)), One))
                            Store (Local0, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x02))
                            Store (B1B2 (^^DV00, ^^DV01), Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x04))
                        }
                        ElseIf (LEqual (_T_0, One))
                        {
                            Store (B1B2 (^^FC10, ^^FC11), Local0)
                            Store (Local0, Index (DerefOf (Index (\_SB.NBTI, Arg0)), One))
                            Store (Local0, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x02))
                            Store (B1B2 (^^DV10, ^^DV11), Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x04))    
                        }

                        Break
                    }

                    Multiply (Local0, \_SB.PCI0.LPCB.EC0.NLB1, Local1)
                    Divide (Add (Local1, 0x63), 0x64, Local3, Local2)
                    Store (Local2, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x05))
                    Store (\_SB.PCI0.LPCB.EC0.NLB1, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x05))
                    Store (\_SB.PCI0.LPCB.EC0.NLB2, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x06))
                    While (One)
                    {
                        Store (Arg0, _T_1)
                        If (LEqual (_T_1, Zero))
                        {
                            Store (B1B2 (^^SN00, ^^SN01), Local0)
                            Store (B1B2 (^^MD00, ^^MD01), Local1)
                        }
                        ElseIf (LEqual (_T_1, One))
                        {
                            Store (B1B2 (^^SN10, ^^SN11), Local0)
                            Store (B1B2 (^^MD10, ^^MD11), Local1)
                        }

                        Break
                    }
                }

                Store (\_SB.PCI0.LPCB.EC0.GBSS (Local0, Local1), Local2)
                Store (Local2, Index (DerefOf (Index (\_SB.NBTI, Arg0)), 0x0A))
                Acquire (\_SB.PCI0.LPCB.EC0.BTMX, 0xFFFF)
                And (\_SB.PCI0.LPCB.EC0.NGBF, Not (Local7), \_SB.PCI0.LPCB.EC0.NGBF)
                Release (\_SB.PCI0.LPCB.EC0.BTMX)
                Return (Zero)
        }
        
        Method (BTST, 2, Serialized)
        {
                Store (B1B2 (^^PR00, ^^PR01), Local0)
                
                If (And (Local0, 0x8000))
                {
                    If (LEqual (Local0, 0xFFFF))
                    {
                        Store (0xFFFFFFFF, Index (DerefOf (Index (\_SB.NBST, Arg0)), One))
                    }
                    Else
                    {
                        Not (Local0, Local1)
                        Increment (Local1)
                        And (Local1, 0xFFFF, Local3)
                        Store (Local3, Index (DerefOf (Index (\_SB.NBST, Arg0)), One))
                    }
                }
                Else
                {
                    Store (Local0, Index (DerefOf (Index (\_SB.NBST, Arg0)), One))
                }

                Store (B1B2 (^^RC00, ^^RC01), Index (DerefOf (Index (\_SB.NBST, Arg0)), 0x02))
                Store (B1B2 (^^PV00, ^^PV01), Index (DerefOf (Index (\_SB.NBST, Arg0)), 0x03))
                Store (^^BST0, Local2)
                Store (Local2, Index (DerefOf (Index (\_SB.NBST, Arg0)), Zero))
                If (And (Local2, 0x04))
                {
                    Store (One, \QQ70)
                }

                If (LEqual (\_SB.WMID.BRTE, Zero))////
                {
                    Store (0xFFFFFFFF, Local3)
                    Store (Local3, Index (DerefOf (Index (\_SB.NBST, Arg0)), One))
                }

                Return (Zero)
        }
            
        Method (ITLB, 0, NotSerialized)
        {
            If (\_SB.PCI0.LPCB.EC0.ECRG)
            {
                Add (B1B2 (^^FC10, ^^FC11), B1B2 (^^FC00, ^^FC01), Local1)
                Divide (Add (Local1, 0x63), 0x64, Local2, Local3)
                Multiply (Local3, ^^LB1, \_SB.PCI0.LPCB.EC0.NLB1)
                Multiply (Local3, ^^LB2, \_SB.PCI0.LPCB.EC0.NLB2)
            }
        }
            
        Method (GBTI, 1, NotSerialized)
        {
                If (\_SB.PCI0.LPCB.EC0.ECRG)
                {
                    If (And (^^BTAP, ShiftLeft (One, Arg0)))
                    {
                        Store (Arg0, ^^BSEL)
                        Store (Package (0x03)
                            {
                                Zero, 
                                0x80, 
                                Buffer (0x80) {}
                            }, Local0)
                        Store (B1B2 (^^DC00, ^^DC01), Index (DerefOf (Index (Local0, 0x02)), Zero))
                        Store (ShiftRight (B1B2 (^^DC00, ^^DC01), 0x08), Index (DerefOf (Index (Local0, 0x02)), One))
                        Store (B1B2 (^^FC00, ^^FC01), Index (DerefOf (Index (Local0, 0x02)), 0x02))
                        Store (ShiftRight (B1B2 (^^FC00, ^^FC01), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x03))
                        Store (B1B2 (^^RC00, ^^RC01), Index (DerefOf (Index (Local0, 0x02)), 0x04))
                        Store (ShiftRight (B1B2 (^^RC00, ^^RC01), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x05))
                        Store (B1B2 (^^CC00, ^^CC01), Index (DerefOf (Index (Local0, 0x02)), 0x08))
                        Store (ShiftRight (B1B2 (^^CC00, ^^CC01), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x09))
                        Store (B1B2 (^^BT00, ^^BT01), Local1)
                        Subtract (Local1, 0x0AAC, Local1)
                        Divide (Local1, 0x0A, Local2, Local3)
                        Store (Local3, Index (DerefOf (Index (Local0, 0x02)), 0x0A))
                        Store (ShiftRight (Local3, 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x0B))
                        Store (B1B2 (^^PV00, ^^PV01), Index (DerefOf (Index (Local0, 0x02)), 0x0C))
                        Store (ShiftRight (B1B2 (^^PV00, ^^PV01), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x0D))
                        Store (B1B2 (^^PR00, ^^PR01), Local1)
                        If (Local1)
                        {
                            If (And (^^BST0, One))
                            {
                                And (Local1, 0xFFFF, Local1)
                            }
                        }

                        Store (Local1, Index (DerefOf (Index (Local0, 0x02)), 0x0E))
                        Store (ShiftRight (Local1, 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x0F))
                        Store (B1B2 (^^DV00, ^^DV01), Index (DerefOf (Index (Local0, 0x02)), 0x10))
                        Store (ShiftRight (B1B2 (^^DV00, ^^DV01), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x11))
                        Store (^^BST0, Index (DerefOf (Index (Local0, 0x02)), 0x12)) 
                        Store (ShiftRight (^^BST0, 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x13))
                        Store (B1B2 (^^V010, ^^V011), Index (DerefOf (Index (Local0, 0x02)), 0x14))
                        Store (ShiftRight (B1B2 (^^V010, ^^V011), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x15))
                        Store (B1B2 (^^V020, ^^V021), Index (DerefOf (Index (Local0, 0x02)), 0x16))
                        Store (ShiftRight (B1B2 (^^V020, ^^V021), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x17))
                        Store (B1B2 (^^V030, ^^V031), Index (DerefOf (Index (Local0, 0x02)), 0x18))
                        Store (ShiftRight (B1B2 (^^V030, ^^V031), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x19))
                        Store (B1B2 (^^V040, ^^V041), Index (DerefOf (Index (Local0, 0x02)), 0x1A))
                        Store (ShiftRight (B1B2 (^^V040, ^^V041), 0x08), Index (DerefOf (Index (Local0, 0x02)), 0x1B))
                        CreateField (DerefOf (Index (Local0, 0x02)), 0xE0, 0x80, BTSN)
                        Store (\_SB.PCI0.LPCB.EC0.GBSS (B1B2 (^^SN00, ^^SN01), B1B2 (^^MD00, ^^MD01)), BTSN)
                        Store (^^RMN0(), Local1)//128            
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x0160, Multiply (SizeOf (Local1), 0x08), BMAN)
                        Store (Local1, BMAN)
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x01F0, 0x80, CTN)
                        Store (^^RCT0(), CTN)//128
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x0278, 0x38, BDN)                        
                        Store (^^RDN0(), BDN)//56
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x02B0, 0x20, BTY)
                        Store (B1B4 (^^TY00, ^^TY01, ^^TY02, ^^TY03), BTY)//32
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x02E0, 0x10, BMD)
                        Store (B1B2 (^^MD00, ^^MD01), BMD)
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x02F0, 0x10, CRG)
                        If (And (^^BST0, One))
                        {
                            Store (Zero, CRG)
                        }
                        Else
                        {
                            Store (B1B2 (^^RG00, ^^RG01), CRG)
                        }

                        CreateField (DerefOf (Index (Local0, 0x02)), 0x0300, 0x10, BCV)
                        Store (B1B2 (^^CV0A, ^^CV0B), BCV)
                        Store (B1B2 (^^PR00, ^^PR01), Local1)
                        If (Local1)
                        {
                            If (And (^^BST0, One))
                            {
                                Add (Not (Local1), One, Local1)
                                And (Local1, 0xFFFF, Local1)
                            }
                        }

                        CreateField (DerefOf (Index (Local0, 0x02)), 0x0310, 0x10, CURT)
                        Store (Local1, CURT)
                        CreateField (DerefOf (Index (Local0, 0x02)), 0x0350, 0x08, BNUM)
                        Store (One, BNUM)
                    }
                }
                Else
                {
                    Store (Package (0x02)
                        {
                            0x0D, 
                            Zero
                        }, Local0)
                }

                Return (Local0)
        }
    }
}
//EOF


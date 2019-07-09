//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PRW0D6D", 0)
{
#endif
    Scope (_SB)
    {
        Method (PPPW, 0, Serialized)
        {
            Return (Package ()
            {
                0x6D, // or 0x0D,
                0x00
            })
        }
    }
    
    External(_SB.PCI0.EH01, DeviceObj)
    If (CondRefOf (\_SB.PCI0.EH01))
    {
        Scope (_SB.PCI0.EH01)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }

    External(_SB.PCI0.EH02, DeviceObj)
    If (CondRefOf (\_SB.PCI0.EH02))
    {
        Scope (_SB.PCI0.EH02)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.XHC, DeviceObj)
    If (CondRefOf (\_SB.PCI0.XHC))
    {
        Scope (_SB.PCI0.XHC)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.XDCI, DeviceObj)
    If (CondRefOf (\_SB.PCI0.XDCI))
    {
        Scope (_SB.PCI0.XDCI)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.HDEF, DeviceObj)
    If (CondRefOf (\_SB.PCI0.HDEF))
    {
        Scope (_SB.PCI0.HDEF)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.HDAS, DeviceObj)
    If (CondRefOf (\_SB.PCI0.HDAS))
    {
        Scope (_SB.PCI0.HDAS)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.AZAL, DeviceObj)
    If (CondRefOf (\_SB.PCI0.AZAL))
    {
        Scope (_SB.PCI0.AZAL)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.GLAN, DeviceObj)
    If (CondRefOf (\_SB.PCI0.GLAN))
    {
        Scope (_SB.PCI0.GLAN)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.IGBE, DeviceObj)
    If (CondRefOf (\_SB.PCI0.IGBE))
    {
        Scope (_SB.PCI0.IGBE)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
    
    External(_SB.PCI0.CNVW, DeviceObj)
    If (CondRefOf (\_SB.PCI0.CNVW))
    {
        Scope (_SB.PCI0.CNVW)
        {
            Method (_PRW, 0, NotSerialized)
            {
                Return (\_SB.PPPW())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
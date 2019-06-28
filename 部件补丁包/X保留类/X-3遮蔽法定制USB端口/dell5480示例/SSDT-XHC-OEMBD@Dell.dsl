//Drop SSDT-2-xh_OEMBD.aml.
DefinitionBlock ("", "SSDT", 2, "INTEL", "OEMBD", 0)
{
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS06, DeviceObj)
    External (CBID, FieldUnitObj)

    Scope (\_SB.PCI0.XHC.RHUB)
    {
        Method (GPLD, 2, Serialized)
        {
            Name (PCKG, Package (0x01)
            {
                Buffer (0x10){}
            })
            CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
            REV = One
            CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
            VISI = Arg0
            CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
            GPOS = Arg1
            Return (PCKG) /* \_SB_.PCI0.XHC_.RHUB.GPLD.PCKG */
        }

        Method (TPLD, 2, Serialized)
        {
            Name (PCKG, Package (0x01)
            {
                Buffer (0x10){}
            })
            CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
            REV = One
            CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
            VISI = Arg0
            CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
            GPOS = Arg1
            CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
            SHAP = One
            CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
            WID = 0x08
            CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
            HGT = 0x03
            Return (PCKG) /* \_SB_.PCI0.XHC_.RHUB.TPLD.PCKG */
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.HS01)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (One, One))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.HS02)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (One, 0x02))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.HS03)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            If ((CBID == 0x07A6))
            {
                Return (GPLD (Zero, Zero))
            }
            Else
            {
                Return (GPLD (One, 0x03))
            }
        }
    }


    Scope (\_SB.PCI0.XHC.RHUB.HS05)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0xFF, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (Zero, 0x05))
        }
    }


    Scope (\_SB.PCI0.XHC.RHUB.HS07)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0xFF, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (Zero, 0x07))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.HS09)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x09, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (TPLD (One, 0x09))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.SS01)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (One, One))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.SS03)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (One, 0x02))
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.SS04)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            If ((CBID == 0x07A6))
            {
                Return (GPLD (Zero, Zero))
            }
            Else
            {
                Return (GPLD (One, 0x03))
            }
        }
    }

    Scope (\_SB.PCI0.XHC.RHUB.SS06)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x09, 
            0, 
            0
        })

        Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (TPLD (One, 0x09))
        }
    }
}


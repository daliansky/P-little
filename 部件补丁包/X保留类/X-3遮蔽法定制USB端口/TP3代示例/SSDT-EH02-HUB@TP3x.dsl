//
// In config ACPI, _UPC to XUPC
// Find:     5F 55 50 43
// Replace:  58 55 50 43
//
DefinitionBlock ("", "SSDT", 2, "hack", "EH02-HUB", 0)
{
    External(_SB.PCI0.EH02.URTH.URMH, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0xFF, 
            0, 
            0
        })
    }
    //The above cannot be deleted 
    
    External(_SB.PCI0.EH02.URTH.URMH.PRT8, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRT8)
    {
        Name (_UPC, Package ()
        {
            0, 
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH02.URTH.URMH.PRT9, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRT9)
    {
        Name (_UPC, Package ()
        {
            0xFF,
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH02.URTH.URMH.PRTA, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRTA)
    {
        Name (_UPC, Package ()
        {
            0, 
            0,
            0, 
            0
        })
    }

    External(_SB.PCI0.EH02.URTH.URMH.PRTB, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRTB)
    {
        Name (_UPC, Package ()
        {
            0xFF,
            0,
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH02.URTH.URMH.PRTC, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRTC)
    {
        Name (_UPC, Package ()
        {
            0, 
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH02.URTH.URMH.PRTD, DeviceObj)
    Scope (_SB.PCI0.EH02.URTH.URMH.PRTD)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0, 
            0, 
            0
        })
    }
}
//EOF
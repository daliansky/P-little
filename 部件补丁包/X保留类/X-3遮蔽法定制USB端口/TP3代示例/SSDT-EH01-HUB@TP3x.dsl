//
// In config ACPI, _UPC to XUPC
// Find:     5F 55 50 43
// Replace:  58 55 50 43
//
DefinitionBlock ("", "SSDT", 2, "hack", "EH01-HUB", 0)
{
    External(_SB.PCI0.EH01.URTH.URMH, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH)
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
    
    External(_SB.PCI0.EH01.URTH.URMH.PRT0, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT0)
    {
        Name (_UPC, Package ()
        {
            0, 
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH01.URTH.URMH.PRT1, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT1)
    {
        Name (_UPC, Package ()
        {
            0, 
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH01.URTH.URMH.PRT2, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT2)
    {
        Name (_UPC, Package ()
        {
            0, 
            0, 
            0, 
            0
        })
    }

    External(_SB.PCI0.EH01.URTH.URMH.PRT3, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT3)
    {
        Name (_UPC, Package ()
        {
            0,
            0,
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH01.URTH.URMH.PRT4, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT4)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.EH01.URTH.URMH.PRT5, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT5)
    {
        Name (_UPC, Package ()
        {
            0,
            0,
            0, 
            0
        })
    }

    External(_SB.PCI0.EH01.URTH.URMH.PRT6, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT6)
    {
        Name (_UPC, Package ()
        {
            0,
            0, 
            0, 
            0
        })
    }

    External(_SB.PCI0.EH01.URTH.URMH.PRT7, DeviceObj)
    Scope (_SB.PCI0.EH01.URTH.URMH.PRT7)
    {
        Name (_UPC, Package ()
        {
            0,
            0, 
            0, 
            0
        })
    }
}
//EOF
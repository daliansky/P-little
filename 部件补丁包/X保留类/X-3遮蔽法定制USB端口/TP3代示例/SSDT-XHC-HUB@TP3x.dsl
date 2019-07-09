//
// In config ACPI, _UPC to XUPC
// Find:     5F 55 50 43
// Replace:  58 55 50 43
//
DefinitionBlock ("", "SSDT", 2, "hack", "XHC-HUB", 0)
{
    External(_SB.PCI0.XHC.URTH.HSP0, DeviceObj)
    Scope (_SB.PCI0.XHC.URTH.HSP0)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })
    }

    External(_SB.PCI0.XHC.URTH.HSP1, DeviceObj)
    Scope (_SB.PCI0.XHC.URTH.HSP1)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })
    }
    
    External(_SB.PCI0.XHC.URTH.SSP0, DeviceObj)
    Scope (_SB.PCI0.XHC.URTH.SSP0)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })
    }

    External(_SB.PCI0.XHC.URTH.SSP1, DeviceObj)
    Scope (_SB.PCI0.XHC.URTH.SSP1)
    {
        Name (_UPC, Package ()
        {
            0xFF, 
            0x03, 
            0, 
            0
        })
    }
}
//EOF
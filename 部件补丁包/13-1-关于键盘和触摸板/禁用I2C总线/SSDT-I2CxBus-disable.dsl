//
// In config ACPI, I2C0:_STA to XSTA
// Find:     5F 53 54 41
// Replace:  58 53 54 41
// TgtBridge:49 32 43 30
//
//
// In config ACPI, I2C1:_STA to XSTA
// Find:     5F 53 54 41
// Replace:  58 53 54 41
// TgtBridge:49 32 43 31
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "I2CxNONE", 0x00001000)
{
#endif
    External(_SB_.PCI0.I2C0, DeviceObj)
    External(_SB_.PCI0.I2C1, DeviceObj)
    External(_SB.PCI0.I2C0.XSTA, MethodObj)
    External(_SB.PCI0.I2C1.XSTA, MethodObj)
    
    Scope (_SB.PCI0.I2C0)
    {    
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.PCI0.I2C0.XSTA())
            }
        }
    }
    
    Scope (_SB.PCI0.I2C1)
    {    
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.XSTA())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
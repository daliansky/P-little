//Please change the path
// In config ACPI, _SB.PCI0.LPCB.EC0.BAT1:_STA to XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:42415431
DefinitionBlock("", "SSDT", 2, "hack", "NOBAT1", 0)
{
    //path:_SB.PCI0.LPCB.EC0.BAT1
    External(_SB.PCI0.LPCB.EC0.BAT1, DeviceObj)
    External(_SB.PCI0.LPCB.EC0.BAT1.XSTA, MethodObj)
    Scope (\_SB.PCI0.LPCB.EC0.BAT1)
    {
        Method(_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.PCI0.LPCB.EC0.BAT1.XSTA())
            }
        }
    }
}
//EOF
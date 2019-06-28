// In config ACPI, _Q66 to XQ66
// Find:     5F 51 36 36
// Replace:  5F 51 36 36
// TgtBridge:no
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "TEST", 0)
{
#endif
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.EC.XQ66, MethodObj)
    External (RMDT.P1, MethodObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {    
        Method (_Q66, 0, NotSerialized)
        {
            \RMDT.P1("AAA")
            \_SB.PCI0.LPCB.EC.XQ66()
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
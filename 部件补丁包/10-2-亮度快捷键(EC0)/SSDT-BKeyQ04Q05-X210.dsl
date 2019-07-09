// BrightKey
// In config ACPI, _Q04 renamed XQ04
// Find:     5F 51 30 34
// Replace:  58 51 30 34

// In config ACPI, _Q05 renamed XQ05
// Find:     5F 51 30 35
// Replace:  58 51 30 35

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        //path:_SB.PCI0.LPCB.EC0._Q04
        Method (_Q04, 0, NotSerialized)//up
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    
        //path:_SB.PCI0.LPCB.EC0._Q05
        Method (_Q05, 0, NotSerialized)//down
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

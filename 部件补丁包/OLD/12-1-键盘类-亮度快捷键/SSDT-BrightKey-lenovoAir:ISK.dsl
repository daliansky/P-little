// BrightKey
// In config ACPI, KBD0 renamed PS2K
// Find:     4B 42 44 30
// Replace:  50 53 32 4B
//
// In config ACPI, _Q1C renamed XQ1C
// Find:     5F 51 31 43
// Replace:  58 51 31 43

// In config ACPI, _Q1D renamed XQ1D
// Find:     5F 51 31 44
// Replace:  58 51 31 44

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        //path:_SB.PCI0.LPCB.EC._Q1C
        Method (_Q1C, 0, NotSerialized)
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    
        //path:_SB.PCI0.LPCB.EC._Q1D
        Method (_Q1D, 0, NotSerialized)
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

// BrightKey for thinkpad
// In config ACPI, KBD renamed PS2K
// Find:     4B 42 43 5F
// Replace:  50 53 32 4B
//
// In config ACPI, _Q14 renamed XQ14
// Find:     5F 51 31 34
// Replace:  58 51 31 34

// In config ACPI, _Q15 renamed XQ15
// Find:     5F 51 31 35
// Replace:  58 51 31 35

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC)
    {
        //path:_SB.PCI0.LPCB.EC._Q14
        Method (_Q14, 0, NotSerialized)
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    
        //path:_SB.PCI0.LPCB.EC._Q15
        Method (_Q15, 0, NotSerialized)
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

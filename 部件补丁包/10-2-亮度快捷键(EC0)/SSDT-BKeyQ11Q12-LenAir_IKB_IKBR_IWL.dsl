// BrightKey
// In config ACPI, _Q11 renamed XQ11
// Find:     5F 51 31 31
// Replace:  58 51 31 31

// In config ACPI, _Q12 renamed XQ12
// Find:     5F 51 31 32
// Replace:  58 51 31 32

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        //path:_SB.PCI0.LPCB.EC0._Q11
        Method (_Q11, 0, NotSerialized)//down
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    
        //path:_SB.PCI0.LPCB.EC0._Q12
        Method (_Q12, 0, NotSerialized)//up
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

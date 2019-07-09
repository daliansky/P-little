// In config ACPI, _Q64 renamed XQ64
// Find:     5F513634
// Replace:  58513634

// In config ACPI, _Q65 renamed XQ65
// Find:     5F513635
// Replace:  58513635
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    
    Scope (_SB.PCI0.LPCB.EC0)
    {
        //path:_SB.PCI0.LPCB.EC0._Q64
        Method (_Q64, 0, NotSerialized)//down
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
        }
        
        //path:_SB.PCI0.LPCB.EC0._Q65
        Method (_Q65, 0, NotSerialized)//up
        {
            Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

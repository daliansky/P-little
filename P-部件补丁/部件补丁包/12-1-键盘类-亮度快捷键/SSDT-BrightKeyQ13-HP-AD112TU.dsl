// BrightKey for thinkpad
// In config ACPI, KBD renamed PS2K
// Find:     4B 42 43 5F
// Replace:  50 53 32 4B
// or
// In config ACPI, KBC0 renamed PS2K
// Find:     4B 42 43 30
// Replace:  50 53 32 4B
//
// In config ACPI, _Q13 renamed XQ13
// Find:     5F 51 31 33
// Replace:  58 51 31 33

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.IGPU, DeviceObj)
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)    
    External(_SB.PCI0.IGPU.DD1F, DeviceObj)
    External(HKNO, FieldUnitObj)
    
    //path:_SB.PCI0.LPCB.EC._Q13
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q13, 0, NotSerialized)
        {
            Name (_T_0, Zero)
            While (One)
            {
                Store (HKNO, _T_0)
                If (LEqual (_T_0, 0x04))
                {
                    Notify (\_SB.PCI0.IGPU, 0x80)
                }
                ElseIf (LEqual (_T_0, 0x07))
                {
                    Notify(\_SB.PCI0.IGPU.DD1F, 0x87)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
                }
                ElseIf (LEqual (_T_0, 0x08))
                {
                    Notify(\_SB.PCI0.IGPU.DD1F, 0x86)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
                }
                Break
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

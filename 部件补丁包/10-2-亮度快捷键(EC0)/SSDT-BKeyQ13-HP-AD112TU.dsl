// BrightKey
// In config ACPI, _Q13 renamed XQ13
// Find:     5F 51 31 33
// Replace:  58 51 31 33

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)    
    External(HKNO, FieldUnitObj)
    
    //path:_SB.PCI0.LPCB.EC0._Q13
    External(_SB.PCI0.LPCB.EC0, DeviceObj)
    Scope (_SB.PCI0.LPCB.EC0)
    {
        Method (_Q13, 0, NotSerialized)
        {
            Name (_T_0, Zero)
            While (One)
            {
                Store (HKNO, _T_0)
                If (LEqual (_T_0, 0x07))
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x10)
                }
                ElseIf (LEqual (_T_0, 0x08))
                {
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify(\_SB.PCI0.LPCB.PS2K, 0x20)
                }
                Else{}
                Break
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

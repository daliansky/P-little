// BrightKey for dell
// In config ACPI, SMEE to XMEE
// Find:     53 4D 45 45 01
// Replace:  58 4D 45 45 01
// TgtBridge:no
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    External(GENS, MethodObj)
    
    Method (SMEE, 1, NotSerialized)
    {
        Local0 = Arg0
        Local0 = GENS (0x11, Zero, Zero)
        If ((Local0 & 0x04))
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x10)
        }

        If ((Local0 & 0x02))
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x20)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF


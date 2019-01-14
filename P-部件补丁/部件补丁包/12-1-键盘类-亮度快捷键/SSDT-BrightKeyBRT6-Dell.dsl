// BrightKey for dell
// In config ACPI, BRT6 renamed XRT6
// Find:     42525436 02
// Replace:  58525436 02
// TgtBridge:no
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "BrightFN", 0)
{
#endif
    External(_SB.PCI0.IGPU, DeviceObj)
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.IGPU)
    {
        Method (BRT6, 2, NotSerialized)
        {
            If (LEqual (Arg0, One))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x10)
            }

            If (And (Arg0, 0x02))
            {
                Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                Notify (\_SB.PCI0.LPCB.PS2K, 0x20)               
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF


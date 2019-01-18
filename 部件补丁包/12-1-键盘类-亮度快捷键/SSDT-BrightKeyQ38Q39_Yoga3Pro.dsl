// In config ACPI, _Q38 renamed XQ38
// Find:     5F513338
// Replace:  58513338

// In config ACPI, _Q39 renamed XQ39
// Find:     5F513339
// Replace:  58513339
//

DefinitionBlock ("", "SSDT", 2, "hack", "BrightFN", 0x00000000)
{
    External (_SB_.PCI0.LPCB.H_EC, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)

    Scope (_SB.PCI0.LPCB.H_EC)
    {
        Method (_Q38, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0206)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0286)
        }

        Method (_Q39, 0, NotSerialized)  // _Qxx: EC Query
        {
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0205)
            Notify (\_SB.PCI0.LPCB.PS2K, 0x0285)
        }
    }
}


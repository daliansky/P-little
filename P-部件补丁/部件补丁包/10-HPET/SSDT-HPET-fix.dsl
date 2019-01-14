//Please change the path
// In config ACPI, HPET.BUF0 renamed HPET.XUF0
// Find:     0842554630
// Replace:  0858554630
// TgtBridge:48504554
//
// In config ACPI, HPET._STA renamed HPET.XSTA
// Find:     5F535441
// Replace:  58535441
// TgtBridge:48504554
//
// In config ACPI, HPET._CRS renamed HPET.XCRS
// Find:     5F435253
// Replace:  58435253
// TgtBridge:48504554
//
// Search "PNP0103" or HPET
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "HPET-fix", 0)
{
#endif
    External(_SB.PCI0.LPCB.HPET, DeviceObj)

    Scope (_SB.PCI0.LPCB.HPET)
    {
        Name (BUF0, ResourceTemplate ()
        {
            IRQNoFlags () {0,8,11,15}
            Memory32Fixed (ReadWrite,
                0xFED00000,
                0x00000400,
                )
        })
        Name (_STA, 0x0F)
        Method (_CRS, 0, NotSerialized)
        {
            Return (BUF0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
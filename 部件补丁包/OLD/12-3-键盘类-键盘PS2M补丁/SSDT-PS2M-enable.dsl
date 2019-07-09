// In config ACPI, PS2M._STA to PS2M.XSTA(PNP0F13)
// Find:     5F535441
// Replace:  58535441
// TgtBridge:5053324D
// In config ACPI, PS2M._CID to PS2M.XCID(PNP0F13)
// Find:     5F434944
// Replace:  58434944
// TgtBridge:5053324D
//
// Search PS2M,MOU...
// Search PNP0F03,PNP0F0B,PNP0F12,PNP0F13,PNP0F0E
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PS2M", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2M, DeviceObj)
    Scope (\_SB.PCI0.LPCB.PS2M)
    {
        Method(_STA, 0, NotSerialized)
        {
            Return (0x0F)
        }
        
        Name (_CID, EisaId ("PNP0F13"))
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

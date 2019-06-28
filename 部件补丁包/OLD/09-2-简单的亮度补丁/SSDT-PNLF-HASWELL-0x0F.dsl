//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PNLF", 0)
{
#endif
    External(_SB.PCI0.IGPU, DeviceObj)
    Scope(_SB.PCI0.IGPU)
    {
        Device(PNLF)
        {
            Name(_ADR, Zero)
            Name(_HID, EisaId ("APP0002"))
            Name(_CID, "backlight")
            //Haswell/Broadwell
            Name(_UID, 15)
            Name(_STA, 0x0B)        
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
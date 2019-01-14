//Add SLPB 
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PNP0C0E", 0)
{
#endif
    //search PNP0C0E
    Scope (\_SB)
    {
        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
            Name (_STA, 0x0B)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
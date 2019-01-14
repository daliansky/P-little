//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SLEEP-X", 0)
{
#endif
    Device(XWCF)
    {
        Name(_ADR, 0)
        Name(MPWS, 0)
        Name(MODE, 1)//0:normal
                     //1:PNP0C0E
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif enable
//EOF
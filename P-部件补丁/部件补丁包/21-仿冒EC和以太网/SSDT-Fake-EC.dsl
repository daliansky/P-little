// Fake EC
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "FakeEC", 0)
{
#endif
    Device (_SB.EC)
    {
        Name (_HID, "EC000000")
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
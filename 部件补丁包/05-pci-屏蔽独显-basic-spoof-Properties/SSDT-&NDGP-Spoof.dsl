//Please change the path
//New Disables DGPU
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "Spoof", 0)
{
#endif
    //path:_SB.PCI0.PEG1.PEGP
    External(_SB.PCI0.PEG1.PEGP, DeviceObj)
    Scope (_SB.PCI0.PEG1.PEGP)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "name", Buffer() { "#display" },
                "IOName", "#display",
                "class-code", Buffer() { 0xFF, 0xFF, 0xFF, 0xFF },
            }
            Return (Local0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
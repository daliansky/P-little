// Inject plugin-type=1
//
// search Processor...
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "XCPMp000", 0)
{
#endif
    External(_SB.P000, DeviceObj)    
    Scope (_SB.P000)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "plugin-type", 1
            })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
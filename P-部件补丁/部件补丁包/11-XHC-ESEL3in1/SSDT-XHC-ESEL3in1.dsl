//
// XSEL,ESEL,XWAK in _SB.PCI0.XHC...
DefinitionBlock("", "SSDT", 2, "hack", "ESEL###", 0)
{   
    External(_SB.PCI0.XHC, DeviceObj)
    Scope (_SB.PCI0.XHC)
    {    
        Method(XSEL, 0, Serialized)
        {
            // do nothing
        }

        Method(ESEL, 0, Serialized)
        {
            // do nothing
        }

        Method(XWAK, 0, Serialized)
        {
            // do nothing
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
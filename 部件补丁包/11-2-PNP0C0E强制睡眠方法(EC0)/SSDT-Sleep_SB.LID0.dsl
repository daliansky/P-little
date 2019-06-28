//
// In config ACPI, _LID renamed XLID
// Find:     5F4C4944 00
// Replace:  584C4944 00
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "X-_LID", 0)
{
#endif
    //note:_LID 's path
    //path:_SB.LID0._LID
    External(_SB.LID0, DeviceObj)
    External(_SB.LID0.XLID, MethodObj)
    External(XWCF.MYLD, IntObj)
    Scope (_SB.LID0)
    {
        Method (_LID, 0, NotSerialized)
        {
            if(\XWCF.MYLD==0)
            {
                Return (0)
            }
            Else
            {
                Return (\_SB.LID0.XLID())
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif enable
//EOF
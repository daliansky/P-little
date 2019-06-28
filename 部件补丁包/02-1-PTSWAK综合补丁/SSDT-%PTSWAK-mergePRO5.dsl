// Overriding _PTS and _WAK
// In config ACPI, _PTS renamed ZPTS
// Find:     5F50545301
// Replace:  5A50545301
// or 
// Find:     5F50545309
// Replace:  5A50545309
//
// In config ACPI, _WAK renamed ZWAK
// Find:     5F57414B01
// Replace:  5A57414B01
//or
// Find:     5F57414B09
// Replace:  5A57414B09
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "PTSWAK", 0)
{
#endif
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)
    External(DGPU._ON, MethodObj)
    External(DGPU._OFF, MethodObj)
    External(EXT1, MethodObj)
    External(EXT2, MethodObj)
    External(EXT3, MethodObj)
    External(EXT4, MethodObj)
    External(EISC, MethodObj)
    External(_SI._SST, MethodObj)
    External(XWCF.MPWS, IntObj)
    External(XWCF.MYLD, IntObj)
    External(_SB.PCI0.XHC, DeviceObj)
    
    Scope (_SB.PCI0.XHC)
    {
        OperationRegion (PMWX, PCI_Config, 0x00, 0x0100)
        Field (PMWX, AnyAcc, NoLock, Preserve)
        {
            Offset (0x75), 
            PMXX,   1, //PMEE
        }
    }

    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        If (CondRefOf (\XWCF.MPWS))
        {
            if(\XWCF.MPWS ==1)
            {
                Arg0 = 3
            }
        }

        If (CondRefOf (\DGPU._ON))
        {
            \DGPU._ON ()
        }
        
        If (CondRefOf(EXT1))
        {
            EXT1(Arg0)
        }
        
        If (3 == Arg0)
        {
            If (CondRefOf (\EISC))
            {
                \EISC (0x81, 0x16, 0)//dell powerLED
            }
        }
        
        ZPTS(Arg0)
        
        If (CondRefOf(EXT2))
        {
            EXT2(Arg0)
        }
        
        If (5 == Arg0)
        {       
            \_SB.PCI0.XHC.PMXX = 0
        }
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        If (CondRefOf (\XWCF.MPWS))
        {
            if(\XWCF.MPWS ==1)
            {
                \XWCF.MPWS =0
                Arg0 = 3
            }
        }
        
        If (CondRefOf (\XWCF.MYLD))
        {
            \XWCF.MYLD =1
        }
        
        If (Arg0 < 1 || Arg0 > 5 )
        {
            Arg0 = 3
        }       
        
        If (CondRefOf (\DGPU._OFF))
        {
            \DGPU._OFF ()
        }
        
        If (CondRefOf(EXT3))
        {
            EXT3(Arg0)
        }
        
        If (3 == Arg0)
        {
            If (CondRefOf (\EISC))
            {
                \EISC (0x81, 0x16, 2)
            }
            If (CondRefOf(\_SI._SST)) { \_SI._SST (1) }
        }

        Local0 = ZWAK(Arg0)
        
        If (CondRefOf(EXT4))
        {
            EXT4(Arg0)
        }
        
        Return (Local0)
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

//Disables DGPU
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "NDGP", 0)
{
#endif
    External(_SB.PCI0.RP13.PXSX._ON, MethodObj)//Air13IWL
    External(_SB.PCI0.RP13.PXSX._OFF, MethodObj)//Air13IWL
    External(_SB.PCI0.RP01.PXSX._ON, MethodObj)//Air14-IKBR
    External(_SB.PCI0.RP01.PXSX._OFF, MethodObj)//Air14-IKBR
 
    Device(DGPU)
    {
        Name(_HID, "DGPU1000")
        Method(_INI)
        {
            _OFF()
        }
         
        Method(_ON)
        {
            If (CondRefOf (\_SB.PCI0.RP13.PXSX._ON)){\_SB.PCI0.RP13.PXSX._ON()}//Air13IWL
            If (CondRefOf (\_SB.PCI0.RP01.PXSX._ON)){\_SB.PCI0.RP01.PXSX._ON()}//Air14-IKBR
        }
        
        Method(_OFF)
        {
            If (CondRefOf (\_SB.PCI0.RP13.PXSX._OFF)){\_SB.PCI0.RP13.PXSX._OFF()}//Air13IWL
            If (CondRefOf (\_SB.PCI0.RP01.PXSX._OFF)){\_SB.PCI0.RP01.PXSX._OFF()}//Air14-IKBR
        }    
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
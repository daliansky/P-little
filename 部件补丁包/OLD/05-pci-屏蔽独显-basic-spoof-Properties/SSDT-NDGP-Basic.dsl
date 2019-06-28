//Disables DGPU
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "NDGP", 0)
{
#endif
    External(_SB.PCI0.PEG.VID._PS0, MethodObj)
    External(_SB.PCI0.PEG.VID._PS3, MethodObj)
    External(_SB.PCI0.PEG.VID.XDSM, MethodObj)
    //
    External(_SB.PCI0.RP09.PXSX._PS0, MethodObj)
    External(_SB.PCI0.RP09.PXSX._PS3, MethodObj)
    External(_SB.PCI0.RP09.PXSX.XDSM, MethodObj)
    //
    External(_SB.PCI0.RP01.PEGP._PS0, MethodObj)
    External(_SB.PCI0.RP01.PEGP._PS3, MethodObj) 
    External(_SB.PCI0.RP01.PEGP.XDSM, MethodObj) 
    //
    External(_SB.PCI0.PEG2.PEGP._ON, MethodObj)
    External(_SB.PCI0.PEG2.PEGP._OFF, MethodObj)
    
    External(_SB.PCI0.PEG0.PEGP._ON, MethodObj)
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)
    //
    External(_SB.PCI0.PEG0.PG00._ON, MethodObj)
    External(_SB.PCI0.PEG0.PG00._OFF, MethodObj)
    //
    External(_SB.PCI0.PEGP.DGFX._ON, MethodObj)
    External(_SB.PCI0.PEGP.DGFX._OFF, MethodObj)
    //
    External(_SB.PCI0.RP05.PXSX._ON, MethodObj)
    External(_SB.PCI0.RP05.PXSX._OFF, MethodObj)
    //
    External(_SB.PCI0.RP09.PEGP._ON, MethodObj)
    External(_SB.PCI0.RP09.PEGP._OFF, MethodObj)
    //
    External(_SB.PCI0.RP01.PEGP._ON, MethodObj)
    External(_SB.PCI0.RP01.PEGP._OFF, MethodObj)
    //
    External(_SB.PCI0.RP13.PXSX._PS0, MethodObj)//Air13IWL
    External(_SB.PCI0.RP13.PXSX._PS3, MethodObj)//Air13IWL
    External(_SB.PCI0.RP13.PXSX.XDSM, MethodObj)//Air13IWL
    
    Device(DGPU)
    {
        Name(_HID, "DGPU1000")
        Method(_INI)
        {
            _OFF()
        }
         
        Method(_ON)
        {
            If (CondRefOf (\_SB.PCI0.PEG_.VID_._PS0)){\_SB.PCI0.PEG_.VID_._PS0()}//TP:T430x
            If (CondRefOf (\_SB.PCI0.RP09.PXSX._PS0)){\_SB.PCI0.RP09.PXSX._PS0()}
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._PS0)){\_SB.PCI0.RP01.PEGP._PS0()}//TP:T470,T470S
            ///
            If (CondRefOf (\_SB.PCI0.PEG0.PEGP._ON)){\_SB.PCI0.PEG0.PEGP._ON()}
            If (CondRefOf (\_SB.PCI0.PEG2.PEGP._ON)){\_SB.PCI0.PEG2.PEGP._ON()}//TP:T470P
            If (CondRefOf (\_SB.PCI0.PEGP.DGFX._ON)){\_SB.PCI0.PEGP.DGFX._ON()}
            If (CondRefOf (\_SB.PCI0.RP05.PXSX._ON)){\_SB.PCI0.RP05.PXSX._ON()}
            If (CondRefOf (\_SB.PCI0.RP09.PEGP._ON)){\_SB.PCI0.RP09.PEGP._ON()}
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._ON)){\_SB.PCI0.RP01.PEGP._ON()}//TP:E480,R480
            If (CondRefOf (\_SB.PCI0.PEG0.PG00._ON)){\_SB.PCI0.PEG0.PG00._ON()}//TP:P51
            //
            If (CondRefOf (\_SB.PCI0.RP13.PXSX._PS0)){\_SB.PCI0.RP13.PXSX._PS0()}//Air13IWL
        }
        
        Method(_OFF)
        {
            If (CondRefOf (\_SB.PCI0.PEG.VID._PS3))     //TP:T430x
            {
                \_SB.PCI0.PEG.VID.XDSM (Buffer ()
                {                    /* 0000 */ 0xF8, 0xD8, 0x86, 0xA4, 0xDA, 0x0B, 0x1B, 0x47,                    /* 0008 */ 0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0
                }, 0x0100, 0x1A,Buffer ()
                { 0x01, 0x00, 0x00, 0x03 })
                \_SB.PCI0.PEG.VID._PS3()
            }
            If (CondRefOf (\_SB.PCI0.RP09.PXSX._PS3))
            {
                \_SB.PCI0.RP09.PXSX.XDSM (Buffer ()
                {                    /* 0000 */ 0xF8, 0xD8, 0x86, 0xA4, 0xDA, 0x0B, 0x1B, 0x47,                    /* 0008 */ 0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0
                }, 0x0100, 0x1A,Buffer ()
                { 0x01, 0x00, 0x00, 0x03 })
                \_SB.PCI0.RP09.PXSX._PS3()
            }
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._PS3))    //TP:T470,T470S
            {
                \_SB.PCI0.RP01.PEGP.XDSM (Buffer ()
                {                    /* 0000 */ 0xF8, 0xD8, 0x86, 0xA4, 0xDA, 0x0B, 0x1B, 0x47,                    /* 0008 */ 0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0
                }, 0x0100, 0x1A,Buffer ()
                { 0x01, 0x00, 0x00, 0x03 })
                \_SB.PCI0.RP01.PEGP._PS3()
            }
            //
            If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF)){\_SB.PCI0.PEG0.PEGP._OFF()}
            If (CondRefOf (\_SB.PCI0.PEG2.PEGP._OFF)){\_SB.PCI0.PEG2.PEGP._OFF()}//TP:T470P
            If (CondRefOf (\_SB.PCI0.PEGP.DGFX._OFF)){\_SB.PCI0.PEGP.DGFX._OFF()}
            If (CondRefOf (\_SB.PCI0.RP05.PXSX._OFF)){\_SB.PCI0.RP05.PXSX._OFF()}
            If (CondRefOf (\_SB.PCI0.RP09.PEGP._OFF)){\_SB.PCI0.RP09.PEGP._OFF()}
            If (CondRefOf (\_SB.PCI0.RP01.PEGP._OFF)){\_SB.PCI0.RP01.PEGP._OFF()}//TP:E480,R480
            If (CondRefOf (\_SB.PCI0.PEG0.PG00._OFF)){\_SB.PCI0.PEG0.PG00._OFF()}//TP:P51
            //
            If (CondRefOf (\_SB.PCI0.RP13.PXSX._PS3))    //Air13IWL
            {
                \_SB.PCI0.RP13.PXSX.XDSM (Buffer ()
                {                    /* 0000 */ 0xF8, 0xD8, 0x86, 0xA4, 0xDA, 0x0B, 0x1B, 0x47,                    /* 0008 */ 0xA7, 0x2B, 0x60, 0x42, 0xA6, 0xB5, 0xBE, 0xE0
                }, 0x0100, 0x1A,Buffer ()
                { 0x01, 0x00, 0x00, 0x03 })
                \_SB.PCI0.RP13.PXSX._PS3()
            }
        }    
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
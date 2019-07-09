// In config ACPI, FFFFFFFF:_CRS to XCRS
// Find:     5F 43 52 53
// Replace:  58 43 52 53
// TgtBridge:FF FF FF FF
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "CRSpatch", 0)
{
#endif
    External(_SB.PCI0.GPI0._STA, MethodObj)
    External(_SB.PCI0.I2CX.DEV0, DeviceObj)
    
    Scope   (_SB.PCI0.I2CX.DEV0)
    {
        Method (_CRS, 0, NotSerialized)
        {
            Name (XBFB, ResourceTemplate ()
            {
                //0xFFF1 = I2cSerialBusV2
                I2cSerialBusV2 (0xFFF1, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2CX",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            
            Name (XBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake,,,)
                {
                    0xFFF2//Interrupt
                }
            })
            
            Name (XBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        // 0xFFF3 = GPI0's Pin
                        0xFFF3
                    }
            })

            Local0 = \_SB.PCI0.GPI0._STA()
            If (Local0!=0) 
            {
                Return (ConcatenateResTemplate (XBFB, XBFG))
            }
            Else
            {
                Return (ConcatenateResTemplate (XBFB, XBFI))
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
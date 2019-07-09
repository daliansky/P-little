// Fake ambient light sensor device
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "ALS0", 0)
{
#endif
    // Search "ACPI0008"....   
    Scope (_SB)
    {
        Device(ALS0)
        {
            Name(_HID, "ACPI0008")
            Name(_CID, "smc-als")
            Name(_ALI, 300)
            Name(_ALR, Package()
            {
                //Package() { 70, 0 },
                //Package() { 73, 10 },
                //Package() { 85, 80 },
                Package() { 100, 300 },
                //Package() { 150, 1000 },
            })
            
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
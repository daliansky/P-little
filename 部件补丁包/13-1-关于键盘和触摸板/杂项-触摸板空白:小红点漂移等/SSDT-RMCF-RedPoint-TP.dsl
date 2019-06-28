// REDpoint
// In config ACPI, KBD renamed PS2K
// Find:     4B42435F
// Replace:  5053324B
//
// Search "PNP0303"...
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "RM-RedP", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Name (RMCF,Package() 
        {
            "Synaptics TouchPad", Package()
            {
                "BogusDeltaThreshX", 400,
                "BogusDeltaThreshY", 350,
                "DivisorX",1,
                "DivisorY",1,
                "MomentumScrollThreshY", 7,
                "MultiFingerHorizontalDivisor", 1,
                "MultiFingerVerticalDivisor", 1,
                "Resolution", 2950,
                "ScrollDeltaThreshX", 10,
                "ScrollDeltaThreshY", 10,
                "ScrollResolution", 2950,
            }, 
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

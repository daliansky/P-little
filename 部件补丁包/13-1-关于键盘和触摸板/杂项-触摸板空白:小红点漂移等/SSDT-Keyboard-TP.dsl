//
// In config ACPI, KBD renamed PS2K
// Find:     4B42435F
// Replace:  5053324B
//
// Search "PNP0303"...
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "Keyboard", 0)
{
#endif
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "RM,oem-id", 
                "LENOVO",
                "RM,oem-table-id", 
                "T460",//"T460","T560","Thinkpad_ClickPad","Thinkpad_Trackpad".ect
            }
            Return (Local0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

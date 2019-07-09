// Fix certain unsupported SATA devices
// In config ACPI, SAT1 rename SATA or SAT2 rename SATA
// Find:     53415431 
//   or:     53415432
// Replace:  53415441
// TgtBridge:no
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "SATA", 0)
{
#endif
    External(_SB.PCI0.SATA, DeviceObj)    
    Scope(_SB.PCI0.SATA)
    {
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                //come from RM patch
                "device-id", Buffer() { 0x02, 0xa1, 0, 0 },
                "compatible", Buffer() { "pci8086,a102" },
            } 
            Return (Local0)
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
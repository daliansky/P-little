// Fix certain unsupported SATA devices
// In config ACPI, SAT1 rename SATA or SAT0 rename SATA
// Find:     53415431 
//   or:     53415430
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
        OperationRegion(XWSA, PCI_Config, 2, 2)
        Field(XWSA, AnyAcc, NoLock, Preserve)
        {
            SDID,16
        }
        Name(SDDL, Package()
        {
            // 8086:1e03, remap to supported 8086:2681
            0x1e03, 0,///430s
            Package()
            {
                "device-id", Buffer() { 0x81, 0x26, 0, 0 },
                "compatible", Buffer() { "pci8086,2618" }, 
            },
            // 8086:282a is RAID mode, remap to supported 8086:2829
            // 8086:2822 is RAID mode on others
            0x282a, 0x2822, 0,
            Package()
            {
                "device-id", Buffer() { 0x29, 0x28, 0, 0 },
                "compatible", Buffer() { "pci8086,2829" },
            },
            // Skylake 8086:a103 not supported currently, remap to supported 8086:a102
            // same with Skylake 8086:9d03
            0xa103, 0x9d03,
            // same with 200-series 8086:a282
            0xa282, 0,
            Package()
            {
                "device-id", Buffer() { 0x02, 0xa1, 0, 0 },
                "compatible", Buffer() { "pci8086,a102" },
            }
        })
        
        Method (_DSM, 4, Serialized)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            // search for matching device-id in device-id list, SDDL
            Local0 = Match(SDDL, MEQ, ^SDID, MTR, 0, 0)
            If (Ones != Local0)
            {
                // start search for zero-terminator (prefix to injection package)
                Local0 = Match(SDDL, MEQ, 0, MTR, 0, Local0+1)
                Return (DerefOf(SDDL[Local0+1]))
            }
            // if no match, assume it is supported natively... no inject
            Return (Package() { })
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
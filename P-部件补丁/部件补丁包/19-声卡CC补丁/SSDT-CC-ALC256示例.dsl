// In config ACPI, HDAS renamed HDEF for 7th
// Find:     48444153
// Replace:  48444546

// In config ACPI, BOD3 renamed HDAU for 4th/5th
// Find:     424F4433
// Replace:  48444155

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "CC-ALC", 0)
{
#endif
    External(_SB.PCI0.HDEF, DeviceObj)
    Scope (_SB.PCI0.HDEF)
    {
        Name (RMCF,Package()       
        {
        //start
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x19 SET_PIN_WIDGET_CONTROL 0x25
                    "Command", Buffer() { 0x01, 0x97, 0x07, 0x25 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x21 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x02, 0x17, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x20 SET_COEF_INDEX 0x36
                    "Command", Buffer() { 0x02, 0x05, 0x00, 0x36 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x20 SET_PROC_COEF 0x1737
                    "Command", Buffer() { 0x02, 0x04, 0x17, 0x37 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            "Perform Reset", ">n",
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
            "Send Delay", 10,
            "Sleep Nodes", ">n",
        },
        //end       
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
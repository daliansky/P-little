//
DefinitionBlock ("", "SSDT", 2, "hack", "NoPrtSc", 0)
{
    External(_SB.PCI0.LPCB.PS2K, DeviceObj)
    Scope (_SB.PCI0.LPCB.PS2K)
    {
        Name (RMCF,Package() 
        {
            "Keyboard", Package()
            {
                "Custom PS2 Map", Package()
                {
                    Package(){},
                    "e037=0",
                },
            },
        })
    }
}
//EOF
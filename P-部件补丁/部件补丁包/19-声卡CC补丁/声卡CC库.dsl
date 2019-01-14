//IDAT
DefinitionBlock ("", "SSDT", 2, "hack", "_DATA1", 0)
{
    Name(IDAT, Package()
    {
        //JackReset
        "CodecCommander", Package()
        {
            "Perform Reset", ">n",
            "Perform Reset on External Wake", ">n",
        },       

        //ALC256,ALC3246
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
        
        //ALC269
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x15 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x01, 0x57, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
        },       
        
        //ALC280
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x15 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x01, 0x57, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x1a SET_PIN_WIDGET_CONTROL 0x24
                    // Node 0x1a - Pin Control (In Enable / VRefEn)
                    "Command", Buffer() { 0x01, 0xa7, 0x07, 0x24 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            //"Perform Reset", ">n", // enable if using AppleALC
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
        },      

        //ALC283
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
            },
            "Perform Reset", ">n",
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
            "Send Delay", 10,
            "Sleep Nodes", ">n",
        },                 

        //ALC298
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x18 SET_PIN_WIDGET_CONTROL 0x22
                    "Command", Buffer() { 0x01, 0x87, 0x07, 0x22 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x1a SET_PIN_WIDGET_CONTROL 0x23
                    "Command", Buffer() { 0x01, 0xa7, 0x07, 0x23 },
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
            },
            "Perform Reset", ">n",
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
            "Send Delay", 10,
            "Sleep Nodes", ">n",
        },
    
        //ALC298A
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x01 SET_CODEC_RESET 0x00
                    "Command", Buffer() { 0x00, 0x17, 0xff, 0x00 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x01 SET_CODEC_RESET 0x00
                    "Command", Buffer() { 0x00, 0x17, 0xff, 0x00 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x1 SET_POWER_STATE 0x03
                    "Command", Buffer() { 0x00, 0x17, 0x05, 0x03 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x21 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x02, 0x17, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            //"Perform Reset", ">n", // enable if using AppleALC
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
        },

        //ALC292
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x01 SET_CODEC_RESET 0x00
                    "Command", Buffer() { 0x01, 0xA7, 0x07, 0x24 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x1 SET_POWER_STATE 0x03
                    "Command", Buffer() { 0x01, 0x57, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            "Perform Reset", ">y", 
            "Send Delay", 0x0A, 
            "Sleep Nodes", ">n"
        },
        
        //ALC1220
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x19 SET_PIN_WIDGET_CONTROL 0x24
                    "Command", Buffer() { 0x01, 0x97, 0x07, 0x24 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x1B SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x01, 0xB7, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            "Perform Reset", ">y",
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
            "Send Delay", 10,
            "Sleep Nodes", ">n",
        }, 
       
        //ALC668
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                // correcting headphones (this is in the Info.plist too)
                Package()
                {
                    // 0x15 SET_UNSOLICITED_ENABLE 0x83
                    "Command", Buffer() { 0x01, 0x57, 0x08, 0x83 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // Node 0x1b - Pin Control (In Enable)
                    "Command", Buffer() { 0x01, 0xb7, 0x07, 0x20 },
                    "On Init", ">n",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                // correcting audio after Windows (not in current Info.plist)
                Package()
                {
                    // 0x20 SET_COEF_INDEX 0x07
                    "Command", Buffer() { 0x02, 0x05, 0x00, 0x07 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
                Package()
                {
                    // 0x20 SET_PROC_COEF 0x0F80
                    "Command", Buffer() { 0x02, 0x04, 0x0f, 0x80 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">n",
                },
            },
            //"Perform Reset", ">n", // enable if using AppleALC
            //"Perform Reset on External Wake", ">n", // enable if using AppleALC
        },
        
        //CX20752
        "CodecCommander", Package()
        {
            "Custom Commands", Package()
            {
                Package(){}, // signifies Array instead of Dictionary
                Package()
                {
                    // 0x19 SET_PIN_WIDGET_CONTROL 0x24
                    "Command", Buffer() { 0x01, 0x97, 0x07, 0x24 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
                Package()
                {
                    // 0x1a SET_PIN_WIDGET_CONTROL 0x24
                    "Command", Buffer() { 0x01, 0xa7, 0x07, 0x24 },
                    "On Init", ">y",
                    "On Sleep", ">n",
                    "On Wake", ">y",
                },
            },
            "Perform Reset", ">n",
            "Perform Reset on External Wake", ">n",
        },
        //
    })
}
//EOF

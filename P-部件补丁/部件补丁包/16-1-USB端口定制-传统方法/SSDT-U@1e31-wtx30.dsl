//430s
DefinitionBlock ("", "SSDT", 2, "hack", "USB-port", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        {
            "HUB1", Package()
            {
                "port-count", Buffer() { 6, 0, 0, 0 },
                "ports", Package()
                {
                    //"HP11", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 1, 0, 0, 0 },
                    //},
                    //"HP12", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 2, 0, 0, 0 },
                    //},
                    "HP13", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    //"HP14", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 4, 0, 0, 0 },
                    //},
                    "HP15", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    "HP16", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                    
                    //"HP17", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 7, 0, 0, 0 },
                    //},
                    //"HP18", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 8, 0, 0, 0 },
                    //},    
                    
                },
            },
                        
            "HUB2", Package()
            {
                "port-count", Buffer() { 6, 0, 0, 0 },
                "ports", Package()
                {
                    //"HP21", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 1, 0, 0, 0 },
                    //},
                    "HP22", Package()////2.0usb out
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },
                    "HP23", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                    "HP24", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },
                    "HP25", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    "HP26", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },
                },
            },
            
            "EH01", Package()
            {
                "port-count", Buffer() { 1, 0, 0, 0 },
                "ports", Package()
                {
                    "PR11", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                },
            },
            
            "EH02", Package()
            {
                "port-count", Buffer() { 1, 0, 0, 0 },
                "ports", Package()
                {
                    "PR21", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                },
            },  
            "8086_1e31", Package()
            {
                "port-count", Buffer() { 6, 0, 0, 0 },
                "ports", Package()
                {
                    
                    "HS01", Package()
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },                    
                    
                    "HS02", Package()
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },                     
                    
                    "HS03", Package()
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },                     
                    
                    "HS04", Package()
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 4, 0, 0, 0 },
                    },                    
                    /////////                   
                    "SS05", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },
                    
                    "SS06", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },                    
                    
                    //"SS07", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 7, 0, 0, 0 },
                    //},                    
                    
                    //"SS08", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 8, 0, 0, 0 },
                    //},   
                },
            },
        })
    }
}
//EOF
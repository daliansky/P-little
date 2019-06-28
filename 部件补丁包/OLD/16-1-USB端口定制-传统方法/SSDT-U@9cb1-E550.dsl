//t450s
DefinitionBlock ("", "SSDT", 2, "hack", "USB-port", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        { 
            "HUB1", Package()
            {
                "port-count", Buffer() { 1, 0, 0, 0 },
                "ports", Package()
                {
                    "HP11", Package()
                    {
                        //"UsbConnector", 0,
                        "portType", 0,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },
                    //"HP12", Package()
                    //{
                    //    //"UsbConnector", 0,
                    //    "portType", 0,
                    //    "port", Buffer() { 2, 0, 0, 0 },
                    //},   
                    
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
            
            "8086_9cb1", Package()///E550 9cb1
            {
                "port-count", Buffer() { 15, 0, 0, 0 },
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
                    
                    //"HS04", Package()
                    //{
                    //    "UsbConnector", 0,
                    //    "port", Buffer() { 4, 0, 0, 0 },
                    //},                     
                                       
                    //"HS05", Package()
                    //{
                    //    "UsbConnector", 0,
                    //    "port", Buffer() { 5, 0, 0, 0 },
                    //},
                    
                    "HS06", Package()
                    {
                        "UsbConnector", 0,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },                    
                    
                    "HS07", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },                    
                    
                    "HS08", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 8, 0, 0, 0 },
                    }, 
                    
                    //"HS09", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 9, 0, 0, 0 },
                    //},                    
                    
                    //"HS10", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 10, 0, 0, 0 },
                    //},                    
                    
                    //"HS011", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 11, 0, 0, 0 },
                    //},
                    
                    ////////  
                    "SS01", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 12, 0, 0, 0 },
                    },                 
                    "SS02", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 13, 0, 0, 0 },
                    }, 
                    "SS03", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    },                 
                    "SS04", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 15, 0, 0, 0 },
                    }, 
                },
            },
        })
    }
}
//EOF
//t450s
DefinitionBlock ("", "SSDT", 2, "hack", "USB-port", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        { 
            "8086_9cb1", Package()///T450s 9cb1
            {
                "port-count", Buffer() { 14, 0, 0, 0 },
                "ports", Package()
                { 
                    "HS01", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 1, 0, 0, 0 },
                    },                    
                    
                    "HS02", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 2, 0, 0, 0 },
                    },                     
                    
                    "HS03", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },                     
                    
                    //"HS04", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 4, 0, 0, 0 },
                    //},                     
                                       
                    //"HS05", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 5, 0, 0, 0 },
                    //},
                    
                    "HS06", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 6, 0, 0, 0 },
                    },                    
                    
                    "HS07", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 7, 0, 0, 0 },
                    },                    
                    
                    "HS08", Package()
                    {
                        "UsbConnector", 3,
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
                    //"SS04", Package()
                    //{
                    //    "UsbConnector", 3,
                    //    "port", Buffer() { 15, 0, 0, 0 },
                    //}, 
                },
            },
        })
    }
}
//EOF
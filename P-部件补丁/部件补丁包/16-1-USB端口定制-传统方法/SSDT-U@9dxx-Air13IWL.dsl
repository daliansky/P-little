///X1c4th
DefinitionBlock ("", "SSDT", 2, "hack", "USB-port", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")
        Name(RMCF, Package()
        {
            "8086_9dxx", Package()
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
                        "UsbConnector", 9,
                        "port", Buffer() { 3, 0, 0, 0 },
                    },
                                       
                    "HS05", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 5, 0, 0, 0 },
                    },                  
                                       
                    //"HS06", Package()
                    //{
                    //    "UsbConnector", 0,
                    //    "port", Buffer() { 6, 0, 0, 0 },
                    //},
                       
                    "HS10", Package()
                    {
                        "UsbConnector", 255,
                        "port", Buffer() { 10, 0, 0, 0 },
                    },
                    ///////           
                    "SS01", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 13, 0, 0, 0 },
                    },
                    "SS02", Package()
                    {
                        "UsbConnector", 3,
                        "port", Buffer() { 14, 0, 0, 0 },
                    }, 
                    "SS03", Package()
                    {
                        "UsbConnector", 9,
                        "port", Buffer() { 15, 0, 0, 0 },
                    },               
                },
            },
        })
    }
}
//EOF
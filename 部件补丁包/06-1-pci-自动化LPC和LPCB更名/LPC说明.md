一、说明：
注入LPC的ID
使用新的`WhateverGreen` + `lilu`，在config\Device\Porperties下注入ID是更好的方法，见Properties方法。使用Properties方法，忽略本补丁

二、补丁：
`SSDT-LPC-auto`	自动注入
`SSDT-LPC`		精简补丁，需自己填写注入内容

三、更名(见“基本更名.plist”)：
`LPC to LPCB`

DSDT中搜索`0x001F0000`，如果设备名称不是`LPCB`，使用`LPC to LPCB`

注意：
如果ACPI中包涵ECDT.aml文件，参见《ECDT修正方法》


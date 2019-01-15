# P-little

> hackintosh hotpatch
>
> Start Date: 1-9-2019
>
> Project maintenance: 宪武 黑果小兵

 

# P-little部件补丁更名说明：

## 一、基本更名

| 序号 | 重命名 | 说明 |
| ---- | ------ | ---- |
| 01| _DSM to XDSM | 其他补丁要求 |
|02|OSID to XSID  |   dell机器和某些机器`_OSI to XOSI`更名的前置更名要求|
|03|_OSI to XOSI  |     操作系统补丁要求|
|04|PCI.VID to PCI.IGPU#1 | TP早期机器显卡更名要求-1,查询`0x00020000`所属设备名称 |
|05|PCI.VID to PCI.IGPU#2 | TP早期机器显卡更名要求-2,查询`0x00020000`所属设备名称 |
|06|GFX0 to IGPU  | 绝大多数机器显卡更名要求,查询`0x00020000`所属设备名称 |
|07|LPC to LPCB | LPC控制器更名要求。搜`LPC`、`LPCB`、`0x001F0000`<br />1 同时出现`LPC`和`LPCB`，禁止此更名<br />2 控制器名称已经是`LPCB`的，无需此更名<br />3 控制器名称是`LPC`的，必须更名为`LPCB`，同时确认ACPI中是否包涵ECDT.aml文件。参见《ECDT修正方法》。 |
|08|SAT0 to SATA  | SATA控制器更名要求<br />6代之前机器，查询`0x001F0002`所属设备名称<br />6代及以后机器，查询`0x00170000`所属设备名称<br />Properties方法，无需此更名 |
|09|SAT1 to SATA |    同上|
|10|EHC1 to EH01 |    遮蔽法要求|
|11|EHC2 to EH02 |    遮蔽法要求|
|12|XHCI to XHC  | 遮蔽法要求，如果是`XHC1`，自行修改更名内容<br />控制器名称已经是`XHC`的，无需此更名 |
|13|B0D3 to HDAU |    4代、5代机器HDMI音频更名要求|
|14|HDAS to HDEF |    6代及以上机器声卡更名要求|
|15|IGBE to GLAN |    部分机器以太网更名要求|
|16|KBD to PS2K |     部分机器第一键盘更名要求|
|17|KBC0 to PS2K |    部分机器第一键盘更名要求|
|18|MOU to PS2M |     部分机器第二键盘更名要求|
|19|ECDV to EC(dell) | dell机器EC更名要求，查询`PNP0C09`所属设备名称 |
|20|EC0 to EC  | 部分机器EC更名要求，查询`PNP0C09`所属设备名称 |
|21|SMBU to SBUS | 多数TP机器SBUS更名要求<br />6代之前机器，查询`0x001F0003`所属设备名称<br />6代及以后机器，查询`0x001F0004`所属设备名称 |
|22|LID0 to LID  | 部分机器盖子更名要求，查询`PNP0C0D`所属设备名称 |
|23|SBTN to SLPB(dell) | 睡眠按键更名要求，查询`PNP0C0E`所属设备名称 |
|24|_PTS to ZPTS(1,N)  | 综合补丁`_PTS`更名要求，查询`_PTS`数据类型，按数据类型选择 |
|25|_PTS to ZPTS(1,S) | 综合补丁`_PTS`更名要求，查询`_WAK`数据类型，按数据类型选择 |
|26|_WAK to ZWAK(1,N) | 综合补丁`_WAK`更名要求，查询`_PTS`数据类型，按数据类型选择 |
|27|_WAK to ZWAK(1,S) | 综合补丁`_WAK`更名要求，查询`_WAK`数据类型，按数据类型选择 |
|28|XSEL to XSEZ(0,N) | XSEL补丁更名要求，搜索`XHC`下的`XSEL`，按数据类型选择 |
|29|XSEL to XSEZ(0,S) | XSEL补丁更名要求，搜索`XHC`下的`XSEL`，按数据类型选择 |
|30|ESEL to ESEZ(0,N) | ESEL补丁更名要求，搜索`XHC`下的`ESEL`，按数据类型选择 |
|31|ESEL to ESEZ(0,S) | ESEL补丁更名要求，搜索`XHC`下的`ESEL`，按数据类型选择 |
|32|XWAK to XWAZ(0,N) | XWAK补丁更名要求，搜索`XHC`下的`XWAK`，按数据类型选择 |
|33|XWAK to XWAZ(0,S) | XWAK补丁更名要求，搜索`XHC`下的`XWAK`，按数据类型选择 |
|34|KBD0 to PS2K | 部分机器第一键盘更名要求 |

​     

## 二、其他更名。

每个部件补丁内都有相关说明和需要的更名文件。

## 三、注意事项

电池补丁的更名和其他部件补丁的更名必须在基本更名之后。



说明
===
假定：I2C设备路径是`_SB.PCI0.I2C0.TPAD`

本方法：

- 1 禁止原I2C设备：`TPAD`
- 2 仿冒一个新设备：`TPXX`
- 3 `TPXX`与被禁止的I2C设备(`TPAD`)内容完全相同
- 4 对`TPXX`内容打补丁，打补丁的过程类似于DSDT补丁方法
- 5 本方法适合通过补丁驱动I2C设备的机器。



**必要条件：**

在DSDT中，`TPAD`只存在于`Device (TPAD)`内，`Device (TPAD)`以外不存在`TPAD`。

如果`Device (TPAD)`以外存在`TPAD`，需要特殊处理方法(见附1)。



**禁止无关联的I2C总线设备：**

通常，I2C设备位于I2C0或者I2C1总线下(可用`IORegistryExplorer`查看)。建议将无关联的I2C总线设备禁止。如，`TPAD`位于I2C0，我们禁止I2C1。
相关内容的更名和补丁见《禁止不存在的I2C总线设备》。


**操作过程：**

一、GPI0控制器补丁：

- 更名：`I2C-GPI0:_STA to XSTA`
- 补丁：`SSDT-I2C-GPI0`

二、禁止原I2C设备：`TPAD`

- 更名：`I2C0-TPAD:_STA to XSTA`
- 补丁：`SSDT-I2C0-TPAD-disable`

三、新建设备：`TPXX`

- 见：`SSDT-I2C0-TPADtoTPxx-Air13IWL`



(一) 新建设备方法：

- 1 创建一个TPXX设备：`Device (_SB.PCI0.I2C0.TPXX)`
- 2 将DSDT中`TPAD`下的所有内容移植到补丁文件中
- 3 修改补丁文件中所有的`TPAD`为`TPXX`
- 4 添加必要的外部引用`External...`修补所有错误

(二) `TPXX`里其他补丁

根据自己的情况进行补丁工作，参见：
https://voodooi2c.github.io/#GPIO%20Pinning/GPIO%20Pinning
https://www.tonymacx86.com/threads/voodooi2c-help-and-support.243378/

可能需要修改以下内容：

- 1 修改`_STA`内容为：`Return (0x0F)`

- 2 添加缺失的内容：

  ```ruby
    Name (SBFG, ResourceTemplate ()
    {
       GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
       "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
       )
       {   // Pin list
           0x0000
       }
    })
  ```

  

- 3 `_CRS`内容修改为:

  ```ruby
   ......
    Return (ConcatenateResTemplate (SBFB, SBFG))或者
    ......
    Return (ConcatenateResTemplate (SBFB, SBFI))或者
    ......
    Return (SBFI)
  ```

  

- 4 填写`Pin list`
    参见《查询GPI0-pin》

- 5 修改其他方面内容

**四、参考补丁样本**

```bash
SSDT-I2C-GPI0
SSDT-I2C0-TPAD-disable
SSDT-I2C0-TPADtoTPxx-Air13IWL
SSDT-I2C1-TPD1-disable
SSDT-I2C1-TPD1toTPxx-dell5480
```



**五、注意事项：**

- 1 选择正确的I2C设备驱动
- 2 选择合适的操作系统补丁
- 3 使用《config禁止I2C系统驱动补丁.plist》

**附1：**

在必要条件说明中，如果`Device (TPAD)`以外存在`TPAD`，可以采取以下两种方法：

- 方法一
  - 将`Device (TPAD)`以外的其他`TPAD`更名为`TPXX`
    对于hotpatch来说，这种方法实现较为困难

- 方法二

  - 1 将`Device (TPAD)`更名为另一个设备名称，如`Device (XXXX)`
  - 2 禁止`Device (XXXX)`
  - 3 在上述新建设备过程中，仍使用原来的名称`TPAD`

  




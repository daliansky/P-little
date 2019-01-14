// Overriding NEVT
// In config ACPI, NEVT renamed XEVT
// Find:     4E455654 00
// Replace:  58455654 00
#define LidManagement 0
#define ButtonManagement 1
//
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "hack", "NEVTFix", 0)
{
#endif
    External(ECG1, MethodObj)
    External(PWCH, MethodObj)
    External(SMIE, MethodObj)
    External(EV6, MethodObj)
    External(ECG3, MethodObj)
    //External(EV4, MethodObj)
    //External(ECG4, MethodObj)
    //External(GENS, MethodObj)
    External(_SB.SLPB, DeviceObj)
    External(XWCF.MPWS, IntObj)
    External(XWCF.MODE, IntObj)

    Method (NEVT, 0, NotSerialized)
    {
        Store (ECG1 (), Local0)

        //The following are FN+F?       
        If (And (Local0, One))
        {
             //EV6 (One, Zero)
        }
        
        If (And (Local0, 0x40))//FN+InSert
        {
            If (\XWCF.MPWS==0)
            {
                \XWCF.MPWS =1
                Notify (\_SB.SLPB, 0x80)
            }
        }

        If (And (Local0, 0x04))//LID
        {
            If (\XWCF.MODE==0)
            {
                Local3 = ECG3 ()
                OperationRegion (PDW0, SystemMemory, 0xFDAE05B8, 0x04)
                Field (PDW0, AnyAcc, NoLock, Preserve)
                {
                    TEMP,   16, 
                    Offset (0x04)
                }

                If ((Local3 == One))
                {
                    TEMP = 0x0102
                }
                Else
                {
                    TEMP = 0x0200
                }
                EV6 (0x03, Local3)
            }
            Else
            {
                If (\XWCF.MPWS==0)
                {
                    \XWCF.MPWS =1
                    Notify (\_SB.SLPB, 0x80)
                }
            }
        }
        
        If (And (Local0, 0x0100))
        {
            //EV4 (0x0100, Zero)
            //If (ECG4 ())
            //{
            //    GENS (0x1C, One, Zero)
            //}
            //Else
            //{
            //    GENS (0x1C, Zero, Zero)
            //}
        }

        If (And (Local0, 0x0200))
        {            
            //EV4 (0x0200, Zero)
        }

        If (And (Local0, 0x0400))
        {            
            //EV4 (0x0400, Zero)
        }

        If (And (Local0, 0x0800))//FN+Esc,switching FN+Fx or Fx
        {           
            //EV4 (0x0800, Zero)
        }
        
        If (And (Local0, 0x08))//Battery update
        {
            PWCH ()
        }
        
        If (And (Local0, 0x80))//FN+F11 and FN+F12
        {
            SMIE ()
        }
    } 
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF
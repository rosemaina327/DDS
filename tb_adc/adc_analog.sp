//
simulator lang=spectre

// Library name: umc65ll
// Cell name: RNHR_LL
// View name: schematic
subckt RNHR_LL_pcell_0 PLUS MINUS B
parameters segW=2u segL=10u mis_flag1=1
    R41 (n41 MINUS B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R40 (n40 n41 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R39 (n39 n40 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R38 (n38 n39 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R37 (n37 n38 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R36 (n36 n37 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R35 (n35 n36 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R34 (n34 n35 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R33 (n33 n34 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R32 (n32 n33 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R31 (n31 n32 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R30 (n30 n31 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R29 (n29 n30 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R28 (n28 n29 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R27 (n27 n28 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R26 (n26 n27 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R25 (n25 n26 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R24 (n24 n25 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R23 (n23 n24 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R22 (n22 n23 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R21 (n21 n22 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R20 (n20 n21 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R19 (n19 n20 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R18 (n18 n19 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R17 (n17 n18 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R16 (n16 n17 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R15 (n15 n16 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R14 (n14 n15 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R13 (n13 n14 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R12 (n12 n13 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R11 (n11 n12 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R10 (n10 n11 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R9 (n9 n10 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R8 (n8 n9 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R7 (n7 n8 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R6 (n6 n7 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R5 (n5 n6 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R4 (n4 n5 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R3 (n3 n4 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R2 (n2 n3 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R1 (n1 n2 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R0 (PLUS n1 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
ends RNHR_LL_pcell_0
// End of subcircuit definition.

// Library name: DDS
// Cell name: DACR2R_CELL_R
// View name: schematic
subckt DACR2R_CELL_R MINUS PLUS
    R6 (PLUS MINUS vdd!) RNHR_LL_pcell_0 m=1 segW=4u segL=20u mis_flag1=1
ends DACR2R_CELL_R
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%VBP
// View name: cmos_sch
subckt _sub0 3 11
    r4 (3 5) resistor r=0.118293
    r3 (5 7) resistor r=6.25
    r2 (7 11) resistor r=5.95833
    c1 (5 0) capacitor c=7.6113e-17
    c0 (7 0) capacitor c=7.01459e-18
ends _sub0
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%VBN
// View name: cmos_sch
subckt _sub1 7 9
    r4 (2 7) resistor r=0.0820992
    r3 (2 4) resistor r=5.75
    r2 (9 4) resistor r=1.875
    c1 (4 0) capacitor c=8.3448e-18
    c0 (7 0) capacitor c=1.0206e-16
ends _sub1
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%Z
// View name: cmos_sch
subckt _sub2 4 17 20
    r14 (1 4) resistor r=0.525726
    r13 (1 9) resistor r=0.0425
    r12 (2 4) resistor r=0.0346465
    r11 (2 15) resistor r=0.0425
    r10 (5 9) resistor r=0.0606552
    r9 (5 7) resistor r=25
    r8 (20 7) resistor r=6.11111
    r7 (11 15) resistor r=0.0595317
    r6 (11 13) resistor r=23
    r5 (17 13) resistor r=3.33333
    c4 (2 0) capacitor c=3.57579e-17
    c3 (7 0) capacitor c=8.33558e-18
    c2 (9 0) capacitor c=7.94409e-17
    c1 (13 0) capacitor c=8.00126e-18
    c0 (15 0) capacitor c=1.32789e-17
ends _sub2
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%VDD
// View name: cmos_sch
subckt _sub3 7 10 13
    r9 (1 2) resistor r=0.503188
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=23
    r6 (13 4) resistor r=3.33333
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (1 0) capacitor c=6.95407e-17
    c1 (6 0) capacitor c=1.34298e-16
    c0 (13 0) capacitor c=8.78306e-18
ends _sub3
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%VSS
// View name: cmos_sch
subckt _sub4 7 10 13
    r9 (1 2) resistor r=0.333803
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=25
    r6 (13 4) resistor r=6.11111
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (2 0) capacitor c=5.3617e-17
    c1 (6 0) capacitor c=1.49353e-16
    c0 (13 0) capacitor c=8.84178e-18
ends _sub4
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_INVM0R%A
// View name: cmos_sch
subckt _sub5 6 10 19
    r9 (22 6) resistor r=46
    r8 (23 10) resistor r=41
    r7 (14 19) resistor r=0.0304091
    r6 (14 16) resistor r=26
    r5 (16 22) resistor r=10.4631
    r4 (16 23) resistor r=10.4631
    c3 (6 0) capacitor c=4.20247e-17
    c2 (10 0) capacitor c=3.91714e-17
    c1 (16 0) capacitor c=2.27182e-17
    c0 (19 0) capacitor c=7.38536e-17
ends _sub5
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: INVM0R
// View name: cmos_sch
subckt INVM0R A VBN VBP VDD VSS Z
    x_PM_INVM0R\%VBP (VBP N_VBP_M1_b) _sub0
    x_PM_INVM0R\%VBN (VBN N_VBN_M0_b) _sub1
    x_PM_INVM0R\%Z (Z N_Z_M1_d N_Z_M0_d) _sub2
    x_PM_INVM0R\%VDD (VDD VDD N_VDD_M1_s) _sub3
    x_PM_INVM0R\%VSS (VSS VSS N_VSS_M0_s) _sub4
    x_PM_INVM0R\%A (N_A_M0_g N_A_M1_g A) _sub5
    mM1 (N_Z_M1_d N_A_M1_g N_VDD_M1_s N_VBP_M1_b) P_12_LLRVT l=60n w=2u \
        sa=1.6e-07 sb=1.6e-07 nf=1 mis_flag=1 sd=0 as=320f ad=320f \
        ps=4.32u pd=4.32u sca=12.4031 scb=8.26389m scc=1.39456m m=1 mf=1
    mM0 (N_Z_M0_d N_A_M0_g N_VSS_M0_s N_VBN_M0_b) N_12_LLRVT l=60n w=2u \
        sa=1.6e-07 sb=1.6e-07 nf=1 mis_flag=1 sd=0 as=320f ad=320f \
        ps=4.32u pd=4.32u sca=12.4031 scb=8.26389m scc=1.39456m m=1 mf=1
ends INVM0R
// End of subcircuit definition.

// Library name: DDS
// Cell name: DACR2R_CELL
// View name: schematic
subckt DACR2R_CELL EN left right
    I0 (EN 0 vdd! vdd! 0 ENB) INVM0R
    NM1 (RSEL ENB vdd! vdd!) p_12_llrvt l=60n w=20u sa=160n sb=160n nf=4 \
        mis_flag=1 sd=200n as=2.6p ad=2p ps=31.04u pd=20.8u sca=5.17799 \
        scb=3.30657m scc=557.825u m=1 mf=1
    NM0 (RSEL ENB 0 0) n_12_llrvt l=60n w=10u sa=160n sb=160n nf=2 \
        mis_flag=1 sd=200n as=1.6p ad=1p ps=20.64u pd=10.4u sca=5.17799 \
        scb=3.30657m scc=557.825u m=1 mf=1
    R8 (right left) DACR2R_CELL_R
    R3 (net5 RSEL) DACR2R_CELL_R
    R6 (right net5) DACR2R_CELL_R
ends DACR2R_CELL
// End of subcircuit definition.

// Library name: DDS
// Cell name: DACR2R_8BITV1
// View name: schematic
subckt DACR2R_8BITV1 dac\<0\> dac\<1\> dac\<2\> dac\<3\> dac\<4\> dac\<5\> \
        dac\<6\> dac\<7\> dacout
    R7 (net2 0) DACR2R_CELL_R
    R6 (left net2) DACR2R_CELL_R
    I4\<0\> (dac\<0\> left right\<0\>) DACR2R_CELL
    I4\<1\> (dac\<1\> right\<0\> right\<1\>) DACR2R_CELL
    I4\<2\> (dac\<2\> right\<1\> right\<2\>) DACR2R_CELL
    I4\<3\> (dac\<3\> right\<2\> right\<3\>) DACR2R_CELL
    I4\<4\> (dac\<4\> right\<3\> right\<4\>) DACR2R_CELL
    I4\<5\> (dac\<5\> right\<4\> right\<5\>) DACR2R_CELL
    I4\<6\> (dac\<6\> right\<5\> right\<6\>) DACR2R_CELL
    I4\<7\> (dac\<7\> right\<6\> dacout) DACR2R_CELL
ends DACR2R_8BITV1
// End of subcircuit definition.

// Library name: umc65ll
// Cell name: RNHR_LL
// View name: schematic
subckt RNHR_LL_pcell_1 PLUS MINUS B
parameters segW=2u segL=10u mis_flag1=1
    R3 (n3 MINUS B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R2 (n2 n3 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R1 (n1 n2 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R0 (PLUS n1 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
ends RNHR_LL_pcell_1
// End of subcircuit definition.

// Library name: umc65ll
// Cell name: RNHR_LL
// View name: schematic
subckt RNHR_LL_pcell_2 PLUS MINUS B
parameters segW=2u segL=10u mis_flag1=1
    R5 (n5 MINUS B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R4 (n4 n5 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R3 (n3 n4 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R2 (n2 n3 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R1 (n1 n2 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R0 (PLUS n1 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
ends RNHR_LL_pcell_2
// End of subcircuit definition.

// Library name: umc65ll
// Cell name: RNHR_LL
// View name: schematic
subckt RNHR_LL_pcell_3 PLUS MINUS B
parameters segW=2u segL=10u mis_flag1=1
    R1 (n1 MINUS B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R0 (PLUS n1 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
ends RNHR_LL_pcell_3
// End of subcircuit definition.

// Library name: umc65ll
// Cell name: RNHR_LL
// View name: schematic
subckt RNHR_LL_pcell_4 PLUS MINUS B
parameters segW=2u segL=10u mis_flag1=1
    R7 (n7 MINUS B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R6 (n6 n7 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R5 (n5 n6 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R4 (n4 n5 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R3 (n3 n4 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R2 (n2 n3 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R1 (n1 n2 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
    R0 (PLUS n1 B) RNHR_LL w=segW l=segL mis_flag=mis_flag1
ends RNHR_LL_pcell_4
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%VBP
// View name: cmos_sch
subckt _sub6 3 11
    r4 (3 5) resistor r=0.118293
    r3 (5 7) resistor r=6.25
    r2 (7 11) resistor r=5.95833
    c1 (5 0) capacitor c=8.73358e-17
    c0 (7 0) capacitor c=8.23723e-18
ends _sub6
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%VBN
// View name: cmos_sch
subckt _sub7 7 9
    r4 (2 7) resistor r=0.0822008
    r3 (2 4) resistor r=5.75
    r2 (9 4) resistor r=1.875
    c1 (4 0) capacitor c=8.30807e-18
    c0 (7 0) capacitor c=1.01872e-16
ends _sub7
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%Z
// View name: cmos_sch
subckt _sub8 3 20 23
    r14 (1 3) resistor r=0.0695101
    r13 (1 16) resistor r=0.0429474
    r12 (3 4) resistor r=0.0825432
    r11 (4 6) resistor r=11.5
    r10 (20 6) resistor r=2
    r9 (8 18) resistor r=0.571479
    r8 (8 14) resistor r=0.0425
    r7 (10 14) resistor r=0.0652346
    r6 (10 12) resistor r=25
    r5 (23 12) resistor r=5.78947
    r4 (16 18) resistor r=0.047
    c3 (6 0) capacitor c=2.55825e-17
    c2 (12 0) capacitor c=8.32819e-18
    c1 (14 0) capacitor c=9.4329e-17
    c0 (18 0) capacitor c=6.58412e-17
ends _sub8
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%VDD
// View name: cmos_sch
subckt _sub9 7 10 13
    r9 (1 2) resistor r=0.319469
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=11.5
    r6 (13 4) resistor r=2
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (1 0) capacitor c=6.97874e-17
    c1 (6 0) capacitor c=1.36541e-16
    c0 (13 0) capacitor c=2.55691e-17
ends _sub9
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%VSS
// View name: cmos_sch
subckt _sub10 7 10 13
    r9 (1 2) resistor r=0.338349
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=25
    r6 (13 4) resistor r=5.78947
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (2 0) capacitor c=5.44934e-17
    c1 (6 0) capacitor c=1.49251e-16
    c0 (13 0) capacitor c=8.87134e-18
ends _sub10
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM1R%A
// View name: cmos_sch
subckt _sub11 6 9 18
    r9 (21 6) resistor r=43
    r8 (22 9) resistor r=63
    r7 (13 18) resistor r=0.0304091
    r6 (13 15) resistor r=26
    r5 (15 21) resistor r=10.4631
    r4 (15 22) resistor r=10.4631
    c3 (9 0) capacitor c=5.04138e-17
    c2 (15 0) capacitor c=2.26619e-17
    c1 (18 0) capacitor c=7.24629e-17
    c0 (21 0) capacitor c=4.07585e-17
ends _sub11
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: CKINVM1R
// View name: cmos_sch
subckt CKINVM1R A VBN VBP VDD VSS Z
    x_PM_CKINVM1R\%VBP (VBP N_VBP_M1_b) _sub6
    x_PM_CKINVM1R\%VBN (VBN N_VBN_M0_b) _sub7
    x_PM_CKINVM1R\%Z (Z N_Z_M1_d N_Z_M0_d) _sub8
    x_PM_CKINVM1R\%VDD (VDD VDD N_VDD_M1_s) _sub9
    x_PM_CKINVM1R\%VSS (VSS VSS N_VSS_M0_s) _sub10
    x_PM_CKINVM1R\%A (N_A_M0_g N_A_M1_g A) _sub11
    mM1 (N_Z_M1_d N_A_M1_g N_VDD_M1_s N_VBP_M1_b) P_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=7.875e-14 ad=7.875e-14 \
        ps=1.25e-06 pd=1.25e-06 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
    mM0 (N_Z_M0_d N_A_M0_g N_VSS_M0_s N_VBN_M0_b) N_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=3.325e-14 ad=3.325e-14 \
        ps=7.3e-07 pd=7.3e-07 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
ends CKINVM1R
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%VBP
// View name: cmos_sch
subckt _sub12 3 11
    r4 (3 5) resistor r=0.118293
    r3 (5 7) resistor r=6.25
    r2 (7 11) resistor r=5.95833
    c1 (5 0) capacitor c=9.20244e-17
    c0 (7 0) capacitor c=8.76238e-18
ends _sub12
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%VBN
// View name: cmos_sch
subckt _sub13 7 9
    r4 (2 7) resistor r=0.0822008
    r3 (2 4) resistor r=5.75
    r2 (9 4) resistor r=1.875
    c1 (4 0) capacitor c=8.30807e-18
    c0 (7 0) capacitor c=1.01874e-16
ends _sub13
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%Z
// View name: cmos_sch
subckt _sub14 3 20 23
    r15 (1 3) resistor r=0.0868876
    r14 (1 16) resistor r=0.0429474
    r13 (3 4) resistor r=0.0651657
    r12 (4 6) resistor r=7.66667
    r11 (20 6) resistor r=1.42857
    r10 (8 18) resistor r=0.556096
    r9 (8 14) resistor r=0.0425
    r8 (10 14) resistor r=0.0652346
    r7 (10 12) resistor r=25
    r6 (23 12) resistor r=4.23077
    r5 (16 18) resistor r=0.047
    c4 (4 0) capacitor c=6.36715e-17
    c3 (6 0) capacitor c=4.17025e-17
    c2 (12 0) capacitor c=8.32819e-18
    c1 (14 0) capacitor c=8.52788e-17
    c0 (18 0) capacitor c=4.65456e-17
ends _sub14
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%VDD
// View name: cmos_sch
subckt _sub15 7 10 13
    r9 (1 2) resistor r=0.320151
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=7.66667
    r6 (13 4) resistor r=1.42857
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (1 0) capacitor c=7.13824e-17
    c1 (6 0) capacitor c=1.49957e-16
    c0 (13 0) capacitor c=4.08691e-17
ends _sub15
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%VSS
// View name: cmos_sch
subckt _sub16 7 10 13
    r9 (1 2) resistor r=0.338349
    r8 (1 12) resistor r=0.0425
    r7 (2 4) resistor r=25
    r6 (13 4) resistor r=4.23077
    r5 (6 7) resistor r=0.204
    r4 (6 12) resistor r=0.0329
    r3 (10 12) resistor r=0.0799
    c2 (2 0) capacitor c=5.53466e-17
    c1 (6 0) capacitor c=1.49296e-16
    c0 (13 0) capacitor c=8.87134e-18
ends _sub16
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM2R%A
// View name: cmos_sch
subckt _sub17 6 9 18
    r9 (21 6) resistor r=44
    r8 (22 9) resistor r=79
    r7 (13 18) resistor r=0.0304091
    r6 (13 15) resistor r=26
    r5 (15 21) resistor r=10.4631
    r4 (15 22) resistor r=10.4631
    c3 (9 0) capacitor c=5.69292e-17
    c2 (15 0) capacitor c=2.26106e-17
    c1 (18 0) capacitor c=7.15049e-17
    c0 (21 0) capacitor c=4.04573e-17
ends _sub17
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: CKINVM2R
// View name: cmos_sch
subckt CKINVM2R A VBN VBP VDD VSS Z
    x_PM_CKINVM2R\%VBP (VBP N_VBP_M1_b) _sub12
    x_PM_CKINVM2R\%VBN (VBN N_VBN_M0_b) _sub13
    x_PM_CKINVM2R\%Z (Z N_Z_M1_d N_Z_M0_d) _sub14
    x_PM_CKINVM2R\%VDD (VDD VDD N_VDD_M1_s) _sub15
    x_PM_CKINVM2R\%VSS (VSS VSS N_VSS_M0_s) _sub16
    x_PM_CKINVM2R\%A (N_A_M0_g N_A_M1_g A) _sub17
    mM1 (N_Z_M1_d N_A_M1_g N_VDD_M1_s N_VBP_M1_b) P_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=1.1025e-13 \
        ad=1.1025e-13 ps=1.61e-06 pd=1.61e-06 sca=12.4031 scb=8.26389m \
        scc=1.39456m m=1 mf=1
    mM0 (N_Z_M0_d N_A_M0_g N_VSS_M0_s N_VBN_M0_b) N_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=4.55e-14 ad=4.55e-14 \
        ps=8.7e-07 pd=8.7e-07 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
ends CKINVM2R
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%VBP
// View name: cmos_sch
subckt _sub18 3 11
    r4 (3 5) resistor r=0.118293
    r3 (5 7) resistor r=6.25
    r2 (7 11) resistor r=5.95833
    c1 (5 0) capacitor c=8.25808e-17
    c0 (7 0) capacitor c=8.1383e-18
ends _sub18
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%VBN
// View name: cmos_sch
subckt _sub19 7 9
    r4 (2 7) resistor r=0.0818962
    r3 (2 4) resistor r=5.75
    r2 (9 4) resistor r=1.875
    c1 (4 0) capacitor c=8.68303e-18
    c0 (7 0) capacitor c=1.05232e-16
ends _sub19
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%VDD
// View name: cmos_sch
subckt _sub20 14 16 18 21
    r19 (1 2) resistor r=0.340978
    r18 (1 16) resistor r=0.0651423
    r17 (2 4) resistor r=7.66667
    r16 (18 4) resistor r=1.42857
    r15 (6 7) resistor r=0.176841
    r14 (6 17) resistor r=0.0367467
    r13 (7 16) resistor r=0.047172
    r12 (8 9) resistor r=0.149779
    r11 (8 17) resistor r=0.0583293
    r10 (9 11) resistor r=11.5
    r9 (21 11) resistor r=1.42857
    r8 (13 14) resistor r=0.0396667
    r7 (13 17) resistor r=0.0367467
    c6 (1 0) capacitor c=8.97475e-17
    c5 (6 0) capacitor c=5.0971e-17
    c4 (8 0) capacitor c=7.68667e-17
    c3 (11 0) capacitor c=3.81235e-17
    c2 (13 0) capacitor c=8.11112e-17
    c1 (17 0) capacitor c=7.22735e-18
    c0 (18 0) capacitor c=4.16197e-17
ends _sub20
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%VSS
// View name: cmos_sch
subckt _sub21 12 14 16 19
    r19 (1 2) resistor r=25
    r18 (1 3) resistor r=0.223125
    r17 (16 2) resistor r=4.15094
    r16 (3 14) resistor r=0.0651423
    r15 (4 5) resistor r=0.177061
    r14 (4 15) resistor r=0.0367467
    r13 (5 14) resistor r=0.047172
    r12 (6 7) resistor r=0.167168
    r11 (6 15) resistor r=0.0583293
    r10 (7 9) resistor r=25
    r9 (19 9) resistor r=4.15094
    r8 (11 12) resistor r=0.0396667
    r7 (11 15) resistor r=0.0367467
    c6 (3 0) capacitor c=5.47154e-17
    c5 (4 0) capacitor c=4.61323e-17
    c4 (7 0) capacitor c=4.42068e-17
    c3 (9 0) capacitor c=9.62626e-18
    c2 (11 0) capacitor c=9.40377e-17
    c1 (15 0) capacitor c=7.10536e-18
    c0 (16 0) capacitor c=7.94661e-18
ends _sub21
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%Z
// View name: cmos_sch
subckt _sub22 18 19 20 22 23
    r21 (1 2) resistor r=0.112083
    r20 (1 12) resistor r=0.0967738
    r19 (2 4) resistor r=25
    r18 (23 4) resistor r=4.15094
    r17 (22 4) resistor r=4.15094
    r16 (6 7) resistor r=0.18796
    r15 (6 14) resistor r=0.0967738
    r14 (7 9) resistor r=7.66667
    r13 (20 9) resistor r=1.42857
    r12 (19 9) resistor r=1.42857
    r11 (11 12) resistor r=0.241263
    r10 (11 18) resistor r=0.094357
    r9 (13 14) resistor r=0.237939
    r8 (13 16) resistor r=0.0952643
    r7 (16 18) resistor r=0.527891
    c6 (12 0) capacitor c=2.37584e-17
    c5 (13 0) capacitor c=1.64368e-17
    c4 (14 0) capacitor c=2.52338e-17
    c3 (16 0) capacitor c=2.36178e-16
    c2 (18 0) capacitor c=2.34046e-17
    c1 (19 0) capacitor c=7.32174e-17
    c0 (22 0) capacitor c=1.46998e-17
ends _sub22
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: PM_CKINVM4R%A
// View name: cmos_sch
subckt _sub23 10 14 17 21 32
    r21 (9 10) resistor r=59.6
    r20 (9 24) resistor r=10.0376
    r19 (13 14) resistor r=89
    r18 (13 24) resistor r=10.0376
    r17 (16 17) resistor r=59.6
    r16 (16 26) resistor r=10.0376
    r15 (20 21) resistor r=89
    r14 (20 26) resistor r=10.0376
    r13 (23 24) resistor r=1.61231
    r12 (23 36) resistor r=7.6
    r11 (25 26) resistor r=1.61231
    r10 (25 36) resistor r=8.4
    r9 (32 34) resistor r=0.0628029
    r8 (34 36) resistor r=26
    c7 (10 0) capacitor c=3.23936e-17
    c6 (14 0) capacitor c=4.15873e-17
    c5 (17 0) capacitor c=3.89444e-17
    c4 (21 0) capacitor c=4.75924e-17
    c3 (24 0) capacitor c=4.71715e-18
    c2 (25 0) capacitor c=2.48892e-17
    c1 (26 0) capacitor c=1.15302e-17
    c0 (34 0) capacitor c=8.96684e-17
ends _sub23
// End of subcircuit definition.

// Library name: uk65lscllmvbbr
// Cell name: CKINVM4R
// View name: cmos_sch
subckt CKINVM4R A VBN VBP VDD VSS Z
    x_PM_CKINVM4R\%VBP (VBP N_VBP_M2_b) _sub18
    x_PM_CKINVM4R\%VBN (VBN N_VBN_M0_b) _sub19
    x_PM_CKINVM4R\%VDD (VDD VDD N_VDD_M2_s N_VDD_M3_d) _sub20
    x_PM_CKINVM4R\%VSS (VSS VSS N_VSS_M0_s N_VSS_M1_d) _sub21
    x_PM_CKINVM4R\%Z (Z N_Z_M3_s N_Z_M2_d N_Z_M1_s N_Z_M0_d) _sub22
    x_PM_CKINVM4R\%A (N_A_M0_g N_A_M2_g N_A_M1_g N_A_M3_g A) _sub23
    mM3 (N_VDD_M3_d N_A_M3_g N_Z_M3_s N_VBP_M2_b) P_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=6.3e-14 ad=1.1025e-13 \
        ps=8.3e-07 pd=1.61e-06 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
    mM2 (N_Z_M2_d N_A_M2_g N_VDD_M2_s N_VBP_M2_b) P_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=1.1025e-13 ad=6.3e-14 \
        ps=1.61e-06 pd=8.3e-07 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
    mM1 (N_VSS_M1_d N_A_M1_g N_Z_M1_s N_VBN_M0_b) N_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=2.65e-14 ad=4.6375e-14 \
        ps=4.65e-07 pd=8.8e-07 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
    mM0 (N_Z_M0_d N_A_M0_g N_VSS_M0_s N_VBN_M0_b) N_12_LLRVT l=60n w=2u \
        sa=160n sb=160n nf=1 mis_flag=1 sd=200n as=4.6375e-14 ad=2.65e-14 \
        ps=8.8e-07 pd=4.65e-07 sca=12.4031 scb=8.26389m scc=1.39456m m=1 \
        mf=1
ends CKINVM4R
// End of subcircuit definition.

// Library name: DDS
// Cell name: COMP_R2RV2
// View name: schematic
subckt COMP_R2RV2 VBIASN VBIASP VIN1 VIN2 VOUT VREF gnd vdd vn vp
parameters N_L=250n N_W=1u P_L=150n P_W=1u
    NM7 (VOUTS2 dop2 gnd 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM6 (dip1 dop1 gnd 0) n_12_llrvt l=2*N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM5 (dip2 dop1 gnd 0) n_12_llrvt l=2*N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM4 (dop2 VBIASN dip2 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM3 (dop1 VBIASN dip1 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM8 (net2 vn gnd 0) n_12_llrvt l=4*N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM2 (din2 VIN2 net2 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM0 (din1 VIN1 net2 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM5 (VOUTS2 vp vdd vdd!) p_12_llrvt l=P_L w=2*P_W sa=(((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((2*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (2*P_W) / (1)) + (((1) == 1 ? 0 : (((2*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (2*P_W) / (1) * 0) \
         ad=((((((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (2*P_W) / (1)) + (((1) == 1 ? 0 : (((2*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (2*P_W) / (1) * 0) \
         ps=((((((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((2*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((2*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((2*P_W) / (1)*2))*0 \
         pd=((((((2*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((2*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((2*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((2*P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((2*P_W) / (1)))*(1/(150n)-1/((150n)+((2*P_W) / (1)))) \
         scb=(1/(((2*P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((2*P_W) / (1)))*exp(-10*((150n)+((2*P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((2*P_W) / (1)))/2.0u)) \
         scc=(1/(((2*P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((2*P_W) / (1)))*exp(-20*((150n)+((2*P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((2*P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM4 (dop2 VBIASP din2 vdd!) p_12_llrvt l=P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM3 (dop1 VBIASP din1 vdd!) p_12_llrvt l=P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM2 (din2 vp vdd vdd!) p_12_llrvt l=2*P_L w=1.5*P_W sa=(((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (1.5*P_W) / (1)) + (((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (1.5*P_W) / (1) * 0) \
         ad=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (1.5*P_W) / (1)) + (((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (1.5*P_W) / (1) * 0) \
         ps=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((1.5*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((1.5*P_W) / (1)*2))*0 \
         pd=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((1.5*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((1.5*P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((1.5*P_W) / (1)))*(1/(150n)-1/((150n)+((1.5*P_W) / (1)))) \
         scb=(1/(((1.5*P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((1.5*P_W) / (1)))*exp(-10*((150n)+((1.5*P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((1.5*P_W) / (1)))/2.0u)) \
         scc=(1/(((1.5*P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((1.5*P_W) / (1)))*exp(-20*((150n)+((1.5*P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((1.5*P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM1 (din1 vp vdd vdd!) p_12_llrvt l=2*P_L w=1.5*P_W sa=(((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (1.5*P_W) / (1)) + (((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (1.5*P_W) / (1) * 0) \
         ad=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (1.5*P_W) / (1)) + (((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (1.5*P_W) / (1) * 0) \
         ps=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((1.5*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((1.5*P_W) / (1)*2))*0 \
         pd=((((((1.5*P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((1.5*P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((1.5*P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((1.5*P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((1.5*P_W) / (1)))*(1/(150n)-1/((150n)+((1.5*P_W) / (1)))) \
         scb=(1/(((1.5*P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((1.5*P_W) / (1)))*exp(-10*((150n)+((1.5*P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((1.5*P_W) / (1)))/2.0u)) \
         scc=(1/(((1.5*P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((1.5*P_W) / (1)))*exp(-20*((150n)+((1.5*P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((1.5*P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM6 (net4 vp vdd vdd) p_12_llrvt l=4*P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    PM0 (dip2 VIN2 net4 vdd!) p_12_llrvt l=P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    NM1 (dip1 VIN1 net4 vdd!) p_12_llrvt l=P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    I4 (VOUTS2 0 vdd! vdd! 0 VOUT1) CKINVM1R
    I5 (VOUT1 0 vdd! vdd! 0 net1) CKINVM2R
    I11 (net1 0 vdd! vdd! 0 VOUT) CKINVM4R
ends COMP_R2RV2
// End of subcircuit definition.

// Library name: DDS
// Cell name: COMP_R2RV2_BIAS
// View name: schematic
subckt COMP_R2RV2_BIAS GND VDD VIN1 VIN2 VOUT VREF
parameters P_L=150n P_W=1u N_L=250n N_W=1u
    PM0 (vp vp vdd! vdd!) p_12_llrvt l=P_L w=P_W sa=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ad=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (P_W) / (1)) + (((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (P_W) / (1) * 0) \
         ps=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         pd=((((((P_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((P_W) / (1)*2)) + ((((1) == 1 ? 0 : (((P_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((P_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((P_W) / (1)))*(1/(150n)-1/((150n)+((P_W) / (1)))) \
         scb=(1/(((P_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((P_W) / (1)))*exp(-10*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((P_W) / (1)))/2.0u)) \
         scc=(1/(((P_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((P_W) / (1)))*exp(-20*((150n)+((P_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((P_W) / (1)))/2.0u)) \
         m=1 mf=1
    R1 (vdd! VBIASN vdd!) RNHR_LL_pcell_1 m=1 segW=1u segL=10u mis_flag1=1
    R0 (vdd! vn vdd!) RNHR_LL_pcell_2 m=1 segW=1u segL=20u mis_flag1=1
    R4 (VBIASP 0 vdd!) RNHR_LL_pcell_3 m=1 segW=2.5u segL=10u mis_flag1=1
    R2 (vp 0 vdd!) RNHR_LL_pcell_2 m=1 segW=1u segL=20u mis_flag1=1
    R3 (VBIASN 0 vdd!) RNHR_LL_pcell_4 m=1 segW=2.5u segL=10u mis_flag1=1
    R6 (vdd! VBIASP vdd!) RNHR_LL_pcell_1 m=1 segW=1u segL=10u mis_flag1=1
    NM1 (vn vn 0 0) n_12_llrvt l=N_L w=N_W sa=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         sb=(((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)) \
         nf=1 mis_flag=1 sd=(1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n) \
         as=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ad=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))) * (N_W) / (1)) + (((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n)) * (N_W) / (1) * 0) \
         ps=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         pd=((((((N_W) / (1)) < 119.5n) ? 0.175u > ((90n) + 30n) ? 0.175u : ((90n) + 30n) : 140n > ((90n) + (15n + 55n)) ? 140n : ((90n) + (15n + 55n)))*2) + ((N_W) / (1)*2)) + ((((1) == 1 ? 0 : (((N_W) / (1)) < 119.5n) ? 0.23u > ((90n) + 30n) ? 0.23u : ((90n) + 30n) : 130n > ((90n) + 110n) ? 130n : ((90n) + 110n))*2) + ((N_W) / (1)*2))*0 \
         sca=((2.0u*2.0u)/((N_W) / (1)))*(1/(150n)-1/((150n)+((N_W) / (1)))) \
         scb=(1/(((N_W) / (1))*2.0u))*(2.0u/10*(150n)*exp(-10*(150n)/2.0u)+((2.0u*2.0u)/100)*exp(-10*(150n)/2.0u)-(2.0u/10)*((150n)+((N_W) / (1)))*exp(-10*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/100*exp(-10*((150n)+((N_W) / (1)))/2.0u)) \
         scc=(1/(((N_W) / (1))*2.0u))*(2.0u/20*(150n)*exp(-20*(150n)/2.0u)+((2.0u*2.0u)/400)*exp(-20*(150n)/2.0u)-(2.0u/20)*((150n)+((N_W) / (1)))*exp(-20*((150n)+((N_W) / (1)))/2.0u)-(2.0u*2.0u)/400*exp(-20*((150n)+((N_W) / (1)))/2.0u)) \
         m=1 mf=1
    I12 (VBIASN VBIASP VIN1 VIN2 VOUT VREF GND VDD vn vp) COMP_R2RV2 \
        N_L=N_L N_W=N_W P_L=P_L P_W=P_W
ends COMP_R2RV2_BIAS
// End of subcircuit definition.


// Library name: DDS
// Cell name: adc_analog
// View name: schematic
subckt adc_analog GND VDD VIN VREF compout vdac\<0\> vdac\<1\> vdac\<2\> \
        vdac\<3\> vdac\<4\> vdac\<5\> vdac\<6\> vdac\<7\>
    I0 (vdac\<0\> vdac\<1\> vdac\<2\> vdac\<3\> vdac\<4\> vdac\<5\> \
        vdac\<6\> vdac\<7\> net2) DACR2R_8BITV1
    I1 (GND VDD net2 VIN compout VREF) COMP_R2RV2_BIAS P_L=150n P_W=10u \
        N_L=150n N_W=10u
ends adc_analog
// End of subcircuit definition.

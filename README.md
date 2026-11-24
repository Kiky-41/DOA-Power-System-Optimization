# DOA-Power-System-Optimization

**Strategi Komputasi Cerdas untuk Optimasi Sistem Tenaga Listrik**

Rifki Rahman Nur Ikhsan, Jangkung Raharjo, Lindiasari Martha Yustika, Runik Machfiroh  
*Penerbit Wawasan Ilmu, 2025. ISBN 978-623-132-587-7*

Companion code for the book: Dingo Optimization Algorithm (DOA) for ED, ED-VPE, ED-POZ, ED-UC and EED, plus chaotic-map / Lévy-flight illustration scripts.

## Contents

```
.gitignore
DOA (ED).ipynb
DOA (ED-POZ).ipynb
DOA (ED-UC).ipynb
DOA (ED-VPE).ipynb
DOA (EED).ipynb
Vectorization.ipynb
illustrations/
  BF.m
  BF.png
  BM.m
  BM.png
  CS.m
  CS.png
  CW.m
  CW.png
  ChM.m
  ChM.png
  CiM.m
  CiM.png
  ED.png
  KS.m
  KS.png
  LF.m
  LF.png
  LM.m
  LM.png
  MCW.png
  MS.m
  MS.png
  POZ.png
  Plotd.m
  Plote.m
  Plotg.m
  RW.png
  SC.m
  SC.png
  SM.m
  SM.png
  TM.m
  TM.png
  VPE+POZ.png
  VPE.png
  load1.png
  plotf.m
```

## Data

Input data is **not included**. Place files in `data/` (notebooks) or next to the `.m` script (MATLAB):

| File | Columns |
|---|---|
| `13-unit.xlsx` | Table 1: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`; Table 2: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`; Table 3: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `α`, `β`, `γ`, `ξ`, `δ` |
| `15-unit.xlsx` | Table 1: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `rampup`, `rampdown`; Table 2: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`; Table 3: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`, `poz`; Table 4: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`, `poz`, `d`, `e` |
| `3-unit.xlsx` | Table 1: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `rampup`, `rampdown`; Table 2: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `rampup`, `rampdown`; Table 3: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `Pnow`, `rampup`, `rampdown`; Table 4: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `α`, `β`, `γ`, `Pnow`, `rampup`, `rampdown` |
| `40-unit.xlsx` | Table 1: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `rampup`, `rampdown`; Table 2: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `rampup`, `rampdown`; Table 3: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `d`, `e`, `α`, `β`, `γ`, `ξ`, `δ` |
| `6-unit.xlsx` | Table 1: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `rampup`, `rampdown`; Table 2: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`; Table 3: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`, `poz`; Table 4: `Unit`, `pmin`, `pmax`, `a`, `b`, `c`, `Pnow`, `rampup`, `rampdown`, `poz`, `d`, `e`; Bij Matrix: `Unit 1`, `Unit 2`, `Unit 3`, `Unit 4`, `Unit 5`, `Unit 6` |
| `pd13u.xlsx` | Sheet1: `load` |
| `pd15u-6hours.xlsx` | Sheet1: `load` |
| `pd15u.xlsx` | Sheet1: `load` |
| `pd3u-6hours.xlsx` | Sheet1: `load` |
| `pd3u.xlsx` | Sheet1: `load` |
| `pd40u.xlsx` | Sheet1: `load` |
| `pd6u.xlsx` | Sheet1: `load` |

## Requirements

Python, MATLAB. Python notebooks: `numpy`, `pandas`, `scipy`, `matplotlib` (as imported). MATLAB scripts: R2021a+.

# DOA-Power-System-Optimization

**Strategi Komputasi Cerdas untuk Optimasi Sistem Tenaga Listrik**

Rifki Rahman Nur Ikhsan, Jangkung Raharjo, Lindiasari Martha Yustika, Runik Machfiroh  
*Penerbit Wawasan Ilmu, 2025. ISBN 978-623-132-587-7*

Companion code for the book: Dingo Optimization Algorithm (DOA) for ED, ED-VPE, ED-POZ, ED-UC and EED, plus chaotic-map / Lévy-flight illustration scripts.


## Proposed method

The book uses the Dream Optimization Algorithm (DOA), a population method modelled on memory consolidation during sleep: useful information is retained, irrelevant detail is forgotten, and new candidates are formed by recombining stored experience. The first 90% of iterations explore; the last 10% exploit around the best memory. The companion notebooks apply the same loop to 3-, 6-, 15- and 40-unit systems for ED, ED with valve-point effects, ED with prohibited operating zones, ED with unit commitment, and economic–emission dispatch.

### Dispatch objective

$$\min F(\mathbf{P})=\sum_{i=1}^{N}\left(a_i+b_iP_i+c_iP_i^2\right)+\rho\left|P_D-\sum_iP_i\right|,\qquad \rho=10^{4},$$

subject to $P_i^{\min}\le P_i\le P_i^{\max}$ and the ramp limits $P_i^{t}-P_i^{t-1}\le R_i^{U}$, $P_i^{t-1}-P_i^{t}\le R_i^{D}$. The penalty term drives the population toward exact balance without an explicit equality operator.

### Notation

| Symbol | Meaning | Unit |
|---|---|---|
| $N$ | number of units | – |
| $N_{\text{pop}}$ | population size (30) | – |
| $P_i$ | output of unit $i$ | MW |
| $a_i,b_i,c_i$ | cost coefficients | – |
| $P_D$ | demand | MW |
| $\rho$ | penalty coefficient | – |
| $x_{j,h}$ | coordinate $h$ of individual $j$ | MW |
| $s_{m,h}$ | coordinate $h$ of the best member of memory group $m$ | MW |
| $s^{\ast}_h$ | coordinate $h$ of the global best | MW |
| $k$ | number of perturbed coordinates | – |
| $u_h,l_h$ | upper and lower bounds of coordinate $h$ | MW |
| $t,T$ | iteration and iteration cap | – |
| $r$ | uniform random number in $[0,1]$ | – |

### Exploration phase

The population is split into five memory groups. For group $m$, let $\mathbf{s}_m$ be its best member. Each member is reset to the group best and $k$ coordinates are perturbed, with $k\in[\lceil N/(8(m+1))\rceil,\lceil N/(3(m+1))\rceil]$:

$$x_{j,h}\leftarrow s_{m,h}+\left(r~(u_h-l_h)+l_h\right)\frac{\cos\left(\left(t+\frac{T}{10}\right)\frac{\pi}{T}\right)+1}{2},\qquad r\sim\mathcal{U}(0,1).$$

The cosine factor starts near one and falls toward zero, so early iterations take large steps and later ones refine. With probability 0.9 the selected coordinates receive this supplement (a new idea); otherwise they are replaced by the corresponding coordinate of a random individual (forgetting). Out-of-bound values are re-drawn inside $[l_h,u_h]$ when $N\le15$, or copied from another individual when $N>15$.

### Exploitation phase

For the last 10% of iterations, every individual is rebuilt from the global best and only $k\in[2,\lceil N/3\rceil]$ coordinates are perturbed:

$$x_{j,h}\leftarrow s^{\ast}_h+\left(r~(u_h-l_h)+l_h\right)\frac{\cos\left(t\frac{\pi}{T}\right)+1}{2}.$$

The smaller coordinate count and the shrinking cosine factor concentrate the search around the best memory.

### Balance and ramp repair

The final best is rescaled to the demand and clipped to the limits:

$$\mathbf{s}^{\ast}\leftarrow\operatorname{clip}\left(\mathbf{s}^{\ast}\frac{P_D}{\sum_is_i^{\ast}},\mathbf{P}^{\min},\mathbf{P}^{\max}\right).$$

The ramp adjustment then limits the move relative to the reference schedule:

$$\mathbf{s}^{\ast}\leftarrow\mathbf{P}^{t-1}+\operatorname{clip}\left(\mathbf{s}^{\ast}-\mathbf{P}^{t-1},-\mathbf{R}^{D},\mathbf{R}^{U}\right).$$

### Implementation note

The notebook applies the ramp adjustment relative to the first individual of the final population (`x[0]`), not to the previous hour's dispatch. Treat the ramp check as a post-processing heuristic in the companion code; the README formulation states the intended inter-hour constraint.

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

## License

[![CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](LICENSE)

Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). **Attribution is required**: any use of this code, results, or figures, including in publications, must cite:

> Rifki Rahman Nur Ikhsan, Jangkung Raharjo, Lindiasari Martha Yustika, Runik Machfiroh (2025). *Strategi Komputasi Cerdas untuk Optimasi Sistem Tenaga Listrik*. Penerbit Wawasan Ilmu. ISBN 978-623-132-587-7

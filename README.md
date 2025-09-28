# Bd–Amphibian model (MATLAB) — Ecosphere

**Status:** In review at *Ecosphere* (Disease Ecology).  
**Maintainer:** Hendrik Sulbaran-Pineda ([@hsulbaran](https://github.com/hsulbaran))

This repository contains MATLAB code to reproduce the simulations and figures for the manuscript:

> *Overdispersed pathogen burdens shape chytridiomycosis outcomes in amphibians: A mathematical modeling approach*  
> Sulbaran-Pineda **et al.**, 2025, *Ecosphere* (in review)

## Overview
- Stage-structured host–pathogen ODE model (adults **H**, tadpoles **h**) with within-host burdens (**ZH**, **Zh**) and an abiotic reservoir (**Z**).
- Heterogeneous (overdispersed → uniform) burden distributions embedded via an aggregation parameter (\varphi). 
- Seasonal forcing for temperature (affecting within-host zoospore growth) and rainfall (affecting fecundity).
- Reproducible scripts for long-run dynamics, seasonal patterns, parameter scenarios, and phase diagrams over (\varphi_H, \beta_H).

## System requirements
- **MATLAB R2024a** or newer (base installation).  
- Uses built-in stiff solver **`ode15s`** (no toolboxes required).  
- OS: Windows / macOS / Linux.

## Quick start
1. Clone the repo:
   ```bash
   git clone https://github.com/hsulbaran/bd-amphibian-overdispersion-ecosphere.git
   cd bd-amphibian-overdispersion-ecosphere
   ```
2. Open MATLAB and set the repo root as the working folder. Add subfolders to the path:
   ```matlab
   addpath(genpath('functions')); addpath('scripts'); mkdir('output/figures'); mkdir('output/sims');
   savepath;
   ```
3. Run the baseline simulation and main figures:
   ```matlab
   run('scripts/run_baseline.m');        % saves baseline outputs to output/sims/
   run('scripts/make_figures_main.m');   % saves Figure panels A–D to output/figures/
   run('scripts/make_figures_env.m');    % saves environmental drivers panels
   ```
4. Optional: scenarios and phase diagrams
   ```matlab
   run('scripts/make_figures_scenarios.m');  % α_h=0, φ sweeps (optional)
   run('scripts/sweep_phase_diagram.m');     % produces B1 (full) and B2 (zoom)
   ```

All figures will be written to `output/figures/` as both **.png** and **.pdf**.

## File map
- `functions/bd_host_ode.m`: ODE RHS; demographic & epidemiological processes (weekly scale).  
- `functions/func_phiH_betaH.m`: helper to run the ODE for given `(phiH, betaH)`, returning **H** and **ZH/H**.
- `functions/env_drivers.m`: temperature / rainfall functions and derived rates `a_H(t)` and `r_H(t)`.
- `functions/colors.m`: color palette used across figures.
- `functions/integrate_model.m`: wrapper to integrate the system with optional parameter overrides.
- `scripts/run_baseline.m`: 2000-week run with initial conditions `[H h ZH Zh Z] = [50 50 100 100 500]`.
- `scripts/make_figures_*.m`: plotting routines matching manuscript panels.
- `scripts/sweep_phase_diagram.m`: builds the (\varphi_H, \beta_H) grid, optional `parpool` use, classification & plots.

## Reproducibility
- **Determinism**: deterministic ODEs (no RNG dependence).  
- **Numerics**: Baseline tolerances are `RelTol=1e-6`, `AbsTol=1e-6`. Phase diagrams use `RelTol=1e-4` to speed grid sweeps.
- **Parallel**: `sweep_phase_diagram.m` optionally opens a local `parpool`. If unavailable, it falls back to serial loops.

## How to cite
Please cite the paper once available and this repository as software:

- **Article**: Sulbaran-Pineda, H., Lampo, M., Ballestas, O., Casanova-Hernández, N., & Rodríguez, D. (2025). *Overdispersed pathogen burdens shape chytridiomycosis outcomes in amphibians*. *Ecosphere*. **DOI:** <DOI>
- **Code**: Sulbaran-Pineda, H. (2025). *bd-amphibian-overdispersion-ecosphere* (v1.0). GitHub. **DOI (Zenodo):** <DOI>

See `CITATION.cff` for a citation block supported by GitHub.

## License
The code is released under the **MIT License** (see `LICENSE`).

## Contact
Issues and questions: open a GitHub Issue or email **hsulbaran17@gmail.com**.

# Installation

## MATLAB
- Install **MATLAB R2024a** (or newer). No toolboxes are required.
- Verify the solver is available:
  ```matlab
  which ode15s
  ```

## Clone and set up
```bash
git clone https://github.com/hsulbaran/bd-amphibian-overdispersion-ecosphere.git
cd bd-amphibian-overdispersion-ecosphere
```
In MATLAB:
```matlab
addpath(genpath('functions')); addpath('scripts');
mkdir('output/figures'); mkdir('output/sims'); savepath;
```

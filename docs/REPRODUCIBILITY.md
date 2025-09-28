# Reproducibility notes

- **Determinism**: All simulations are deterministic ODEs; no random seeds required.
- **Numerics**: Baseline tolerances are `RelTol=1e-6`, `AbsTol=1e-6`. Phase diagrams use `RelTol=1e-4` to speed grid sweeps.
- **Parallel**: `scripts/sweep_phase_diagram.m` optionally opens a local `parpool`. If unavailable, it falls back to serial loops.
- **Environment capture**: Record your MATLAB version and OS in your release notes; export figures as `.png` and `.pdf`.

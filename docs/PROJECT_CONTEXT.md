# Project context — om-vehicle-simulation

Source of truth for setup, scope, and team context. Agents and contributors should read this and [README.md](../README.md).

## Mission

Build modular vehicle simulation in **OpenModelica** for a digital-twin program: **powertrain first**, vehicle dynamics later, with **FMU export** and eventual **multi-FMU orchestration**. Models are generic/educational — no proprietary parameters in this public repo.

## Hard problems (context only)

- **Traceability** — ISO 26262-style hashes of FMUs, parameters, tests
- **Orchestrator** — heterogeneous solvers; Rust/C++ preferred
- **Timing** — physics variable step vs firmware 1 ms fixed

## Technical direction (team decisions)

| Topic | Decision |
|-------|----------|
| Tool | OpenModelica (not Simulink): cost, FMU export, acausal modeling |
| Modularity | Subsystems as FMUs with defined I/O; multi-fidelity later |
| Vehicle dynamics | MSL has no modern VD; future: Project Chrono / Corona-class libs |
| Implementation | Rust/C++ for orchestrator later |
| Architecture | Acausal connections (torque/speed, V/I); customer FMUs plug in without exposing internals |

## Environment (Mac + Docker)

- Image: `openmodelica/openmodelica:v1.26.3-gui`
- **`docker-om`** — container with `$HOME` mounted, `DISPLAY=host.docker.internal:0`, `.Xauthority` mounted
- **`om-x11-prep`** — XQuartz “Allow network clients”; may start socat on `:6000`
- OMEdit: `docker-om OMEdit` after `om-x11-prep`
- **Do not** use official ifconfig DISPLAY alias (can pick router IP, not Mac)

### Modelica Standard Library

Docker images do not ship MSL. Install to `~/.openmodelica/libraries/`:

- Script: `scripts/install_msl.mos` via `om-install-msl` (`omc -e` does **not** work for this)
- Default: Modelica **4.0.0**; fallback: `4.0.0+maint.om`
- GUI: OMEdit → Tools → Install Library → Modelica
- After install, restart OMEdit; verify `Modelica*` under `~/.openmodelica/libraries/`

## Repository goals

1. Minimal `models/Vehicle/` (Battery, Motor, `Powertrain` example)
2. `scripts/simulate.mos` then `scripts/export_fmu.mos`
3. Document Docker / `docker-om` / `om-x11-prep` / `om-install-msl` in README

## Open questions

- Centralized vs distributed FMU ownership
- Who picks model fidelity per test
- Physics variable step vs 1 ms firmware — orchestrator design TBD

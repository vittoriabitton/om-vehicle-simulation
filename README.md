# om-vehicle-simulation

Modular vehicle simulation in **OpenModelica** (powertrain, vehicle dynamics, FMU export) with generic models only for now.

## Layout

```
models/Vehicle/
  Powertrain/          Battery.mo, Motor.mo
  Examples/            Powertrain.mo
scripts/
  install_msl.mos      Install Modelica Standard Library
  simulate.mos         Run first example
  export_fmu.mos       FMU codegen (see FMU section)
docs/PROJECT_CONTEXT.md
build/                 Outputs (gitignored)
```

## Prerequisites

- OpenModelica v1.26.x (local or Docker)
- **MSL** installed to `~/.openmodelica/libraries/` (see below)

## Mac: Docker + OMEdit

Image: `openmodelica/openmodelica:v1.26.3-gui`

| Alias | Purpose |
|-------|---------|
| `docker-om` | Container with `$HOME`, X11 (`host.docker.internal:0`) |
| `om-x11-prep` | XQuartz + optional socat on `:6000` |
| `om-install-msl` | `omc scripts/install_msl.mos` |

```bash
om-x11-prep && docker-om OMEdit
```

Full setup notes: [docs/PROJECT_CONTEXT.md](docs/PROJECT_CONTEXT.md).

### Install MSL

```bash
om-install-msl
```

## Simulate

From repo root (MSL required):

```bash
mkdir -p build
omc scripts/simulate.mos
```

Docker:

```bash
docker run --rm -v "$HOME:$HOME" -w "$(pwd)" -e HOME="$HOME" \
  openmodelica/openmodelica:v1.26.3-gui \
  omc scripts/simulate.mos
```

Success: `build/Powertrain_res.mat` and `LOG_SUCCESS` in the OMC log.

## First model

`Vehicle.Examples.Powertrain` — 400 V battery, RL motor.

## FMU export

Run only after `simulate.mos` succeeds.

**Headless (`omc`):** generates sources under `build/*.fmutmp/`:

```bash
omc scripts/export_fmu.mos
```

**Complete `.fmu` archive:** use OMEdit on this model — **File → Export → FMU** (Docker GUI workflow above). Headless zip/link of the FMU binary failed in the `v1.26.3-gui` image without a full `configure` step; OMEdit export is the besdt path for now.

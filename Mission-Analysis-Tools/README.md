# Equations Module for Orbital Mechanics and Propulsion

This folder contains MATLAB implementations of key equations for orbital mechanics, propulsion systems, stability dynamics, and spacecraft design. Each script is modular and focuses on a specific set of calculations.

## Features

### 1. Orbital Mechanics and Perturbations
- **Orbital Period Calculation**:
  \[
  T_{period} = 2\pi \sqrt{rac{a^3}{\mu}}
  \]
- **RAAN Precession and Argument of Perigee Precession**:
  Calculates the rates of change due to Earth's oblateness (J2 effect).

### 2. Delta-V and Propellant Requirements
- **Delta-V Calculation**:
  \[
  \Delta v = I_{sp} \cdot g_0 \cdot \ln\left(rac{M_{wet}}{M_{dry}}
ight)
  \]
- **Propellant Mass Requirement**:
  Computes the mass of propellant needed for maneuvers and deorbiting.

### 3. Stability and Torque Dynamics
- Calculates torques acting on the spacecraft, including gravitational, aerodynamic, and solar radiation pressure torques.

### 4. Hohmann Transfer and Orbital Changes
- Computes delta-V and other parameters for orbital transfers using the Hohmann method.

### 5. Propellant Tank Design
- Includes equations for tank thickness, mass, and pressurization requirements.

## Directory Structure

```
Mission-Analysis-Tools/
│
├── OrbitalMechanics.m               # Orbital period, perturbations (RAAN, argument of perigee)
├── DeltaVPropellant.m               # Delta-V and propellant mass requirements
├── StabilityDynamics.m              # Torques and stability dynamics
├── HohmannTransfer.m                # Hohmann transfer calculations
├── PropellantTankDesign.m           # Tank thickness, mass, and pressurization
│
└── README.md                        # Documentation
```

## Usage

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/Space-Flight-AA131.git
   cd Space-Flight-AA131/equations
   ```

2. Add the repository to your MATLAB path:
   ```matlab
   addpath(genpath('path_to_equations'))
   ```

3. Run the desired script for specific calculations.

## Details of Each Script

### `OrbitalMechanics.m`
- **Inputs**: Semi-major axis (`a`), eccentricity (`e`), inclination (`i`), gravitational parameter (`mu`).
- **Outputs**: Orbital period, RAAN precession rate, argument of perigee precession rate, semi-major axis decay, and eccentricity change rate.

### `DeltaVPropellant.m`
- **Inputs**: Delta-V (`Delta v`), specific impulse (`I_sp`), gravitational constant (`g_0`), wet mass (`M_wet`), dry mass (`M_dry`).
- **Outputs**: Required delta-V and propellant mass.

### `StabilityDynamics.m`
- **Inputs**: Moments of inertia, gravitational parameter, aerodynamic coefficients, solar radiation pressure parameters.
- **Outputs**: Stability torque calculations.

### `HohmannTransfer.m`
- **Inputs**: Parking orbit radius (`r_park`), target orbit radius (`r_target`), gravitational parameter (`mu`).
- **Outputs**: Transfer orbit parameters and total delta-V.

### `PropellantTankDesign.m`
- **Inputs**: Tank pressure, material properties, volume, temperature.
- **Outputs**: Tank thickness, mass, and pressurization details.

---

## Acknowledgments
This module was developed as part of the **Space-Flight-AA131** project by Brad Yac-Diaz & Omar Abdallah.

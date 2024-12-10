# Space Flight (AA131) Project

This repository contains MATLAB scripts and modules developed as part of the Space Flight AA131 project. The project focuses on orbital mechanics, propulsion systems, and mission analysis for spacecraft design and operation.

## Overview

The repository is divided into the following main modules:

1. **Keplerian Orbit Propagator**: Tools for orbit propagation, eclipse analysis, and ground station contact.
2. **Mass Regression Analysis**: Subsystem mass regression to analyze the relationship between total dry mass and individual subsystem masses.
3. **Mission Analysis Tools**: Key equations for orbital mechanics, propulsion, stability dynamics, and spacecraft design.

## Modules

### [Keplerian Orbit Propagator](./Keplerian-Orbit-Propagator)
- Simulates satellite orbits using Keplerian elements.
- Includes analysis for eclipse duration and ground station contact times.
- Provides both 2D and 3D visualizations of satellite trajectories.

### [Mass Regression Analysis](./Mass-Regression-Analysis)
- Performs linear regression to model relationships between spacecraft subsystem masses and total dry mass.
- Outputs regression equations and R² values, with visualizations for better understanding.

### [Mission Analysis Tools](./Mission-Analysis-Tools)
- Implements key equations for:
  - Orbital mechanics and perturbations (RAAN, argument of perigee precession).
  - Delta-V and propellant requirements.
  - Stability dynamics (gravitational, aerodynamic, and solar radiation pressure torques).
  - Hohmann transfer for orbital maneuvers.
  - Propellant tank design (thickness, mass, and pressurization).

## Getting Started

### Clone the Repository
To use the modules, clone the repository:
```bash
git clone https://github.com/yourusername/Space-Flight-AA131.git
cd Space-Flight-AA131
```

### MATLAB Path
Add the repository to your MATLAB path:
```matlab
addpath(genpath('path_to_repository'))
```

### Dependencies
Ensure MATLAB is installed with access to basic and necessary toolboxes, such as:
- Optimization Toolbox
- Mapping Toolbox (optional for map visualizations)
- Excel file handling capabilities (for `Mass Regression Analysis`).

## Acknowledgments

This project was developed by Brad Yac-Diaz and Omar Abdallah as part of Stanford University's Space-Flight-AA131 course. Special thanks to Professor Simone D'Amico & our TA Jacob Mugume Mukobi for their guidance and instructional resources.
